
clear
close all
format short
file = 'E:/X5_Identification/IdenData2022_12_9_17_6_20.csv';
g = 9.81;

pos1 = readmatrix(file,'Range','A2:A100000')*2*pi/524288;
vel1 = readmatrix(file,'Range','D2:D100000')*2*pi/524288;
cur1 = readmatrix(file,'Range','G2:G100000');

pos2 = readmatrix(file,'Range','B2:B100000')*2*pi/524288 + pi/2;
vel2 = readmatrix(file,'Range','E2:E100000')*2*pi/524288;
cur2 = readmatrix(file,'Range','H2:H100000');

pos3 = readmatrix(file,'Range','C2:C100000')*2*pi/524288;
vel3 = readmatrix(file,'Range','F2:F100000')*2*pi/524288;
cur3 = readmatrix(file,'Range','I2:I100000');
m = length(pos1);
n = 3;
t=0.00118*(1:1:m);

fc = 5;
fs = 200;
[b,a] = butter(2,fc/(fs/2));

sinpos2 = filtfilt(b,a,sin(pos2));
cospos2 = filtfilt(b,a,cos(pos2));
sinpos3 = filtfilt(b,a,sin(pos3));
cospos3 = filtfilt(b,a,cos(pos3));
x3 = filtfilt(b,a,vel3);
y3 = filtfilt(b,a,cur3);
x2 = filtfilt(b,a,vel2);
y2 = filtfilt(b,a,cur2);
x1 = filtfilt(b,a,vel1);
y1 = filtfilt(b,a,cur1);
acc1 = gradient(x1)*1000/1.18;
acc2 = gradient(x2)*1000/1.18;
acc3 = gradient(x3)*1000/1.18;

p = 17;
Hb = zeros(n*m,p);
y = zeros(n*m,1);
q = [pos1,pos2,pos3];
q1 = pos1; q2 = pos2; q3 = pos3;
dq = [x1,x2,x3];
dq1 = x1; dq2 = x2; dq3 = x3;
ddq = [acc1,acc2,acc3];
ddq1 = acc1; ddq2 = acc2; ddq3 = acc3;
for i=1:m
    Hb(3*i-2,:) = [ddq1(i), dq1(i), tanh(10*dq1(i)), 1,...
           ddq1(i)-ddq1(i)*cos(q2(i))^2, 0, (ddq2(i)*sin(q2(i)))/10, 0, 0, 0,...
           ddq1(i)*cos(q3(i))^2 - ddq1(i)*cos(q2(i))^2*cos(q3(i))^2 - ddq2(i)*cos(q3(i))*sin(q2(i))*sin(q3(i)), ddq3(i)*cos(q2(i)) + ddq1(i)*cos(q2(i))^2, (ddq1(i)*sin(q3(i)))/5 + (ddq3(i)*cos(q2(i))*cos(q3(i)))/4 + (ddq2(i)*cos(q3(i))*sin(q2(i)))/10 + (ddq3(i)*cos(q2(i))*sin(q3(i)))/10 + (ddq2(i)*sin(q2(i))*sin(q3(i)))/4 + (ddq1(i)*cos(q2(i))^2*cos(q3(i)))/2, 0,0,0,0];
       
  Hb(3*i-1,:) = [0, 0, 0, 0,...
           0, ddq2(i), (ddq1(i)*sin(q2(i)))/10- g*cos(q2(i)), dq2(i), tanh(10*dq2(i)),1,...
           -ddq1(i)*cos(q3(i))*sin(q2(i))*sin(q3(i)),0,(ddq2(i)*cos(q3(i)))/2 - g*cos(q2(i))*cos(q3(i)) + (ddq1(i)*cos(q3(i))*sin(q2(i)))/10 + (ddq1(i)*sin(q2(i))*sin(q3(i)))/4, 0, 0, 0,0 ];

  Hb(3*i,:) = [0, 0, 0, 0,...
           0, 0, 0, 0, 0, 0,...
           0, ddq3(i) + ddq1(i)*cos(q2(i)), (sin(q3(i))*((ddq1(i)*cos(q2(i)))/10 + g*sin(q2(i))) + (ddq1(i)*cos(q2(i))*cos(q3(i)))/4), ddq3(i), dq3(i), tanh(10*dq3(i)),1 ];

       
       y(3*i-2) = y1(i);
y(3*i-1) = y2(i);
y(3*i) = y3(i);
end
% Pb = [Ia_1 + L_1zz + L_2yy + m_2/100 + 29*m_3/400; fv_1; fc_1; fo_1;...
%       L_2xx - L_2yy + L_3yy - m_3/16; Ia_2 + L_2zz + L_3yy + m_3/16; l_2x + m_3/4; fv_2; fc_2; fo_2;...
%       L_3xx - L_3yy; L_3zz; l_3x; Ia_3; fv_3; fc_3; fo_3];

omega = eye(3);
Ystar = zeros(n,p);
Hbstar = zeros(n*m,p);
Tstar = zeros(n*m,1);
W = ones(n*m,1);
We = ones(n*m,p);
for iter = 1:10
        
    for i=1:m
        Ystar(1,:) = [ddq1(i), dq1(i), tanh(10*dq1(i)), 1,...
           ddq1(i)-ddq1(i)*cos(q2(i))^2, 0, (ddq2(i)*sin(q2(i)))/10, 0, 0, 0,...
           ddq1(i)*cos(q3(i))^2 - ddq1(i)*cos(q2(i))^2*cos(q3(i))^2 - ddq2(i)*cos(q3(i))*sin(q2(i))*sin(q3(i)), ddq3(i)*cos(q2(i)) + ddq1(i)*cos(q2(i))^2, (ddq1(i)*sin(q3(i)))/5 + (ddq3(i)*cos(q2(i))*cos(q3(i)))/4 + (ddq2(i)*cos(q3(i))*sin(q2(i)))/10 + (ddq3(i)*cos(q2(i))*sin(q3(i)))/10 + (ddq2(i)*sin(q2(i))*sin(q3(i)))/4 + (ddq1(i)*cos(q2(i))^2*cos(q3(i)))/2, 0,0,0,0];
       
        Ystar(2,:) = [0, 0, 0, 0,...
           0, ddq2(i), (ddq1(i)*sin(q2(i)))/10- g*cos(q2(i)), dq2(i), tanh(10*dq2(i)),1,...
           -ddq1(i)*cos(q3(i))*sin(q2(i))*sin(q3(i)),0,(ddq2(i)*cos(q3(i)))/2 - g*cos(q2(i))*cos(q3(i)) + (ddq1(i)*cos(q3(i))*sin(q2(i)))/10 + (ddq1(i)*sin(q2(i))*sin(q3(i)))/4, 0, 0, 0,0 ];

        Ystar(3,:) = [0, 0, 0, 0,...
           0, 0, 0, 0, 0, 0,...
           0, ddq3(i) + ddq1(i)*cos(q2(i)), (sin(q3(i))*((ddq1(i)*cos(q2(i)))/10 + g*sin(q2(i))) + (ddq1(i)*cos(q2(i))*cos(q3(i)))/4), ddq3(i), dq3(i), tanh(10*dq3(i)),1 ];
        
        Hbstar(3*i-2:3*i,:) = (omega)^(-1/2)*Ystar;
        Tstar(3*i-2:3*i) = (omega)^(-1/2)*[y1(i); y2(i); y3(i)];
    end
    Hbstar = We.*Hbstar;
    Tstar = W.*Tstar;
%     cond(Hbstar)
    x_ls =(Hbstar'*Hbstar)\Hbstar'*Tstar;
    x_ls_var = diag(inv(Hbstar'*Hbstar));
    y_ls = Hbstar*x_ls;
    R = Tstar - y_ls;
    E(1,:) = R(1:3:end);
    E(2,:) = R(2:3:end);
    E(3,:) = R(3:3:end);
    omega = omega^(1/2)*(E*E')*omega^(1/2)/(m-p);
    W = min(W,TClassHardRedescender(R,3));
    for j=1:p
        We(:,j) = W;
    end
    sum(W)
    cond(omega)
end

figure
plot(W(1:3:end),'r')
hold on
plot(vel1,'k--')

y_ls = Hb*x_ls;
figure
plot(y_ls(1:3:end),'R')
hold on
plot(y1,'k--')
mse1 = mse(y_ls(1:3:end) - y(1:3:end))

figure
plot(y_ls(2:3:end),'R')
hold on
plot(y2,'k--')
mse2 = mse(y_ls(2:3:end) - y(2:3:end))

figure
plot(y_ls(3:3:end),'R')
hold on
plot(y3,'k--')
mse3 = mse(y_ls(3:3:end) - y(3:3:end))

% x_ls2 =pinv(Hb)*y