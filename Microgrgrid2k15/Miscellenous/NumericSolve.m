function dx = NumericSolve(x)
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

CTL = 0.01;
LTL = 0.01;
RTL = 0.001;
omega0 = 1;

%Calculated machine parameters
Ld = Ll + Lmd;
Lq = Ll + Lmq;
Lfd = Llfd + Lmd;
Lkd = Llkd + Lmd;
Lkq1 = Llkq1 + Lmq;
Lkq2 = Llkq1 + Lmq;
Rkq2 = 0.03365;
%%
V_fd = 0.001;
Tm  = 0.8;
PPV = 0.1875;
QPV = -1.653;

i_d=x(1); i_q = x(2); i_fd = x(3); i_kd = x(4); i_kq1 = x(5); i_kq2 = x(6);
delta = x(7); omega = x(8);
v_d = x(9); v_q = x(10); iTLMd = x(11); iTLMq = x(12); vTLRd =x(13); vTLRq = x(14);
iPVd = x(15); iPVq = x(16);


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
Te = (psi(2)*I(1) - psi(1)*I(2));
Tm2s = [sin(delta) -cos(delta);
    cos(delta)  sin(delta)];
V_net = Tm2s*[v_d;v_q];
I_net = Tm2s*[i_d;i_q];

V_d = V_net(1); V_q = V_net(2);
I_d = I_net(1); I_q = I_net(2);

% Te = (V_d*I_d + V_q*I_q);
ddeltadt = 377*(omega-1);
domegadt = (Tm -Te)/(2*H);
dx1 = [377*dIdt; ddeltadt; domegadt];
%%

vPVd1 = vTLRd; vPVq1 = vTLRq;
vPVd = vPVd1; vPVq = vPVq1;
RPV = -(vPVd1^2 + vPVq1^2)*PPV/(PPV^2 + QPV^2);
LPV = -(vPVd1^2 + vPVq1^2)*QPV/(PPV^2 + QPV^2);

vTLLd = V_d; vTLLq = V_q;
iInLd = I_d; iInLq = I_q;
iInRd = -iPVd; iInRq = -iPVq;
% vTLRd = 1; vTLRq = 0;
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + omega0*vTLLq;
dvTLRqdt = (iInRq + iTLMq)/CTL - omega0*vTLLd;
            
diPVddt = (vPVd - RPV*iPVd)/LPV + omega0*iPVq;
diPVqdt = (vPVq - RPV*iPVq)/LPV - omega0*iPVd;
            
dx2 = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt; diPVddt;diPVqdt];%delPdt;delQdt]; 


dx = [dx1;dx2];
