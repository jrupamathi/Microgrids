%Milos model
syms H F rs rf Rkd Rkq
syms Ld LD LF Lq LQ
syms Lad Laf Ldf Laq

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
F1 = [-l(1,2)*Rkd -l(1,3)*rf 0; 0 0 -l(4,5)*Rkq];
H1 = [l(4,4)*L(1,2) l(4,4)*L(1,3) 0; 0 0 l(1,1)*L(4,5)];
M1 = [c1 0; 0 c1];
N1 = [c2 0; 0 c2];
K1 = l(1,3);

C2 = [-l(2,1)*rs 0; -l(3,1)*rs 0; 0 -l(5,4)*rs];
D2 = [l(5,4)*L(1,1) 0; 0 l(2,1)*L(4,4); 0 l(3,1)*L(4,4)];
F2 = [-l(2,2)*Rkd -l(2,3)*rf 0; -l(3,2)*Rkd -l(3,3)*rf 0; 0 0 -l(5,5)*Rkq];
H2 = [ l(5,4)*L(1,2) l(5,4)*L(1,3) 0; 0 0 l(2,1)*L(4,5); 0 0 l(3,1)*L(4,5)];
N2 = [-l(2,1) 0; -l(3,1) 0; 0 -l(5,4)];
K2 = [l(2,3); l(3,3); 0];

% base frequency
syms wb omega0 Pm
syms delta omega Id Iq iD iF iQ vf
syms vds vqs

delta2 = 2*(delta);
Park = [sin(delta) cos(delta); -cos(delta) sin(delta)];
Rark = [cos(delta2) sin(delta2); sin(delta2) -cos(delta2)];
Uark = [sin(delta); -cos(delta)];
Pinv = [sin(delta) -cos(delta); cos(delta) sin(delta)];
w = [0 omega; -omega 0];
w3 = [0 omega 0; 0 0 omega; -omega 0 0];
% w_wo = [0 omega-omega0; -(omega-omega0) 0];
 w_wo =[0 omega-omega0; -(omega-omega0) 0];

I = [Id; Iq];
i = [iD; iF; iQ];
V = [vds; vqs];
            Idot = wb*((-A1+B1*w+C1*Rark+D1*w*Rark-w_wo)*I...
                +(Park*F1+Park*w*H1)*i...
                +(-M1+Rark*N1)*V...
                -Uark*K1*vf); 
           
            
 
            idot = wb*((C2*Pinv+w3*D2*Pinv)*I...
                +(F2+w3*H2)*i...
                +N2*Pinv*V...
                -K2*vf)      ;  

deltasdot =  wb*(omega-omega0);

 Te = ((vds*(Id)+vqs*(Iq)));%+ (I(1)^2 + I(2)^2)*rs + (i(1)^2 + i(2)^2 + i(3)^2)*rr;
omegadot = (Pm/omega - Te)/(2*H);


dx = [deltasdot; omegadot; Idot; idot];
