import sympy
import sympybotics

rbtdef = sympybotics.RobotDef('X5',[('pi', 0, 0.25, 'q'),('pi/2', 0, -0.1, 'q'),('-pi/2', 0.25, 0, 'q')], # (alpha, a, d, theta)
                              dh_convention='modified',
                              inertial = 'full',) #full, diag, none
file = open("tau_py.txt",'w',encoding="utf-8")
file2 = open("tau_mat.txt",'w',encoding="utf-8")
file3 = open("H_mat.txt",'w',encoding="utf-8")
rbtdef.frictionmodel = {'Coulomb', 'viscous', 'offset'} # options are None or a combination of 'Coulomb', 'viscous' and 'offset'
rbtdef.gravityacc = sympy.Matrix([0.0, 0.0, -9.81]) # optional, this is the default value
print('parms = ',rbtdef.dynparms(), file=file)
print('parms = ',rbtdef.dynparms(), file=file2)
rbt = sympybotics.RobotDynCode(rbtdef, verbose=True)

# statics_str = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.statics_code, 'static_out', 'static', rbtdef)
# print(statics_str)
rbt.calc_base_parms()
print('baseparms = ',rbt.dyn.baseparms, file=file3)

tau_str = sympybotics.robotcodegen.robot_code_to_func('py', rbt.invdyn_code, 'tau', 'tau', rbtdef)
print(tau_str,file=file)
tau_str2 = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.invdyn_code, 'tau', 'tau', rbtdef)
print(tau_str2,file=file2)

Yr = sympybotics.robotcodegen.robot_code_to_func('jl', rbt.Hb_code, 'H', 'Hb_code', rbtdef)
print(Yr,file=file3) 

file.close()
file2.close()
from builtins import exec
import sympy
from sympy import sin, cos, sign, tanh
L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1 = sympy.symbols('L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1')
L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2 = sympy.symbols('L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2')
L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3 = sympy.symbols('L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3')
q1, q2, q3, dq1, dq2, dq3, ddq1, ddq2, ddq3 = sympy.symbols('q1, q2, q3, dq1, dq2, dq3, ddq1, ddq2, ddq3')
tau = [sympy.Symbol('0')]*3
q = [q1, q2, q3]
dq = [dq1, dq2, dq3]
ddq = [ddq1, ddq2, ddq3]
l = locals()
with open('tau_py.txt', 'r', encoding='utf-8') as f:
    data = f.readlines()
    n = len(data)
    print('read file length: ',n)
    exec(data[0].lstrip())
    i = 0
    while 'x0' not in data[i]:
        i += 1
    print(i)
    while 'return' not in data[i] and i < n:
        exec(data[i].lstrip())
        i += 1

parms = l['parms']
out = sympy.simplify(l['tau'])   
subitems = [L_1xy, L_1xz, L_1yz, L_2xy, L_2xz, L_2yz, L_3xy, L_3xz, L_3yz]
result = open("result_py.txt",'w',encoding="utf-8")
print('tau1 = ',out[0].subs([(x,0) for x in subitems]), '\n',file=result) 
print('tau2 = ',out[1].subs([(x,0) for x in subitems]), '\n',file=result) 
print('tau3 = ',out[2].subs([(x,0) for x in subitems]), '\n',file=result) 
print('tau = ',out)
file.close()