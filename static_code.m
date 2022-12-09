syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1, L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2, L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 dq1 dq2 dq3 g;
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];

x0 = cos(q(2));
x1 = sin(q(3));
x2 = sin(q(2));
x3 = -g*x2;
x4 = cos(q(3));
x5 = x3*x4;
x6 = parms(38)*x5;
x7 = -x3;
x8 = x1*x7;
x9 = parms(35)*x8 - parms(36)*x5;
x10 = parms(38)*x8;
x11 = -g*x0;
x12 = -x11;
x13 = parms(35)*x12 + parms(37)*x5;
x14 = -x1;
x15 = parms(36)*x11 - parms(37)*x8;
x16 = parms(38)*x11;

static_out(1) = simplify(dq(1)*parms(12) + parms(13)*sign(dq(1)) + parms(14) - 0.1*x0*(parms(24)*x3 + x10*x14 + x4*x6) + x0*(parms(23)*x3 ...
+ 0.25*x1*x6 + 0.25*x10*x4 + x9) + 0.1*x2*(parms(24)*x11 + x16) + x2*(parms(23)*x12 + x13*x14 + x15*x4));
static_out(2) = simplify(dq(2)*parms(26) + parms(21)*x11 + parms(22)*x7 + parms(27)*sign(dq(2)) + parms(28) - x13*x4 + x14*x15 + 0.25*x16);
static_out(3) = simplify(dq(3)*parms(40) + parms(41)*sign(dq(3)) + parms(42) + x9);
static_out