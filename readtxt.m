close all
clear 

syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

% parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1,... 
%     L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2,... 
%     L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 g;
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];
ddq = [ddq1 ddq2 ddq3];

data = importdata('tau_mat.txt');
eval(cell2mat(data(1)));
len = length(data);
for i=2:len
    eval(cell2mat(data(i)));
end

% 不要的项替换成0
subitems = [L_1xy, L_1xz, L_1yz, L_2xy, L_2xz, L_2yz, L_3xy, L_3xz, L_3yz];
subzeros = zeros(1,length(subitems));

tau1 = eval('simplify(tau(1))');
tau2 = eval('simplify(tau(2))');
tau3 = eval('simplify(tau(3))');

tau1 = vpa(subs(tau1,subitems,subzeros))
tau2 = vpa(subs(tau2,subitems,subzeros))
tau3 = vpa(subs(tau3,subitems,subzeros))

