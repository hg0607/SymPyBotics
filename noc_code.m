syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

parms = [L_1xx, L_1yy, L_1zz, l_1x, l_1y, l_1z, m_1, Ia_1, fv_1, fc_1, fo_1, L_2xx, L_2yy, L_2zz, l_2x, l_2y, l_2z, m_2, Ia_2, fv_2, fc_2, fo_2, L_3xx, L_3yy, L_3zz, l_3x, l_3y, l_3z, m_3, Ia_3, fv_3, fc_3, fo_3];
syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 g;
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];
ddq = [ddq1 ddq2 ddq3];

x0 = sin(q(2));
    x1 = -ddq(1);
    x2 = cos(q(2));
    x3 = -0.1*x0*x1 - g*x2;
    x4 = ddq(1)*x0;
    x5 = cos(q(3));
    x6 = -ddq(2);
    x7 = sin(q(3));
    x8 = x4*x5 + x6*x7;
    x9 = ddq(1)*x2;
    x10 = 0.25*x9;
    x11 = -g*x0 + 0.1*x1*x2;
    x12 = -x11;
    x13 = x10*x5 + x12*x7;
    x14 = 0.25*ddq(2) + x3;
    x15 = parms(23)*x8 + parms(27)*x14 - parms(28)*x13;
    x16 = x10*x7 + x11*x5;
    x17 = -x4;
    x18 = x17*x7 + x5*x6;
    x19 = parms(24)*x18 - parms(26)*x14 + parms(28)*x16;
    x20 = -x7;
    x21 = -parms(26)*x18 + parms(27)*x8 + parms(29)*x14;
    x22 = ddq(3) + x9;
    x23 = -parms(27)*x22 + parms(28)*x18 + parms(29)*x16;
    x24 = parms(26)*x22 - parms(28)*x8 + parms(29)*x13;
    x25 = parms(25)*x22 + parms(26)*x13 - parms(27)*x16;

    noc_out(1) = simplify(ddq(1)*parms(3) + ddq(1)*parms(8) + dq(1)*parms(9) + parms(10)*sign(dq(1)) + parms(11) + 0.1*x0*(ddq(2)*parms(15) + parms(17)*x17 + parms(18)*x3 + x21) + x0*(parms(12)*x4 - parms(17)*x3 + x15*x5 + x19*x20) + x2*(parms(13)*x9 + parms(17)*x11 + 0.25*x23*x7 + 0.25*x24*x5 + x25) - 0.1*x2*(parms(16)*x6 + parms(17)*x9 + parms(18)*x11 + x20*x24 + x23*x5));
    noc_out(2) = simplify(ddq(2)*parms(14) + ddq(2)*parms(19) + dq(2)*parms(20) + parms(15)*x3 + parms(16)*x12 + parms(21)*sign(dq(2)) + parms(22) + x15*x20 - x19*x5 + 0.25*x21);
    noc_out(3) = simplify(ddq(3)*parms(30) + dq(3)*parms(31) + parms(32)*sign(dq(3)) + parms(33) + x25);
    
A = noc_out(1)
B = noc_out(2)
C = noc_out(3)

Pb = [Ia_1 + L_1zz + L_2yy + m_2/100 + 29*m_3/400; fv_1; fc_1; fo_1;...
      L_2xx - L_2yy + L_3yy - m_3/16; Ia_2 + L_2zz + L_3yy + m_3/16; l_2x + m_3/4; l_2y; fv_2; fc_2; fo_2;...
      L_3xx - L_3yy; L_3zz; l_3x; l_3y; l_3z; Ia_3; fv_3; fc_3; fo_3];

  Hb(1,:) = [ddq1, dq1, sign(dq1),1,...
           ddq1-ddq1*cos(q2)^2, 0, (ddq2*sin(q2))/10, (ddq2*cos(q2))/10, 0, 0, 0,...
           ddq1*cos(q3)^2 - ddq1*cos(q2)^2*cos(q3)^2 - ddq2*cos(q3)*sin(q2)*sin(q3), ddq3*cos(q2) + ddq1*cos(q2)^2, (ddq1*sin(q3))/5 + (ddq3*cos(q2)*cos(q3))/4 + (ddq2*cos(q3)*sin(q2))/10 + (ddq3*cos(q2)*sin(q3))/10 + (ddq2*sin(q2)*sin(q3))/4 + (ddq1*cos(q2)^2*cos(q3))/2, (ddq1*cos(q3))/5 + (ddq3*cos(q2)*cos(q3))/10 + (ddq2*cos(q3)*sin(q2))/4 - (ddq3*cos(q2)*sin(q3))/4 - (ddq2*sin(q2)*sin(q3))/10 - (ddq1*cos(q2)^2*sin(q3))/2, - (ddq1*sin(2*q2))/4 + (cos(q2)*ddq2)/10, 0, 0, 0,0 ];
       
  Hb(2,:) = [0, 0, 0, 0,...
           0, ddq2, (ddq1*sin(q2))/10 - g*cos(q2), (ddq1*cos(q2))/10 + g*sin(q2), dq2, sign(dq2), 1,...
           -ddq1*cos(q3)*sin(q2)*sin(q3),0,(ddq2*cos(q3))/2 - g*cos(q2)*cos(q3) + (ddq1*cos(q3)*sin(q2))/10 + (ddq1*sin(q2)*sin(q3))/4, (ddq1*cos(q3)*sin(q2))/4 - (ddq2*sin(q3))/2 + g*cos(q2)*sin(q3) - (ddq1*sin(q2)*sin(q3))/10, (ddq1*cos(q2))/10 + g*sin(q2), 0, 0, 0,0 ];

  Hb(3,:) = [0, 0, 0, 0,...
           0, 0, 0, 0, 0, 0, 0,...
           0, ddq3 + ddq1*cos(q2), (sin(q3)*((ddq1*cos(q2))/10 + g*sin(q2)) + (ddq1*cos(q2)*cos(q3))/4), cos(q3)*((ddq1*cos(q2))/10 + g*sin(q2)) - (ddq1*cos(q2)*sin(q3))/4, 0, ddq3, dq3, sign(dq3),1 ];
       
       
       
       