import sympy
import sympybotics

rbtdef = sympybotics.RobotDef('X5',[('pi', 0, 0.25, 'q'),('pi/2', 0, -0.1, 'q'),('-pi/2', 0.25, 0, 'q')], # (alpha, a, d, theta)
                              dh_convention='modified')

rbtdef.frictionmodel = {'Coulomb', 'viscous', 'offset'} # options are None or a combination of 'Coulomb', 'viscous' and 'offset'
rbtdef.gravityacc = sympy.Matrix([0.0, 0.0, -9.81]) # optional, this is the default value
print(rbtdef.dynparms())
rbt = sympybotics.RobotDynCode(rbtdef, verbose=True)

static_str = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.static_code, 'static_out', 'static', rbtdef)
print(static_str)
rbt.calc_base_parms()
print(rbt.dyn.baseparms)

g_str = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.g_code, 'g_out', 'g', rbtdef)
print(g_str)