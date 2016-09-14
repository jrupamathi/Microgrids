function SimulinkSMGc
%In rotating reference frame (SImulink model)
%Given machine parameters
Rs = 0.01524;
Ll = 0.08;
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
Rkd = 0.2343;%(Rkd+Rkq1)/2;
Rkq1 = Rkq2;
% Rkq2 = Rkd;

%Network reference frame stator terminal voltages

k = 10; 
T1 = 0.025; T2 = 0.0009; T3 = 0.00574;
Kp = 1; Kd = 0.5; omegaref = 1;

RL = 0.0529; LL = 1;
Pm = 0.8;%Input mechanical power
V_fd = 0.001;%Input field excitation
wb = 377;
omega0 = 1;

t0 = [0;5];
x0 = zeros(11,1);
x0(8) = 0.9;
tic
[t,x] = ode45(@SimulateExactSM,t0,x0);
toc
function dx = SimulateExactSM(t,x)
%Rotor reference frame quantities
i_d = x(1);
i_q = x(2);
i_fd = x(3);
i_kd = x(4);
i_kq1 = x(5);
i_kq2 = x(6);
delta = x(7);
omega = x(8);
Tm = x(9);
x2 = x(10);
x3 = x(11);

V_d = i_d*RL;
V_q = i_q*RL;

% if Tm>1.1
%     Tm = 1.1;
% elseif Tm<0
%     Tm = 0;
% end

%Transformation matrix (from network to machine)
Tn2m = [sin(delta) cos(delta);
    -cos(delta)  sin(delta)];
t
Inet = Tn2m\[i_d;i_q]; I_d = Inet(1); I_q = Inet(2);
% V_d = real((I_d + 1i*I_q)*(RL+ 1i*LL));
% V_q = imag((I_d + 1i*I_q)*(RL+ 1i*LL));

%stator terminal voltages in rotating reference
V_mach = Tn2m*[V_d;V_q]; v_d = V_mach(1); v_q = V_mach(2);

%Current vector in machine reference
I = [i_d;i_q;i_fd; i_kd;i_kq1; i_kq2];

    %i_d i_q i_fd i_kd i_kq1 i_kq2
L = [Ld   0   Lmd  Lmd   0     0;
      0   Lq   0    0    Lmq   Lmq;
      Lmd 0    Lfd  Lmd   0     0
      Lmd 0    Lmd  Lkd   0     0
      0   Lmq  0    0     Lkq1  Lmq
      0   Lmq  0    0     Lmq     Lkq2];
%Flux linkages
psi = L*I;
V_kd =0; V_kq1 = 0; V_kq2 =0;
R = diag([Rs;Rs;Rfd;Rkd;Rkq1; Rkq2]);
V = [v_d; v_q; V_fd; V_kd; V_kq1; V_kq2];

ohm = [0 -omega 0 0 0 0;
       omega 0 0 0 0 0;
       zeros(4,6)];
%Flux derivatives
dpsidt =  [V -  R*I - ohm*psi];
%Current derivatives
dIdt = wb*(L\ dpsidt);
%Electromagnetic torque
% Te = (psi(1)*I(2) - psi(2)*I(1));
Te = (v_d*i_d + v_q*i_q);
% plot(t,Te,'b*'); hold on;
%Mechanical state spance
ddeltadt = wb*(omega-omega0);
domegadt = (Tm -Te)/(2*H);

%Governor control
dTmdt = x3; 
dx3dt = (x2-x3)/T3;
x1 = -Kp*(omega-omegaref) -Kd*(Tm-Te)/(2*H);
dx1dt = -Kp*(Tm-Te)/(2*H);
dx2dt = (x1 + T1*dx1dt-x2)/T2;

% if Tm>1.1
%     Tm = 1.1;
% elseif Tm<0
%     Tm = 0;
% end

dx = [dIdt; ddeltadt; domegadt;dTmdt;dx2dt;dx3dt];
end

save('SMDataRotor1.mat')
end