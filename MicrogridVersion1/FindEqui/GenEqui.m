%SEtting up equations in syms
addpath('../Parameters/')

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','Rkq_G23','RF_G23','H_G23','B_G23')
% load('TL1_2.mat','R_TL1_2','L_TL1_2','C_TL1_2');
H=H_G23;
B = B_G23;
rs=RS_G23;
rr=Rkd_G23;
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
rq = Rkq_G23;
F = B;

syms delta omega iD iF iQ vf Tm vds vqs Id Iq real
syms vds vqs real;

%%base frequency
wb = 377;
omega0 = 1;

%%

% L = [Ld Lad Laf 0 0; Lad LD Ldf 0 0; Laf Ldf LF 0 0; 0 0 0 Lq Laq; 0 0 0 Laq LQ];
% 
% l = inv(L);
% 
% c1 = (l(1,1)+l(4,4))/2;
% c2 = (l(1,1)-l(4,4))/2;
% d1 = (l(1,1)*L(4,4)+l(4,4)*L(1,1))/2;
% d2 = (l(1,1)*L(4,4)-l(4,4)*L(1,1))/2;
% 
% A1 = [rs*c1 0; 0 rs*c1];
% B1 = [d1 0; 0 d1];
% C1 = [rs*c2 0; 0 rs*c2];
% D1 = [d2 0; 0 d2];
% F1 = [-l(1,2)*rr -l(1,3)*rf 0; 0 0 -l(4,5)*rr];
% H1 = [l(4,4)*L(1,2) l(4,4)*L(1,3) 0; 0 0 l(1,1)*L(4,5)];
% M1 = [c1 0; 0 c1];
% N1 = [c2 0; 0 c2];
% K1 = l(1,3);
% 
% C2 = [-l(2,1)*rs 0; -l(3,1)*rs 0; 0 -l(5,4)*rs];
% D2 = [l(5,4)*L(1,1) 0; 0 l(2,1)*L(4,4); 0 l(3,1)*L(4,4)];
% F2 = [-l(2,2)*rr -l(2,3)*rf 0; -l(3,2)*rr -l(3,3)*rf 0; 0 0 -l(5,5)*rr];
% H2 = [ l(5,4)*L(1,2) l(5,4)*L(1,3) 0; 0 0 l(2,1)*L(4,5); 0 0 l(3,1)*L(4,5)];
% N2 = [-l(2,1) 0; -l(3,1) 0; 0 -l(5,4)];
% K2 = [l(2,3); l(3,3); 0];
% 
% 
% %%Generator Initial Conditions
% 
% delta2 = 2*delta;
% 
% Park = [sin(delta) cos(delta); -cos(delta) sin(delta)];
% Rark = [cos(delta2) sin(delta2); sin(delta2) -cos(delta2)];
% Uark = [sin(delta); -cos(delta)];
% Pinv = [sin(delta) -cos(delta); cos(delta) sin(delta)];
% 
% w = [0 omega; -omega 0];
% w3 = [0 omega 0; 0 0 omega; -omega 0 0];
% w_wo = [0 omega-omega0; -(omega-omega0) 0];
% 
% I = [Id; Iq];
% i = [iD; iF; iQ];
% V = [vds; vqs];
% 
% Idot = wb.*((-A1+B1*w+C1*Rark+D1*w*Rark-w_wo)*I...
%                +(Park*F1+Park*w*H1)*i...
%                +(-M1+Rark*N1)*V...
%                -Uark*K1*vf);            
% 
% idot = wb.*((C2*Pinv+w3*D2*Pinv)*I...
%                 +(F2+w3*H2)*i...
%                 +N2*Pinv*V...
%                 -K2*vf);     
% 
% deltadot = wb*(omega-omega0);
% omegadot = 1/2/H*(Tm - B*omega - 1.5*(vds*Id+vqs*Iq));
% x=[delta;omega;I;i];u=[Tm;vf]; 
% xdot = [ deltadot; omegadot; Idot; idot ];
%%
  dIddt=-wb*(iF*((rf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Laf*omega*cos(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Lad*omega*cos(delta))/(Laq^2 - LQ*Lq)) - vds*(LQ/(2*(Laq^2 - LQ*Lq)) + cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Iq*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + iQ*((Laq*rq*cos(delta))/(Laq^2 - LQ*Lq) - (Laq*omega*sin(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*(rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - vqs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            dIqdt=wb*(iF*((rf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Laf*omega*sin(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Lad*omega*sin(delta))/(Laq^2 - LQ*Lq)) - vqs*(cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Id*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - iQ*((Laq*rq*sin(delta))/(Laq^2 - LQ*Lq) + (Laq*omega*cos(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*(rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + vds*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diDdt=wb*(Iq*((rs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*((rs*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vqs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vds*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Laf^2 - LF*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Laq*iQ*omega*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diFdt=-wb*(Id*((rs*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*((rs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vqs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vds*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Laq*iQ*omega*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diQdt=-wb*(Id*((Laq*rs*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*Ld*omega*sin(delta))/(Laq^2 - LQ*Lq)) + Iq*((Laq*rs*sin(delta))/(Laq^2 - LQ*Lq) - (Laq*Ld*omega*cos(delta))/(Laq^2 - LQ*Lq)) + (Laq*vds*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*vqs*sin(delta))/(Laq^2 - LQ*Lq) - (Lq*iQ*rq)/(Laq^2 - LQ*Lq) + (Lad*Laq*iD*omega)/(Laq^2 - LQ*Lq) + (Laf*Laq*iF*omega)/(Laq^2 - LQ*Lq));
            ddeltadt=wb*(omega - omega0);
            domegadt=-(Id*vds - Tm +F*omega + Iq*vqs)/(2*H);
x=[delta;omega;Id;Iq;iD;iF;iQ];u=[Tm;vf]; 
 xdot = [ ddeltadt; domegadt; dIddt; dIqdt; diDdt; diFdt; diQdt];
%%
 Jx=jacobian(xdot,x);
Ju=jacobian(xdot,u);

%For finding equilibrium
% Vmag = 1.045; Vang = 0*pi/180;%G22
% Vmag = 1.026186524; Vang=0.130162375*pi/180;%G23

% Vmag = 1.018084; Vang = 0*pi/180;%G22
Vmag = 1.00729; Vang=-0.96564*pi/180;%G23

Vdref = Vmag*cos(Vang);
Vqref = Vmag*sin(Vang);
% Pref = 0.1872;%0.508665;%
% Qref = 0.088656;%0.723627;%0.088656;
Pref = 0.1955;%0.865196;
Qref = 0.098394;%;0.43658;

vd = Vdref;vq=Vqref; % From Load flow
I=solve([vd*Id+ vq*Iq ;vq*Id- vd*Iq] - [Pref;Qref]); % From Load flow
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

x0u=[delta0u;omega0u;I.Id;I.Iq;iD0u;iF0u;iQ0u];
Au=subs(Jx,x,x0u);
Au=subs(Au,[vds;vqs;vf],[vd;vq;vf0u]);

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
% A=subs(Jx,[vds;vqs;vf],[1.19997;0.02307;0.0009]);
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
