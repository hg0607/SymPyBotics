clear
close all
format short
file = 'IdenData2022_12_9_17_37_9.csv';
g = 9.81;

syms L_1xx L_1xy L_1xz L_1yy L_1yz L_1zz l_1x l_1y l_1z m_1 Ia_1 fv_1 fc_1 fo_1;
syms L_2xx L_2xy L_2xz L_2yy L_2yz L_2zz l_2x l_2y l_2z m_2 Ia_2 fv_2 fc_2 fo_2;
syms L_3xx L_3xy L_3xz L_3yy L_3yz L_3zz l_3x l_3y l_3z m_3 Ia_3 fv_3 fc_3 fo_3;

pos1 = readmatrix(file,'Range','A2:A100000')*360/524288;
vel1 = readmatrix(file,'Range','D2:D100000')*360/524288;
cur1 = readmatrix(file,'Range','G2:G100000');

pos2 = readmatrix(file,'Range','B2:B100000')*360/524288;
vel2 = readmatrix(file,'Range','E2:E100000')*360/524288;
cur2 = readmatrix(file,'Range','H2:H100000');

pos3 = readmatrix(file,'Range','C2:C100000')*360/524288;
vel3 = readmatrix(file,'Range','F2:F100000')*360/524288;
cur3 = readmatrix(file,'Range','I2:I100000');
n = 3;
m = length(pos1);
t=0.001*(1:1:n);

fc = 5;
fs = 1000;
[b,a] = butter(2,fc/(fs/2));
x3 = filtfilt(b,a,vel3);
y3 = filtfilt(b,a,cur3);
x2 = filtfilt(b,a,vel2);
y2 = filtfilt(b,a,cur2);
x1 = filtfilt(b,a,vel1);
y1 = filtfilt(b,a,cur1);
acc1 = gradient(x1)*1000/1.18;
acc2 = gradient(x2)*1000/1.18;
acc3 = gradient(x3)*1000/1.18;

r = 100;
pb = 24;
Hb_dynamic = zeros(n*m,pb);
H = zeros(m,n*pb);
y = [y1;y2;y3];
q1 = deg2rad(pos1); q2 = deg2rad(pos2+90); q3 = deg2rad(pos3);
dq1 = deg2rad(x1); dq2 = deg2rad(x2); dq3 = deg2rad(x3);
q = [q1 q2 q3];
dq = [dq1 dq2 dq3];
ddq = [acc1 acc2 acc3];

data = importdata('H_mat.txt');
eval(cell2mat(data(1)));
len = length(data);
for i=2:len
    eval(cell2mat(data(i)));
end

for j=1:pb
    Hb_dynamic(:,j) = [H(:,3*j-2); H(:,3*j-1); H(:,3*j)];
    
end
cond(Hb_dynamic)

x_ls_dynamic =(Hb_dynamic'*Hb_dynamic)\Hb_dynamic'*y
save 'x_ls_dynamic.mat' x_ls_dynamic
y_ls_dynamic = Hb_dynamic*x_ls_dynamic;
figure('name','动力学拟合')
subplot(3,1,1)
plot(y1,'k')
hold on
plot(y_ls_dynamic(1:m),'r')
legend('实际值','拟合值')
mse1 = mse(y1 - y_ls_dynamic(1:m))
subplot(3,1,2)
plot(y2,'k')
hold on
plot(y_ls_dynamic(m+1:2*m),'r')
legend('实际值','拟合值')
mse2 = mse(y2 - y_ls_dynamic(m+1:2*m))
subplot(3,1,3)
plot(y3,'k')
hold on
plot(y_ls_dynamic(2*m+1:3*m),'r')
legend('实际值','拟合值')
mse3 = mse(y3 - y_ls_dynamic(2*m+1:3*m))


% A = zeros(24,24);
% A(2,2) = -1;
% A(3,3) = -1;
% A(4,4) = -1;
% A(12,12) = -1;
% A(13,13) = -1;
% A(14,14) = -1;
% A(22,22) = -1;
% A(23,23) = -1;
% A(24,24) = -1;
% myfun = @(x)norm(Hb_dynamic*x - y);
% options = optimoptions(@fmincon,'Algorithm','sqp','MaxIterations',1500,'OptimalityTolerance',1e-8);
% [x,fval] = fmincon(myfun, x_ls_dynamic,[],[],[],[],[],[],[],options)

function y = Matrix(x)
    y = x;
end