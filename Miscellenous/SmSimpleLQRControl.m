function SmSimpleLQRControl
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

t0 = [0;0.8];
xeq0s = [0.8426;-0.5102;0.7886; 0;0;0;-1.827;1];
xeq0m = [0.8426;-0.5102;-0.7886; 0;0;0;1.314;1];

x0 = xeq0s;
% x0(3:6) = zeros(4,1);

V_d = 1;
V_q = 0;
% V_fd = 0.001;
% Pm = 0.8;

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

ks = [-3.1592   -5.5287    4.3839    4.1985    4.5618    4.5618   -4.0977   34.5774
   -6.3697    2.2680    6.9964    6.4240   -3.8143   -3.8143    0.7138  -21.3006];

km = [-3.1592   -5.5287   -4.3839   -4.1985   -4.5618   -4.5618   -4.0977   34.5774
    6.3697   -2.2680    6.9964    6.4240   -3.8143   -3.8143   -0.7138   21.3006];

xeq0s = [0.8426;-0.5102;0.7886; 0;0;0;-1.827;1];
xeq0m = [0.8426;-0.5102;-0.7886; 0;0;0;1.314;1];

Pm0s = 0.985; Pm0u = 0.985;
V_fd0s = 0.0034; V_fd0u = 0.0034;

Pm = -ks(1,:)*(x-xeq0s)+ Pm0s;
V_fd = -ks(2,:)*(x-xeq0s) + V_fd0s;
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
Te = (V_d*I_d + V_q*I_q);
ddeltadt = 377*(omega-1);
domegadt = (Pm -Te)/(2*H);
dI_sysdt = 377*((Tm2s)*dIdt(1:2) + Tm2sderi*I(1:2));
dx = [dI_sysdt;377*dIdt(3:end); ddeltadt; domegadt];

end
save('SMDataNetwork.mat')
end