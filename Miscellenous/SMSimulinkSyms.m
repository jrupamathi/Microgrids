%In rotating reference frame (SImulink model)
%Given machine parameters
syms Rs Ll Lmd Lmq Rfd Llfd Rkd;
syms Llkd Rkq1 Llkq1 H F

%Calculated machine parameters
Ld = Ll + Lmd;
Lq = Ll + Lmq;
Lfd = Llfd + Lmd;
Lkd = Llkd + Lmd;
Lkq1 = Llkq1 + Lmq;
Lkq2 = Llkq1 + Lmq;
syms Rkq2


%Network reference frame stator terminal voltages
syms V_d V_q Pm V_fd omega_b omega_s 

%Rotor reference frame quantities
syms i_d i_q i_fd i_kd i_kq1 i_kq2 delta omega

%Transformation matrix (from network to machine)
Tn2m = [sin(delta) cos(delta);
    -cos(delta)  sin(delta)];
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
dIdt =omega_b*(L\ dpsidt);
%Electromagnetic torque
% Te = (psi(1)*I(2) - psi(2)*I(1));
Te = (v_d*i_d + v_q*i_q);
% plot(t,Te,'b*'); hold on;
%Mechanical state spance
ddeltadt = omega_b*(omega-omega_s);
domegadt = (Pm/omega -Te)/(2*H);
dx = [dIdt; ddeltadt; domegadt];
x = [I;delta;omega];
J = jacobian(dx,x)
%%
syms I_d I_q
Inet = [I_d;I_q];

Tm2n = inv(Tn2m);
Tm2nderi = diff(Tm2n,delta)*ddeltadt;

Imach = Tn2m*Inet;
dITempdt = subs(omega_b*dIdt,[i_d;i_q],[Imach(1);Imach(2)]);

dInetdt = Tm2n*dITempdt(1:2) + Tm2nderi*Imach