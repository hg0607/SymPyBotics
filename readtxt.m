close all
clear 

syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1,... 
    L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2,... 
    L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 g;
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];
ddq = [ddq1 ddq2 ddq3];

data = importdata('newfile.txt');
len = length(data);
for i=1:len
    eval(cell2mat(data(i)));
end

eval('tau1 = subs(simplify(tau(1)),[L_1xy, L_1xz, L_1yz, L_2xy, L_2xz, L_2yz, L_3xy, L_3xz, L_3yz],[0, 0, 0, 0, 0, 0, 0, 0, 0])')
eval('tau2 = subs(simplify(tau(2)),[L_1xy, L_1xz, L_1yz, L_2xy, L_2xz, L_2yz, L_3xy, L_3xz, L_3yz],[0, 0, 0, 0, 0, 0, 0, 0, 0])')
eval('tau3 = subs(simplify(tau(3)),[L_1xy, L_1xz, L_1yz, L_2xy, L_2xz, L_2yz, L_3xy, L_3xz, L_3yz],[0, 0, 0, 0, 0, 0, 0, 0, 0])')



