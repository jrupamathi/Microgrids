syms Ld Lad Laf LD Ldf LF Lq Laq LQ
syms ld lAD lAF lDF lF lq lAQ lQ lD
syms i_d i_q iD iF iQ1 iQ2 delta omega ohm v_d v_q vF
syms rs rD rf rs rQ wb
I = [i_d; iD; iF; i_q; iQ1];

L = [Ld Lad Laf 0 0 0; Lad LD Ldf 0 0 0; Laf Ldf LF 0 0 0; 0 0 0 Lq Laq Laq; 0 0 0 Laq LQ Laq ; 0 0 0 Laq Laq LQ];
% l = [ld lAD lAF 0 0 0;
%     lAD lD lDF 0 0 0;
%     lAF lDF lF 0 0 0;
%     0 0 0 lq lAQ lAQ;
%     0 0 0 lAQ lQ lAQ;
%     0 0 0 lAQ lAQ lQ];
L = L(1:5,1:5);
l=inv(L);
psi = L*I;
ohm = [0 0 0 -omega 0 ;
       0 0 0 0 0 
       0 0 0 0 0 
    omega 0 0 0 0 
    0 0 0 0 0 ];
psi_ohm = ohm*psi;
V = [v_d; 0; vF; v_q; 0];
R = diag([rs; rD; rf; rs; rQ]);

psi_dot = V - R*I - psi_ohm;
i_dot = l*psi_dot
%%
di_ddt = i_dot(1);
di_qdt = i_dot(4);
Tn2m = [sin(delta) cos(delta);
       -cos(delta) sin(delta)];
Tm2n = inv(Tn2m);
syms I_d I_q omega0            
Imach = Tn2m*[I_d; I_q];
Inet = Tm2n*[i_d; i_q];
Inet_dot = simplify(diff(Tm2n,delta))*(omega-omega0)*[i_d;i_q] + Tm2n*[di_ddt;di_qdt];
I_newdot = i_dot;
I_newdot(1) = Inet_dot(1);
I_newdot(4) = Inet_dot(2);
syms V_d V_q
Vmach = Tn2m*[V_d; V_q];

Fin = subs(I_newdot,[i_d;i_q],[Imach(1);Imach(2)])
Fin1=subs(Fin,[v_d;v_q],[Vmach(1);Vmach(2)])

Te = subs((psi(4)*I(1) - psi(1)*I(4)),[i_d;i_q],[Imach(1);Imach(2)])
