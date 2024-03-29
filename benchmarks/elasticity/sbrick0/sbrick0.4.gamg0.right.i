[Mesh]
  file = sbrick.e
  displacements = 'disp_x disp_y disp_z'
  uniform_refine = 4
[] # Mesh

[Problem]
  dimNearNullSpace = 6
[]

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
[UserObjects]
  [./RigidModes3DNearNullSpace]
     type=RigidBodyModes3D
     variable = disp_x
     subspace_name = NearNullSpace
     #subspace_indices = '0 1 2 3 4 5'
     #modes = 'trans_x trans_y trans_z rot_x rot_y rot_z'
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

  active = 'anchor_up_Z anchor_dn_Z'

  [./anchor_up_X]
    type = DirichletBC
    variable = disp_x
    boundary = '1'
    value = 0.0
  [../]

  [./anchor_up_Y]
    type = DirichletBC
    variable = disp_y
    boundary = '1'
    value = 0.0
  [../]

  [./anchor_up_Z]
    type = DirichletBC
    variable = disp_z
    boundary = '1'
    value = 2e-6
  [../]

  [./anchor_dn_X]
    type = DirichletBC
    variable = disp_x
    boundary = '2'
    value = 0.0
  [../]

  [./anchor_dn_Y]
    type = DirichletBC
    variable = disp_y
    boundary = '2'
    value = 0.0
  [../]

  [./anchor_dn_Z]
    type = DirichletBC
    variable = disp_z
    boundary = '2'
    value = -2e-6
  [../]

[] # BCs

[Materials]

  [./mycube]
    type = LinearElasticMaterial
    block = '1'
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z

    all_21 = false
    # reading   C_11  C_12  C_13  C_22  C_23  C_33  C_44  C_55  C_66
    # Tetragonal
    #C_ijkl ='1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 6.0e6 0.5e6 0.5e6 1.5e6'
    # Cubic
    C_ijkl ='1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 1.0e6 0.5e6 0.5e6 0.5e6'
    # Isotropic
    # C_ijkl ='1.0e6 0.5e6 0.5e6 1.0e6 0.5e6 1.0e6 0.25e6 0.25e6 0.25e6'
    # Elk original example
    #C_ijkl ='1.0e6 0.0e6 0.0e6 1.0e6 0.0e6 1.0e6 0.5e6 0.5e6 0.5e6'
    # This is a test Cijkl entry to use with all_21 = true
    #C_ijkl ='11.0 12.0 13.0 14.0 15.0 16.0 22.0 23.0 24.0 25.0 26.0 33.0 34.0 35.0 36.0 44.0 45.0 46.0 55.0 56.0 66.0'

    euler_angle_1 = 0.0
    euler_angle_2 = 0.0
    euler_angle_3 = 0.0
  [../]

[] # Materials

[Preconditioning]
  [./smp]
     type = SMP
     full = true
  [../]
[]
[Executioner]

  type = Steady

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'


  petsc_options = '-snes_view -snes_monitor -snes_converged_reason -ksp_converged_reason -options_table -options_left -log_summary'
  petsc_options_iname = '-ksp_type -ksp_pc_side -pc_type -pc_gamg_type  -mg_levels_ksp_max_it -mg_levels_ksp_type -mg_levels_pc_type  -pc_gamg_agg_nsmooths -pc_gamg_threshold -pc_gamg_coarse_eq_limit -mg_coarse_ksp_type -mg_coarse_pc_type -mg_coarse_redundant_pc_type'
  petsc_options_value = '    gmres        right     gamg           agg                      1           chebyshev             jacobi                      1               0.01                      10              preonly          redundant                           lu'


  nl_abs_tol = 1e-12
  nl_rel_tol = 1e-8
  #l_abs_tol  = 1e-12
  #l_rel_tol  = 1e-8
  l_max_its = 30
[] # Executioner

[Output]
  linear_residuals = true
  file_base = sbrick0.4.gamg0.right.out
  interval = 1
  output_initial = true
  elemental_as_nodal = true
  exodus = true
  perf_log = true
[] # Output
