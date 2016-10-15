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

t0 = [0;12];
x0 = zeros(8,1);
x0(8) = 1;
Pm = 1;
V_d = 1;
V_q = 0;
V_fd = 0.001;

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

%Transformation matrix
Ts2m = [cos(delta) -sin(delta);
    sin(delta)  cos(delta)];
V_mach = Ts2m*[1;0]; V_d = V_mach(1); V_q = V_mach(2);
V_d =1 ; V_q = 0;
% Tm2s = inv(Ts2m);
I_sys = Ts2m\[x(1);x(2)];
plot(t,I_sys(1),'b*',t,I_sys(2),'r*');hold on;

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
  V_kd =0; V_kq1 = 0; V_kq2 =0;
R = diag([Rs;Rs;Rfd;Rkd;Rkq1; Rkq2]);
V = [V_d; V_q; V_fd; V_kd; V_kq1; V_kq2];

ohm = [0 -omega 0 0 0 0;
       omega 0 0 0 0 0;
       zeros(4,6)];

dpsidt =  [V -  R*I - ohm*psi];
dIdt = L\ dpsidt;
Te = psi(1)*I(2) - psi(2)*I(1);
ddeltadt = (omega-1);
domegadt = (Pm/omega -Te/3 - F*(omega-1))/(2*H*377);
dx = 377*[dIdt; ddeltadt; domegadt];
end
save('SMData.mat')
end