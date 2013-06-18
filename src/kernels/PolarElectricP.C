/**
 * @file   PolarElectricP.C
 * @author S. Gu <sgu@anl.gov>
 * @date   Thu May 30 11:59:56 2013
 * 
 * @brief  PolarElectric interaction term-- Polar part;
 * 
 * 
 */

#include "PolarElectricP.h"

class PolarElectricP;

template<>
InputParameters validParams<PolarElectricP>()
{
  InputParameters params = validParams<Kernel>();
  params.addRequiredParam<unsigned int>("component", "An integer corresponding to the direction the variable this kernel acts in. (0 for x, 1 for y, 2 for z)");
  params.addRequiredCoupledVar("potential", "The electric potential variable");
  return params;
}



//Constructor
PolarElectricP::PolarElectricP(const std::string & name, InputParameters parameters)
  :Kernel(name, parameters),
   _component(getParam<unsigned int>("component")),
   _potential_grad(coupledGradient("potential"))
{}



Real
PolarElectricP::computeQpResidual()
{
  return -0.5*_potential_grad[_qp](_component)*_test[_i][_qp];
}

Real
PolarElectricP::computeQpJacobian()
{
  return 0.0;
}

Real
PolarElectricP::computeQpOffDiagJacobian(unsigned int jvar)
{
  if( jvar == coupled("potential") ) 
     return -0.5*_grad_phi[_j][_qp](_component)*_test[_i][_qp];
  else return 0.0;
}