function SmSimple
%In network reference frame
%Given machine parameters
Rs = 0.01524;
Ll = 0.01524;
Lmd = 2.81;
Lmq = 1.64;
Rfd = 0.004319;
Llfd = 0.531;
Rkd = 0.2343;
Llkd = 2.655;
Rkq1 = 0.03365;
Llkq1 = 0.2408;
H = 0.3222;
F = 0.01322;

%Calculated machine parameters
Ld = Ll + Lmd;
Lq = Ll + Lmq;
Lfd = Llfd + Lmd;
Lkd = Llkd + Lmd;
Lkq1 = Llkq1 + Lmq;
Lkq2 = Llkq1 + Lmq;
Rkq2 = 0.03365;

%Governor parameters
T1 = 0.01;
T2 = 0.02;
T3 = 0.2;
T4 = 0.25;
T5 = 0.009;
T6 = 0.0384;
k = 10;

%Exciatation control parameters
Tr = 0.02;
Ka = 200;
Ta = 0.02;
Ke = 1;
Te = 0;
Kf = 0.001;
Tf = 0.1;


t0 = [0;0.02];
% x0 = zeros(8,1);
% x0(8) = 1;
% x0(9) = 0.8;
% x0(9:16) = zeros(8,1);
x0 = [ 0.0099
   -0.0012
    0.3410
    0.0000
    0.0000
    0
    1.4525
    1.0000
    0.8000
         0
         0
         0
         0
    -0.0015
    1.0012
    0.0000];
Vstab = 0;
omegaref = 1;

[t,x] = ode45(@SimulateExactSM,t0,x0);

function dx = SimulateExactSM(t,x)
i_d = x(1);
i_q = x(2);
i_fd = x(3);
i_kd = x(4);
i_kq1 = x(5);
i_kq2 = x(6);
delta = x(7);
omega = x(8);
t
Pm = x(9);
x1 = x(10);
x2 = x(11);
x3 = x(12);
x4 = x(13);

efd = x(14);
xc = x(15);
xd = x(16);

theta = delta-pi/2;
%Transformation matrix
Ts2m = [cos(theta) sin(theta);
    -sin(theta)  cos(theta)];
V_mach = Ts2m*[1;0]; V_d = V_mach(1); V_q = V_mach(2);
% V_d =1 ; V_q = 0;
% Tm2s = inv(Ts2m);
% I_sys = Ts2m\[x(1);x(2)];
% plot(t,I_sys(1),'b*',t,I_sys(2),'r*');hold on;

I = [i_d;i_q;i_fd; i_kd;i_kq1; i_kq2];

    %i_d i_q i_fd i_kd i_kq1 i_kq2
L = [Ld   0   Lmd  Lmd   0     0;
      0   Lq   0    0    Lmq   Lmq;
      Lmd 0    Lfd  Lmd   0     0
      Lmd 0    Lmd  Lkd   0     0
      0   Lmq  0    0     Lkq1  Lmq
      0   Lmq  0    0     Lmq     Lkq2];
%   L = L(1:5,1:5);
  psi = L*I;
  V_fd = efd/Ke;
  V_kd =0; V_kq1 = 0; V_kq2 =0;
R = diag([Rs;Rs;Rfd;Rkd;Rkq1; Rkq2]);
V = [V_d; V_q; V_fd; V_kd; V_kq1; V_kq2];

ohm = [0 -omega 0 0 0 0;
       omega 0 0 0 0 0;
       zeros(4,6)];

dpsidt =  [V -  R*I - ohm*psi];
dIdt = L\ dpsidt;
Te = 1.5*(psi(1)*I(2) - psi(2)*I(1));
ddeltadt = (omega-1);
domegadt = (Pm/omega -Te - F*(omega-1))/(2*H*377);
dx1 = 377*[dIdt; ddeltadt; domegadt];

%Governor control
dPmdt = x1;
dx1dt = (x2-x1)/T6;
dx2dt = (k*T4*x4 + k*x3 - x2)/T5;
dx3dt = x4;
dx4dt = ((omega-omegaref) + T3*domegadt - T1*x4 -x3)/(T1*T2);
dx2 = [dPmdt; dx1dt; dx2dt; dx3dt; dx4dt];

Vt = sqrt(V_d^2 + V_q^2);
%Excitation Controller
xa = Vt - xc -xd + x0(14)/Ka + Vstab;
dxcdt = (Vt - xc)/Tr;
defddt = (Ka*xa - efd)/Ta;
dxddt = (Kf*defddt/Ke - xd)/Tf;
dx3 = [defddt;dxcdt;dxddt];

dx = [377*dx1;dx2;dx3];
end
save('SMData.mat')
end