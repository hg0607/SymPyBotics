syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1, L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2, L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 g;
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];
ddq = [ddq1 ddq2 ddq3];

x0 = sin(q(2));
x1 = ddq(1)*x0;
x2 = -x1;
x3 = sin(q(3));
x4 = -ddq(2);
x5 = cos(q(3));
x6 = x2*x3 + x4*x5;
x7 = cos(q(2));
x8 = ddq(1)*x7;
x9 = 0.25*x8;
x10 = -ddq(1);
x11 = -g*x0 + 0.1*x10*x7;
x12 = x11*x5 + x3*x9;
x13 = x1*x5 + x3*x4;
x14 = -x11;
x15 = x14*x3 + x5*x9;
x16 = ddq(3) + x8;
x17 = parms(31)*x13 + parms(33)*x6 + parms(34)*x16 + parms(35)*x15 - parms(36)*x12;
x18 = parms(35)*x16 - parms(37)*x13 + parms(38)*x15;
x19 = -parms(36)*x16 + parms(37)*x6 + parms(38)*x12;
x20 = -0.1*x0*x10 - g*x7;
x21 = 0.25*ddq(2) + x20;
x22 = parms(29)*x13 + parms(30)*x6 + parms(31)*x16 + parms(36)*x21 - parms(37)*x15;
x23 = -x3;
x24 = parms(30)*x13 + parms(32)*x6 + parms(33)*x16 - parms(35)*x21 + parms(37)*x12;
x25 = -parms(35)*x6 + parms(36)*x13 + parms(38)*x21;

noc_out(1) = simplify(ddq(1)*parms(11) + ddq(1)*parms(6) + dq(1)*parms(12) + parms(13)*sign(dq(1)) + parms(14) + 0.1*x0*(ddq(2)*parms(21) + parms(23)*x2 + parms(24)*x20 + x25) + x0*(ddq(2)*parms(17) + parms(15)*x1 + parms(16)*x8 - parms(23)*x20 + x22*x5 + x23*x24) - 0.1*x7*(parms(22)*x4 + parms(23)*x8 + parms(24)*x11 - x18*x3 + x19*x5) + x7*(ddq(2)*parms(19) + parms(16)*x1 + parms(18)*x8 + parms(23)*x11 + x17 + 0.25*x18*x5 + 0.25*x19*x3));
noc_out(2) = simplify(ddq(2)*parms(20) + ddq(2)*parms(25) + dq(2)*parms(26) + parms(17)*x1 + parms(19)*x8 + parms(21)*x20 + parms(22)*x14 + parms(27)*sign(dq(2)) + parms(28) + x22*x23 - x24*x5 + 0.25*x25);
noc_out(3) = simplify(ddq(3)*parms(39) + dq(3)*parms(40) + parms(41)*sign(dq(3)) + parms(42) + x17);
    
noc_out(1)
noc_out(2)
noc_out(3)