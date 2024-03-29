/**
 * @file   SphereToCartFunc.C
 * @author S. Gu <sgu@anl.gov>
 * @date   Tue Aug 13 15:53:03 2013
 *
 * @brief
 *
 *
 */

#include "SphereToCartFunc.h"
#include<cmath>
template<>
InputParameters validParams<SphereToCartFunc>()
{
  InputParameters params = validParams<Function>();
  params.addRequiredParam<FunctionName>("radial_function", "The function for radial");
  params.addRequiredParam<FunctionName>("polar_function", "The function for polar angle");
  params.addRequiredParam<FunctionName>("azimuthal_function", "The function for polar angle");
  params.addRequiredParam<unsigned int>("index", "which component to pick (0 for the first)");
  return params;
}

SphereToCartFunc::SphereToCartFunc(const std::string & name, InputParameters parameters) :
  Function(name, parameters),
  FunctionInterface(parameters),
  _radial_func(getFunction("radial_function")),
  _polar_func(getFunction("polar_function")),
  _azimuthal_func(getFunction("azimuthal_function")),
  _index(getParam<unsigned int>("index"))
{
  if(_index>2)
  mooseError("ERROR:index must be 0,1,2");
}

Real
SphereToCartFunc::value(Real t, const Point & p)
{
  Real radial=_radial_func.value(t,p);
  Real polar=_polar_func.value(t,p);
  Real azimuthal=_azimuthal_func.value(t,p);
  Real rv;
  switch(_index){
  case 0:
    rv=radial*cos(azimuthal)*cos(polar);
    break;
  case 1:
    rv=radial*cos(azimuthal)*sin(polar);
    break;
  case 2:
    rv=radial*sin(azimuthal);
    break;
  }
  return rv;
}
