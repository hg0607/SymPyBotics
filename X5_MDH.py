import sympy
import sympybotics

rbtdef = sympybotics.RobotDef('X5',[('pi', 0, 0.25, 'q'),('pi/2', 0, -0.1, 'q'),('-pi/2', 0.25, 0, 'q')], # (alpha, a, d, theta)
                              dh_convention='modified',
                              inertial = 'full') #full, diag, none

rbtdef.frictionmodel = {'Coulomb', 'viscous', 'offset'} # options are None or a combination of 'Coulomb', 'viscous' and 'offset'
rbtdef.gravityacc = sympy.Matrix([0.0, 0.0, -9.81]) # optional, this is the default value
print('parms: ', rbtdef.dynparms())
rbt = sympybotics.RobotDynCode(rbtdef, verbose=True)

statics_str = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.statics_code, 'static_out', 'static', rbtdef)
print(statics_str)
rbt.calc_base_parms()
print('baseparms:',rbt.dyn.baseparms)

data = open("newfile.txt",'w',encoding="utf-8")
tau_str = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.invdyn_code, 'tau', 'tau', rbtdef)
print(tau_str,file=data)

# Yr = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.Hb_code, 'H', 'Hb_code', rbtdef)
# print(Yr) 