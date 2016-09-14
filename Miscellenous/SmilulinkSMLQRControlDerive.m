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

V_d = 1;
V_q = 0;
syms V_fd Pm real


L = [Ld   0   Lmd  Lmd   0     0;
      0   Lq   0    0    Lmq   Lmq;
      Lmd 0    Lfd  Lmd   0     0
      Lmd 0    Lmd  Lkd   0     0
      0   Lmq  0    0     Lkq1  Lmq
      0   Lmq  0    0     Lmq   Lkq2];

% base frequency

wb = 377;
omega0 = 1;

%Generator Initial Conditions

syms delta omega I_d I_q i_fd i_kd i_kq1 i_kq2 vf Tm V_d V_q real
syms Pm V_fd real
%Transformation matrix
Tm2s = [sin(delta) -cos(delta);
    cos(delta)  sin(delta)];

Tm2sderi = (omega-omega0)*[cos(delta) sin(delta);
                   -sin(delta) cos(delta)];

I_mach = Tm2s\[I_d;I_q];
i_d = I_mach(1); i_q = I_mach(2);
V_mach = Tm2s\[V_d;V_q];
v_d = V_mach(1); v_q = V_mach(2);

I = [i_d;i_q;i_fd; i_kd;i_kq1; i_kq2];

psi = L*I;
  V_kd =0; V_kq1 = 0; V_kq2 =0;
R = diag([Rs;Rs;Rfd;Rkd;Rkq1; Rkq2]);
V = [v_d; v_q; V_fd; V_kd; V_kq1; V_kq2];

ohm = [0 -omega 0 0 0 0;
       omega 0 0 0 0 0;
       zeros(4,6)];

dpsidt =  [V -  R*I - ohm*psi];
dIdt = inv(L)* dpsidt;
Te = (psi(1)*I(2) - psi(2)*I(1));
% Te = (V_d*I_d + V_q*I_q);
ddeltadt = 377*(omega-1);
domegadt = (Pm/omega -Te)/(2*H);
dI_sysdt = 377*((Tm2s)*dIdt(1:2) + Tm2sderi*I(1:2));
xdot = [dI_sysdt;377*dIdt(3:end); ddeltadt; domegadt];

x=[I_d; I_q; i_fd; i_kd; i_kq1; i_kq2; delta;omega];
u=[Pm;V_fd]; 

Jx=jacobian(xdot,x);
Ju=jacobian(xdot,u);
%%
%For finding equilibrium
vd = 1.19997;vq=0.02207; % From Load flow
I=solve([vd*I_d+ vq*I_q ;vq*I_d- vd*I_q] - [1;0.62]); % From Load flow
step1=subs(xdot,[I_d;I_q;V_d;V_q],[I.I_d;I.I_q;vd;vq]);

Equi=solve(step1);
Pm0=Equi.Pm; delta0=Equi.delta; i_kd0=Equi.i_kd; i_fd0=Equi.i_fd; i_kq10=Equi.i_kq1; 
i_kq20=Equi.i_kq2;
omega0=Equi.omega; V_fd0=Equi.V_fd;

%Stable Equilibrium
Pm0s=Pm0(2); delta0s=delta0(2);i_kd0s=i_kd0(2); i_fd0s=i_fd0(2); i_kq10s= i_kq10(2);
i_kq20s= i_kq20(2);
omega0s=omega0(2); V_fd0s=V_fd0(2);

x0s=[I.I_d;I.I_q;i_fd0s;i_kd0s;i_kq10s;i_kq20s;delta0s;omega0s];
As=subs(Jx,x,x0s);
As=subs(As,[V_d;V_q;V_fd;Pm],[vd;vq;V_fd0s;Pm0s]);

Bs=subs(Ju,x,x0s);
Bs=subs(Bs,[V_d;V_q;V_fd;Pm],[vd;vq;V_fd0s;Pm0s]);
As=double(As);Bs=double(Bs);
ks=lqr(As,Bs,diag([1;1;1;1;1;1;1;0.1]),1*diag([1;1]));
Acls=As-Bs*ks;
vpa(eig(Acls),4)
 
%UnStable Equilibrium
Pm0u=Pm0(1); delta0u=delta0(1);i_kd0u=i_kd0(1); i_fd0u=i_fd0(1); i_kq10u= i_kq10(1);
i_kq20u= i_kq20(1);
omega0u=omega0(1); V_fd0u=V_fd0(1);

x0u=[I.I_d;I.I_q;i_fd0u;i_kd0u;i_kq10u;i_kq20u;delta0u;omega0u];
Au=subs(Jx,x,x0u);
Au=subs(Au,[V_d;V_q;V_fd;Pm],[vd;vq;V_fd0u;Pm0u]);

Bu=subs(Ju,x,x0u);
Bu=subs(Bu,[V_d;V_q;V_fd;Pm],[vd;vq;V_fd0u;Pm0u]);
Au=double(Au);Bu=double(Bu);
ku=lqr(Au,Bu,diag([1;1;1;1;1;1;1;1]),diag([1;1]));
Aclu=Au-Bu*ku;
vpa(eig(Aclu),4)

%
% %Start Control design
% Equations = [xdot;vds*Id+ vqs*Iq ;vqs*Id- vds*Iq] - [zeros(9,1);1;0.62];
% x0=[0.8426;-0.5012;0 ;-1.575 ;-0;0.6248;1;1;1/Kt ];
% Jx=jacobian(xdot,x);
% A=subs(Jx,[vds;vqs;vf],[1.19997;0.02207;0.0009]);
% A=subs(A,x,x0);
% 
% r=0.2; Kt = 2542.26;Tg=2.87;Tt= 0.0009;
% Asubs=subs(A);
% Asubs=double(Asubs);
% [v,d]=eig(Asubs);
% wt=inv(v);
% w=transpose(wt);
% pf=abs(v.*w)
% 
% ToSolve=subs(Equations,[vds,vqs,vf],[1.2,0,0.001]);
% ToSolve=vpa(ToSolve,4);
% 
% 
% 
