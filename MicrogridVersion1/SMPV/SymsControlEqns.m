%SEtting up equations in syms
% saddpath('Parameters/')

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23',...
'LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')
% load('TL1_2.mat','R_TL1_2','L_TL1_2','C_TL1_2');
H=H_G23;
B = B_G23;
rs=RS_G23;
rr=RR_G23;
rf=RF_G23;
Ld=LSd_G23;
LD=LRD_G23;
LF=LF_G23;
Lq=LSq_G23;
LQ=LRQ_G23;
Lad=Lad_G23;
Laf=Laf_G23;
Ldf=Ldf_G23;
Laq=Laq_G23;

L = [Ld Lad Laf 0 0; Lad LD Ldf 0 0; Laf Ldf LF 0 0; 0 0 0 Lq Laq; 0 0 0 Laq LQ];

l = inv(L);

c1 = (l(1,1)+l(4,4))/2;
c2 = (l(1,1)-l(4,4))/2;
d1 = (l(1,1)*L(4,4)+l(4,4)*L(1,1))/2;
d2 = (l(1,1)*L(4,4)-l(4,4)*L(1,1))/2;

A1 = [rs*c1 0; 0 rs*c1];
B1 = [d1 0; 0 d1];
C1 = [rs*c2 0; 0 rs*c2];
D1 = [d2 0; 0 d2];
F1 = [-l(1,2)*rr -l(1,3)*rf 0; 0 0 -l(4,5)*rr];
H1 = [l(4,4)*L(1,2) l(4,4)*L(1,3) 0; 0 0 l(1,1)*L(4,5)];
M1 = [c1 0; 0 c1];
N1 = [c2 0; 0 c2];
K1 = l(1,3);

C2 = [-l(2,1)*rs 0; -l(3,1)*rs 0; 0 -l(5,4)*rs];
D2 = [l(5,4)*L(1,1) 0; 0 l(2,1)*L(4,4); 0 l(3,1)*L(4,4)];
F2 = [-l(2,2)*rr -l(2,3)*rf 0; -l(3,2)*rr -l(3,3)*rf 0; 0 0 -l(5,5)*rr];
H2 = [ l(5,4)*L(1,2) l(5,4)*L(1,3) 0; 0 0 l(2,1)*L(4,5); 0 0 l(3,1)*L(4,5)];
N2 = [-l(2,1) 0; -l(3,1) 0; 0 -l(5,4)];
K2 = [l(2,3); l(3,3); 0];

% base frequency

wb = 377;
omega0 = 1;

% generator inputs

% vf = 0.001;
% Tm = 1;

%Generator Initial Conditions

syms delta omega iD iF iQ vf Tm vds vqs Id Iq
syms Kt a Tt r Tg omegaRef
delta2 = 2*delta;

Park = [sin(delta) cos(delta); -cos(delta) sin(delta)];
Rark = [cos(delta2) sin(delta2); sin(delta2) -cos(delta2)];
Uark = [sin(delta); -cos(delta)];
Pinv = [sin(delta) -cos(delta); cos(delta) sin(delta)];

w = [0 omega; -omega 0];
w3 = [0 omega 0; 0 0 omega; -omega 0 0];
w_wo = [0 omega-omega0; -(omega-omega0) 0];

% Not part of the generator state if load is given
% Id = 0.84257;
% Iq = -0.5011;

I = [Id; Iq];
i = [iD; iF; iQ];
% vd = 1.19997;vq=0.02207; % From Load flow
% vd = 1; vq = 0;
syms vds vqs;
V = [vds; vqs];

Idot = wb.*((-A1+B1*w+C1*Rark+D1*w*Rark-w_wo)*I...
               +(Park*F1+Park*w*H1)*i...
               +(-M1+Rark*N1)*V...
               -Uark*K1*vf);            

idot = wb.*((C2*Pinv+w3*D2*Pinv)*I...
                +(F2+w3*H2)*i...
                +N2*Pinv*V...
                -K2*vf);     

deltadot = wb*(omega-omega0);
omegadot = 1/2/H*(Tm - B*omega - 1.5*(vds*Id+vqs*Iq));
% Tmdot = (-Tm + Kt*a)/Tg;
% adot = -(r*a+Kp*(omega-omegaRef))/Tt;
% x=[I;i;delta;omega];u=[Tm;vf];
x=[delta;omega;I;i];u=[Tm;vf]; 
% xdot = [ Idot; idot;deltadot; omegadot];%Tmdot;adot];
xdot = [ deltadot; omegadot; Idot; idot ];
y = V;
Jx=jacobian(xdot,x);
Jy = jacobian(xdot,y);
Ju=jacobian(xdot,u);
%%
%For finding equilibrium
% vd = 1;vq=0; % From Load flow
% I=solve(1.5*[vd*Id+ vq*Iq ;vq*Id- vd*Iq] - [-3.5/4;-0.2/4]); % From Load flow
clear I
I.Id = -0.1; I.Iq = -0.0095; vd = 1; vq = 0;
step1=subs(xdot,[Id;Iq;vds;vqs],[I.Id;I.Iq;vd;vq]);
Equi=solve(step1);
Tm0=Equi.Tm; delta0=Equi.delta; iD0=Equi.iD; iF0=Equi.iF; iQ0=Equi.iQ; 
omega0=Equi.omega; vf0=Equi.vf;

%Stable Equilibrium
Tm0s=Tm0(2); delta0s=delta0(2);iD0s=iD0(2); iF0s=iF0(2); iQ0s= iQ0(2);
omega0s=omega0(2); vf0s=vf0(2);
x0s=[delta0s;omega0s;I.Id;I.Iq;iD0s;iF0s;iQ0s];
As=subs(Jx,x,x0s);
As=subs(As,[vds;vqs;vf],[vd;vq;vf0s])

Asy=subs(Jy,x,x0s);
Asy=subs(Asy,[vf],[vf0s])


Bs=subs(Ju,x,x0s);
Bs=subs(Bs,[vds;vqs;vf],[vd;vq;vf0s])
As=double(As);Bs=double(Bs);

ks=lqr(As,Bs,diag([1;1;1;1;1;1;1]),1*diag([1;1]));

Acls=As-Bs*ks;
vpa(eig(Acls),4)
 %%
%UnStable Equilibrium
Tm0u=Tm0(1); delta0u=delta0(1);iD0u=iD0(1); iF0u=iF0(1); iQ0u= iQ0(1);
omega0u=omega0(1); vf0u=vf0(1);


x0u=[I.Id;I.Iq;iD0u;iF0u;iQ0u;delta0u;omega0u];
Au=subs(Jx,x,x0u);
Au=subs(Au,[vds;vqs;vf],[vd;vq;vf0u]);

Auy=subs(Jy,x,x0u);
Auy=subs(Auy,[vds;vqs;vf],[vd;vq;vf0u]);

Bu=subs(Ju,x,x0u);
Bu=subs(Bu,[vds;vqs;vf],[vd;vq;vf0u]);
Au=double(Au);Bu=double(Bu);
ku=lqr(Au,Bu,diag([1;1;1;1;1;1;1]),diag([1;1]));
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
