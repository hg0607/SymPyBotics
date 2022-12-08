syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, fv_1, fc_1, fo_1,... 
    L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, fv_2, fc_2, fo_2,... 
    L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 ddq1 ddq2 ddq3 g;
q = [q1 q2 q3];
ddq = [ddq1 ddq2 ddq3];

    x0 = sin(q(2));
    x1 = cos(q(3));
    x2 = ddq(1)*x0;
    x3 = -ddq(2);
    x4 = sin(q(3));
    x5 = x1*x2 + x3*x4;
    x6 = -x2;
    x7 = x1*x3 + x4*x6;
    x8 = cos(q(2));
    x9 = ddq(1)*x8;
    x10 = ddq(3) + x9;
    x11 = -ddq(1);
    x12 = -0.1*x0*x11 - g*x8;
    x13 = 0.25*ddq(2) + x12;
    x14 = -g*x0 + 0.1*x11*x8;
    x15 = -x14;
    x16 = 0.25*x9;
    x17 = x1*x16 + x15*x4;
    x18 = parms(27)*x5 + parms(28)*x7 + parms(29)*x10 + parms(34)*x13 - parms(35)*x17;
    x19 = x1*x14 + x16*x4;
    x20 = parms(28)*x5 + parms(30)*x7 + parms(31)*x10 - parms(33)*x13 + parms(35)*x19;
    x21 = -x4;
    x22 = -parms(34)*x10 + parms(35)*x7 + parms(36)*x19;
    x23 = parms(33)*x10 - parms(35)*x5 + parms(36)*x17;
    x24 = parms(29)*x5 + parms(31)*x7 + parms(32)*x10 + parms(33)*x17 - parms(34)*x19;
    x25 = -parms(33)*x7 + parms(34)*x5 + parms(36)*x13;

    noc_out(1) = simplify(ddq(1)*parms(6) + parms(13) + 0.1*x0*(ddq(2)*parms(20) + parms(22)*x6 + parms(23)*x12 + x25) + x0*(ddq(2)*parms(16) + ...
parms(14)*x2 + parms(15)*x9 - parms(22)*x12 + x1*x18 + x20*x21) - 0.1*x8*(parms(21)*x3 + parms(22)*x9 + parms(23)*x14 + x1*x22 + x21*x23) + ...
x8*(ddq(2)*parms(18) + parms(15)*x2 + parms(17)*x9 + parms(22)*x14 + 0.25*x1*x23 + 0.25*x22*x4 + x24));
    noc_out(2) = simplify(ddq(2)*parms(19) + parms(16)*x2 + parms(18)*x9 + parms(20)*x12 + parms(21)*x15 + parms(26) - x1*x20 + x18*x21 + 0.25*x25);
    noc_out(3) = simplify(parms(39) + x24);
    
noc_out