syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1xy, L_1xz, L_1yy, L_1yz, L_1zz, l_1x, l_1y, l_1z, m_1, fv_1, fc_1, fo_1,... 
    L_2xx, L_2xy, L_2xz, L_2yy, L_2yz, L_2zz, l_2x, l_2y, l_2z, m_2, fv_2, fc_2, fo_2,... 
    L_3xx, L_3xy, L_3xz, L_3yy, L_3yz, L_3zz, l_3x, l_3y, l_3z, m_3, fv_3, fc_3, fo_3];

syms q1 q2 q3 g;
q = [q1 q2 q3];

    x0 = sin(q(2));
    x1 = cos(q(2));
    x2 = -g*x1;
    x3 = -x2;
    x4 = -g*x0;
    x5 = -x4;
    x6 = sin(q(3));
    x7 = x5*x6;
    x8 = parms(34)*x2 - parms(35)*x7;
    x9 = cos(q(3));
    x10 = x4*x9;
    x11 = parms(33)*x3 + parms(35)*x10;
    x12 = -x6;
    x13 = parms(33)*x7 - parms(34)*x10;
    x14 = parms(36)*x10;
    x15 = parms(36)*x7;
    x16 = parms(36)*x2;

    static_out(1) = simplify(parms(13) + 0.1*x0*(parms(23)*x2 + x16) + x0*(parms(22)*x3 + x11*x12 + x8*x9) - 0.1*x1*(parms(23)*x4 + x12*x15 + x14*x9) + x1*(parms(22)*x4 + x13 + 0.25*x14*x6 + 0.25*x15*x9));
    static_out(2) = simplify(parms(20)*x2 + parms(21)*x5 + parms(26) - x11*x9 + x12*x8 + 0.25*x16);
    static_out(3) = simplify(parms(39) + x13);
static_out