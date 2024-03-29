/**
 * @file   ElectrostaticEnergy.C
 * @author S. Gu <sgu@anl.gov>
 * @date   Tue Jul 30 17:09:44 2013
 *
 * @brief
 *
 *
 */

#include "ElectrostaticEnergy.h"

template<>
InputParameters validParams<ElectrostaticEnergy>()
{
  //TODO: inherit from an appropriate postprocessor
  InputParameters params = validParams<ElementIntegralPostprocessor>();
  params.addRequiredCoupledVar("polar_x", "The x component of the polarization");
  params.addRequiredCoupledVar("polar_y", "The y component of the polarization");
  params.addRequiredCoupledVar("polar_z", "The z component of the polarization");
  params.addRequiredCoupledVar("potential_int", "The internal electric potential");
  params.addRequiredCoupledVar("potential_ext", "The external electric potential");
  params.addRequiredParam<Real>("permittivity", "permittivity");
  params.addParam<Real>("len_scale",1.0,"the len_scale of the unit");
  params.addParam<Real>("energy_scale",1.0,"energy scale");
  return params;
}

ElectrostaticEnergy::ElectrostaticEnergy(const std::string & name, InputParameters parameters) :
  ElementIntegralPostprocessor(name, parameters),
  _polar_x(coupledValueOld("polar_x")),
  _polar_y(coupledValueOld("polar_y")),
  _polar_z(coupledValueOld("polar_z")),
  _potential_int_grad(coupledGradient("potential_int")),
  _potential_ext_grad(coupledGradient("potential_ext")),
  _permittivity(getParam<Real>("permittivity")),
  _len_scale(getParam<Real>("len_scale")),
  _energy_scale(getParam<Real>("energy_scale"))
{
}

Real
ElectrostaticEnergy::computeQpIntegral()
{
  RealVectorValue P;
  P(0)=_polar_x[_qp];P(1)=_polar_y[_qp];P(2)=_polar_z[_qp];
  return 0.5*(P*_potential_int_grad[_qp])*pow(_len_scale,2.0)+(P*_potential_ext_grad[_qp])*pow(_len_scale,2.0)*_energy_scale;
}
