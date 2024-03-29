# This is an example for a box with 10 grains

[Mesh]
  file = ferret_10grain_example_Tetmesh2.e
  #uniform_refine = 1
  displacements = 'disp_x disp_y disp_z'
[] # Mesh

[Variables]

  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]

  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]

  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]

[] # Variables

[AuxVariables]

  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_yz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./strain_zx]
    order = CONSTANT
    family = MONOMIAL
  [../]

[] # AuxVariables

[TensorMechanics]
  [./solid]
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
  [../]
[]

[AuxKernels]

  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 1
    index_j = 1
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 2
    index_j = 2
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 3
    index_j = 3
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 1
    index_j = 2
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 2
    index_j = 3
  [../]
  [./stress_zx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zx
    index_i = 1
    index_j = 3
  [../]
  [./strain_xx]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_xx
    index_i = 1
    index_j = 1
  [../]
  [./strain_yy]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_yy
    index_i = 2
    index_j = 2
  [../]
  [./strain_zz]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_zz
    index_i = 3
    index_j = 3
  [../]
  [./strain_xy]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_xy
    index_i = 1
    index_j = 2
  [../]
  [./strain_yz]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_yz
    index_i = 2
    index_j = 3
  [../]
  [./strain_zx]
    type = RankTwoAux
    rank_two_tensor = elastic_strain
    variable = strain_zx
    index_i = 1
    index_j = 3
  [../]

[] # AuxKernels


[BCs]

  #active = 'anchor5_Z anchor6_Z'

  #  Box side with the (1,0,0) normal: 

  #  Box side with the (-1,0,0) normal: 

  #  Box side with the (0,1,0) normal: 

  #  Box side with the (0,-1,0) normal: 

  #  Box side with the (0,0,1) normal: 

  [./anchor5_X]
    type = DirichletBC
    variable = disp_x
    boundary = '63'
    value = 0.0
  [../]

  [./anchor5_Y]
    type = DirichletBC
    variable = disp_y
    boundary = '63'
    value = 0.0
  [../]

  [./anchor5_Z]
    type = DirichletBC
    variable = disp_z
    boundary = '63'
    value = 3e-6
  [../]

  #  Box side with the (0,0,-1) normal: 

  [./anchor6_X]
    type = DirichletBC
    variable = disp_x
    boundary = '64'
    value = 0.0
  [../]

  [./anchor6_Y]
    type = DirichletBC
    variable = disp_y
    boundary = '64'
    value = 0.0
  [../]

  [./anchor6_Z]
    type = DirichletBC
    variable = disp_z
    boundary = '64'
    value = -3e-6
  [../]

[] # BCs

[Materials]

  [./grain1]
    type = LinearElasticMaterial
    block = '1'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain2]
    type = LinearElasticMaterial
    block = '2'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain3]
    type = LinearElasticMaterial
    block = '3'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain4]
    type = LinearElasticMaterial
    block = '4'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain5]
    type = LinearElasticMaterial
    block = '5'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain6]
    type = LinearElasticMaterial
    block = '6'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain7]
    type = LinearElasticMaterial
    block = '7'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain8]
    type = LinearElasticMaterial
    block = '8'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain9]
    type = LinearElasticMaterial
    block = '9'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

  [./grain10]
    type = LinearElasticMaterial
    block = '10'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    C_ijkl = '1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

[] # Materials

[Preconditioning]
   active = 'smp'
   [./smp]
   type = SMP
   full = true
   [../]
[]

[Executioner]

  type = Steady
#  petsc_options = '-ksp_monitor'
#  petsc_options_iname = '-ksp_type -pc_type'
#  petsc_options_value = 'gmres lu'

#  type = Transient

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'


  petsc_options = '-snes_monitor -snes_converged_reason -ksp_converged_reason -ksp_view -snes_view'
  petsc_options_iname = '-ksp_type -pc_type -sub_pc_type'
  petsc_options_value = 'gmres asm lu'

  nl_abs_tol = 1e-10
#  l_abs_tol  = 1e-10

  l_max_its = 150

#  start_time = 0.0
#  dt = 1.0
#  num_steps = 2
#  end_time = 2.0
[] # Executioner

[Output]
  linear_residuals = true
  file_base = out_grain10_example_uniax_uniform
#  file_base = out_grain10_example_uniax_uniform_mesh_ref1
  interval = 1
  output_initial = true
  elemental_as_nodal = true
  exodus = true
  perf_log = true
[] # Output
