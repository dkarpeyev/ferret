[Mesh]
  file = poissonstripe_coarse.e
  uniform_refine=2
[]
[Variables]
#active='polar_x polar_y polar_z'
  [./polar_x]
    #scaling=1e-3
    order = FIRST
    family = LAGRANGE
    block='interior'
  [../]
  [./polar_y]
    #scaling=1e-3
    order = FIRST
    family = LAGRANGE
    block='interior'
  [../]
  [./polar_z]
    #scaling=1e-3
    order = FIRST
    family = LAGRANGE
    block='interior'
  [../]
  [./potential]
    scaling=1e7
    order=FIRST
    family = LAGRANGE
  [../]
  # [./polar_x]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   #block='interior'
  # [../]
  # [./polar_y]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   #block='interior'
  # [../]
  # [./polar_z]
  #   order = CONSTANT
  #   family = MONOMIAL
  #   #block='interior'
  # [../]
[]

[AuxVariables]
  [./auxv_es_energy_density_e] #es for electrostatic
     order=CONSTANT
     family=MONOMIAL
  [../]
  [./auxv_es_energy_density_cross]
     order=CONSTANT
     family=MONOMIAL
  [../]
  [./auxv_es_energy_density_total]
     order=CONSTANT
     family=MONOMIAL
  [../]
  [./auxv_bulk_energy_density]
     order=CONSTANT
     family=MONOMIAL
  [../]
[]

[GlobalParams]
  #len_scale=1e-7
   #alpha1=-3.4e8 # 3.8(T-479)*10^5 C^{-2}m^2
   alpha1=2.0e8
   #alpha1=0 # 3.8(T-479)*10^5 C^{-2}m^2
   alpha11=-3.0e8
   #alpha11=-7.3e7
   #alpha111=2.6e8
   alpha111=1.0e8
   #alpha12=7.5e8
   alpha12=-6.0e8
   #alpha112=6.1e8
   alpha112=3.0e8
   #alpha123=-3.7e9
   alpha123=6.0e8
   #G110=1.73e4
   G110=0
   G11/G110=0.6
   G12/G110=0.0
   G44/G110=0.3
   G44P/G110=0.3
   permittivity=8.85e-12
   polar_x=polar_x
   polar_y=polar_y
   polar_z=polar_z
   potential=potential
[]

[AuxKernels]
  #active='diff'
  [./auxk_electrostatic_energy_density_e]
    type =ElectrostaticEnergyDensityE
    variable =auxv_es_energy_density_e
  [../]
  [./auxk_electrostatic_energy_density_cross]
    type =ElectrostaticEnergyDensityCross
    variable =auxv_es_energy_density_cross
  [../]
  [./auxk_electrostatic_energy_density_total]
    type =ElectrostaticEnergyDensityTotal
    variable =auxv_es_energy_density_total
  [../]
  [./auxk_bulk_energy_density]
    type =BulkEnergyDensity
    variable =auxv_bulk_energy_density
  [../]
[]

[Kernels]
 #active='bed_x bed_y bed_z walled_x walled_y walled_z diffusion_E polar_x_time polar_y_time polar_z_time potential_time'
  active='bed_x bed_y bed_z diffusion_E polar_electric_E polar_electric_px polar_electric_py polar_electric_pz polar_x_time polar_y_time polar_z_time'
  [./bed_x]
    type = BulkEnergyDerivative
    variable = polar_x
    component=0
  [../]
  [./bed_y]
    type = BulkEnergyDerivative
    variable = polar_y
    component=1
  [../]
  [./bed_z]
    type = BulkEnergyDerivative
    variable = polar_z
    component=2
  [../]
  [./walled_x]
     type=WallEnergyDerivative
     variable=polar_x
     component=0
  [../]
  [./walled_y]
     type=WallEnergyDerivative
     variable=polar_y
     component=1
  [../]
  [./walled_z]
     type=WallEnergyDerivative
     variable=polar_z
     component=2
  [../]
  [./polar_electric_E]
     type=PolarElectricE
     variable=potential
     block='interior'
  [../]
  [./diffusion_E]
     type=ElectricStatics
     variable=potential
     block='exterior interior'
  [../]
  [./polar_electric_px]
     type=PolarElectricP
     variable=polar_x
     component=0
  [../]
  [./polar_electric_py]
     type=PolarElectricP
     variable=polar_y
     component=1
  [../]
  [./polar_electric_pz]
     type=PolarElectricP
     variable=polar_z
     component=2
  [../]
  [./polar_x_time]
     type=TimeDerivative
     variable=polar_x
  [../]
  [./polar_y_time]
     type=TimeDerivative
     variable=polar_y
  [../]
  [./polar_z_time]
     type=TimeDerivative
     variable=polar_z
  [../]
  # [./potential_time]
  #    type=TimeDerivative
  #    variable=potential
  # [../]
[]

[ICs]
  #active='polar_x_function_ic polar_y_function_ic polar_z_function_ic'
  active='polar_x_constic polar_y_constic polar_z_constic'
  #active='polar_x_function_ic_k2 polar_y_function_ic_k2 polar_z_function_ic_k2'
  #active='polar_x_adhoc polar_y_adhoc polar_z_adhoc'
  #active='polar_x polar_y polar_z'
  #active='polar_x_cont polar_y_cont polar_z_cont potential_cont'
  [./polar_x]
     type=SphereIC
     variable=polar_x
     radial_function=radial
     polar_function=polar
     azimuthal_function=azimuthal
     index=0
  [../]
  [./polar_y]
     type=SphereIC
     variable=polar_y
     radial_function=radial
     polar_function=polar
     azimuthal_function=azimuthal
     index=1
  [../]
  [./polar_z]
     type=SphereIC
     variable=polar_z
     radial_function=radial
     polar_function=polar
     azimuthal_function=azimuthal
     index=2
  [../]
  [./polar_x_constic]
     type=ConstantIC
     variable=polar_x
     value=0.1
  [../]
  [./polar_y_constic]
     type=ConstantIC
     variable=polar_y
     value=0.1
  [../]
  [./polar_z_constic]
     type=ConstantIC
     variable=polar_z
     value=0.8
  [../]
  [./polar_x_function_ic]
    type=FunctionIC
    variable=polar_x
    function=polar_x
  [../]
  [./polar_y_function_ic]
    type=FunctionIC
    variable=polar_y
    function=polar_y
  [../]
  [./polar_z_function_ic]
    type=FunctionIC
    variable=polar_z
    function=polar_z
  [../]
   [./polar_x_function_ic_k2]
    type=FunctionIC
    variable=polar_x
    function=polar_x_k2
  [../]
  [./polar_y_function_ic_k2]
    type=FunctionIC
    variable=polar_y
    function=polar_y_k2
  [../]
  [./polar_z_function_ic_k2]
    type=FunctionIC
    variable=polar_z
    function=polar_z_k2
  [../]
  [./polar_x_adhoc]
    type=AdhocConstIC
    variable=polar_x
    value0=0
    value1=1
  [../]
  [./polar_y_adhoc]
    type=AdhocConstIC
    variable=polar_y
    value0=0
    value1=0
  [../]
  [./polar_z_adhoc]
    type=AdhocConstIC
    variable=polar_z
    value0=1
    value1=0
  [../]
  [./potential_cont]
    type=FunctionIC
    variable=potential
    function=potential_cont
  [../]
  [./polar_x_cont]
    type=FunctionIC
    variable=polar_x
    function=polar_x_cont
  [../]
  [./polar_y_cont]
,    type=FunctionIC
    variable=polar_y
    function=polar_y_cont
  [../]
  [./polar_z_cont]
    type=FunctionIC
    variable=polar_z
    function=polar_z_cont
  [../]
[]

[BCs]
 # active ='Periodic'
  [./potential_upz]
    type = DirichletBC
    variable = potential
    boundary = 'upz'
    value = 0
    #implicit=false
  [../]
  [./potential_downz]
    type = DirichletBC
    variable = potential
    boundary = 'downz'
    value = 0
    #implicit=false
  [../]
  [./Periodic]
    #active='polar_x_x polar_y_x polar_z_x polar_x_y polar_y_y polar_z_y'
    [./potential_x]
       variable = potential
       primary = 'downx'
       secondary = 'upx'
       translation = '1 0 0'
       #implicit=false
    [../]
    [./polar_x_x]
       variable = polar_x
       primary = 'downx'
       secondary = 'upx'
       translation = '1 0 0'
       #implicit=false
    [../]
    [./polar_y_x]
       variable = polar_y
       primary = 'downx'
       secondary = 'upx'
       translation = '1 0 0'
       #implicit=false
    [../]
    [./polar_z_x]
       variable = polar_z
       primary = 'downx'
       secondary = 'upx'
       translation = '1 0 0'
       #implicit=false
    [../]
    [./potential_y]
       variable = potential
       primary = 'downy'
       secondary ='upy'
       translation = '0 1 0'
       #implicit=false
    [../]
    [./polar_x_y]
       variable = polar_x
       primary = 'downy'
       secondary ='upy'
       translation = '0 1 0'
       #implicit=false
    [../]
    [./polar_y_y]
       variable = polar_y
       primary = 'downy'
       secondary ='upy'
       translation = '0 1 0'
       #implicit=false
    [../]
    [./polar_z_y]
       variable = polar_z
       primary = 'downy'
       secondary ='upy'
       translation = '0 1 0'
       #implicit=false
    [../]
  [../]
[]
[Preconditioning]
   [./smp]
     type=SMP   #or SMP
     #off_diag_row='var_name'
     #off_diag_column='var_name'
     full=true   #to use every off diagonal block
     pc_side=left
     #petsc_options='snes_mf_operator'
     #petsc_options_iname = '-pc_type -mat_fd_coloring_err -mat_fd_type'
     #petsc_options_value = 'lu       1e-6                 ds'
   [../]
[]

[Executioner]
  #type = Steady
  type=Transient
  scheme=implicit-euler     #"implicit-euler, explicit-euler, crank-nicolson, bdf2, rk-2"
  dt=1e-11
  nl_max_its=1000
  num_steps=100
  #petsc_options="-snes_monitor -snes_converged_reason -ksp_monitor -ksp_converged_reason"
 # petsc_options='-snes_monitor -snes_converged_reason -ksp_monitor -ksp_converged_reason'
  petsc_options='-snes_monitor -snes_view -snes_converged_reason  -ksp_monitor -ksp_monitor_true_residual -snes_linesearch_monitor'
  petsc_options_iname='-snes_max_it -snes_rtol -snes_max_funcs -ksp_type  -ksp_rtol -ksp_gmres_restart -pc_type -snes_linesearch_type'
  petsc_options_value='10000000         1e-7     100000000      gmres    1e-8       1000                 asm       basic'
  #petsc_options_iname='-snes_rtol'
  #petsc_options_value='1e-16'
[]
[Functions]
  [./radial]
  type=SolutionFunction
  solution=random
  from_variable=radial
  [../]
  [./azimuthal]
  type=SolutionFunction
  solution=random
  from_variable=azimuthal_angle   #the variable in the file to be read in
  [../]
  [./polar]
  type=SolutionFunction
  solution=random
  from_variable=polar_angle   #the variable in the file to be read in
  [../]
  [./polar_x]
  type=SphereToCartFunc
  radial_function=radial
  polar_function=polar
  azimuthal_function=azimuthal
  index=0
  [../]
  [./polar_y]
  type=SphereToCartFunc
  radial_function=radial
  polar_function=polar
  azimuthal_function=azimuthal
  index=1
  [../]
  [./polar_z]
  type=SphereToCartFunc
  radial_function=radial
  polar_function=polar
  azimuthal_function=azimuthal
  index=2
  [../]
  [./polar_x_cont]
  type=SolutionFunction
  solution=continuation
  from_variable=polar_x
  [../]
  [./polar_y_cont]
  type=SolutionFunction
  solution=continuation
  from_variable=polar_y
  [../]
  [./polar_z_cont]
  type=SolutionFunction
  solution=continuation
  from_variable=polar_z
  [../]
  [./potential_cont]
  type=SolutionFunction
  solution=continuation
  from_variable=potential
  [../]
[]

[UserObjects]
  [./level_1]
    type=SolutionUserObject
    mesh=initvalues_radial_1.e
    variables='radial azimuthal_angle polar_angle polar_x polar_y polar_z'
    timestep=1
  [../]
  [./level_2]
    type=SolutionUserObject
    mesh=initvalues_radial_1_level2.e
    variables='radial azimuthal_angle polar_angle polar_x polar_y polar_z'
    timestep=1
  [../]
  [./random]
    type=SolutionUserObject
    mesh=initvalues_random.e
    variables='radial azimuthal_angle polar_angle'
    timestep=1
  [../]
  [./continuation]
    type=SolutionUserObject
    mesh=ex_all_random_varG_time_out.e
    variables='potential polar_x polar_y polar_z'
    timestep=400
  [../]
[]

[Postprocessors]
  [./bulk_energy]
    type=BulkEnergy
   [../]
   [./wall_energy]
    type=WallEnergy
   [../]
   [./electric_energy]
    type=ElectricEnergy
    [../]
    [./total_energy]
    type=TotalEnergy
    bulk_energy=bulk_energy
    wall_energy=wall_energy
    electric_energy=electric_energy
    [../]
[]

[Output]
  #file_base = out
  output_initial=1
  #interval = 1
  exodus = true
  perf_log = true
[]
[Debug]
  show_actions=true
[]