function SmSimple
%In network reference frame (Simulink model)
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

t0 = [0;5];
x0 = zeros(8,1);
x0(8) = 1;

V_d = 1;
V_q = 0;
V_fd = 0.001;
Pm = 0.8;

[t,x] = ode45(@SimulateExactSM,t0,x0);

function dx = SimulateExactSM(t,x)
I_d = x(1);
I_q = x(2);
i_fd = x(3);
i_kd = x(4);
i_kq1 = x(5);
i_kq2 = x(6);
delta = x(7);
omega = x(8);
t

%Transformation matrix
Tm2s = [sin(delta) -cos(delta);
    cos(delta)  sin(delta)];

Tm2sderi = (omega-1)*[cos(delta) sin(delta);
                   -sin(delta) cos(delta)];

I_mach = Tm2s\[I_d;I_q];
i_d = I_mach(1); i_q = I_mach(2);
V_mach = Tm2s\[V_d;V_q];
v_d = V_mach(1); v_q = V_mach(2);

I = [i_d;i_q;i_fd; i_kd;i_kq1; i_kq2];

    %i_d i_q i_fd i_kd i_kq1 i_kq2
L = [Ld   0   Lmd  Lmd   0     0;
      0   Lq   0    0    Lmq   Lmq;
      Lmd 0    Lfd  Lmd   0     0
      Lmd 0    Lmd  Lkd   0     0
      0   Lmq  0    0     Lkq1  Lmq
      0   Lmq  0    0     Lmq     Lkq2];
  psi = L*I;
  V_kd =0; V_kq1 = 0; V_kq2 =0;
R = diag([Rs;Rs;Rfd;Rkd;Rkq1; Rkq2]);
V = [v_d; v_q; V_fd; V_kd; V_kq1; V_kq2];

ohm = [0 -omega 0 0 0 0;
       omega 0 0 0 0 0;
       zeros(4,6)];

dpsidt =  [V -  R*I - ohm*psi];
dIdt = inv(L)* dpsidt;
% Te = (psi(1)*I(2) - psi(2)*I(1));
Te = 1.5*(V_d*I_d + V_q*I_q);
ddeltadt = 377*(omega-1);
domegadt = (Pm/omega -Te)/(2*H);
dI_sysdt = 377*((Tm2s)*dIdt(1:2) + Tm2sderi*I(1:2));
dx = [dI_sysdt;dIdt(3:end); ddeltadt; domegadt];

end
save('SMDataNetwork.mat')
end