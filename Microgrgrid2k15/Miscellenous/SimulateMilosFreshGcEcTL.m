function SimulateMilosFreshGcEcTL
%Milos model
H = 0.3222;
F = 0.01322;
rs = 0.01524;
rf = 0.004319;
Rkd = 0.2343;
Rkq = 0.03365;
% rr = (Rkd+Rkq)/2;%0.2343;
% Rkd = rr;
% Rkq = rr;
% Rkq = Rkd;

Ld = 2.89;
LD = 5.465;         
LF = 3.341;
Lq = 1.72;
LQ = 1.8808;         

Lad = 2.81;
Laf = 2.81;
Ldf = 2.81;
Laq = 1.64;

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
wb = 377;
omega0 = 1;

RL = 0.5029;
% K11 = 1;%5.81;
% K12 = 10;%35.517;
% K26 = 1;% -9.8039;

K11 = 5.81;
K12 = 35.517;
K26 =  -9.8039;

delta_ref = 0.6192;
iF_ref = -1.484;
Tm_ref = 1;
vf_ref = 6.4e-4;

CTL = 0.01;
RTL = 0.0099;
LTL = 0.1;% + 0.004;


x0 = zeros(13,1);
x0(2) = 1;
Pm = 0.8;
t0 = [0; 1];
% generator inputs

[t,x]=ode45(@Milosdynamics,t0,x0);

function dx = Milosdynamics(t,x)

delta = x(1);
omega = x(2);
Id = x(3);
Iq = x(4);
iD = x(5);
iF = x(6);
iQ = x(7);
vTLLd = x(8);
vTLLq = x(9);
iTLMd = x(10);
iTLMq = x(11);
vTLRd = x(12);
vTLRq = x(13);

% vf= 0.001;%%x(14);
t

Tm = Tm_ref - K11*(delta - delta_ref) - K12*(omega - omega0);
vf = vf_ref - K26*(iF - 1.1*iF_ref);% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);

delta2 = 2*(delta);
 vds = Id*RL; vqs = Iq*RL;
Park = [sin(delta) cos(delta); -cos(delta) sin(delta)];
Rark = [cos(delta2) sin(delta2); sin(delta2) -cos(delta2)];
Uark = [sin(delta); -cos(delta)];
Pinv = [sin(delta) -cos(delta); cos(delta) sin(delta)];
w = [0 omega; -omega 0];
w3 = [0 omega 0; 0 0 omega; -omega 0 0];
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
omegadot = (Tm - Te)/(2*H);

iInLd = Id; iInLq = Iq;
iInRd = vTLRd/RL; iInRq = vTLRq/RL;
%TL dynamics
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + omega0*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - omega0*vTLRd;

dx = [deltasdot; omegadot; Idot; idot;dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt];
end
save('MilosData1.mat');
end