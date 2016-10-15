function SimulateMilosFreshGcEcPQLoad
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

CTL = 0.01;
RTL = 0.0099;
LTL = 0.01;% + 0.004;
PL = 0.0742;QL = 0.0419;
% RL = 9.72;
% LL = 5.48;
% rs = rs + RL;
% Ld = Ld + LL;

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

% RL = 0.5029;
% K11 = 1;%5.81;
% K12 = 10;%35.517;
% K26 = 1;% -9.8039;

K11 = 5.81;
K12 = 35.517;
K26 =  -0.1*9.8039;

delta_ref = 0.6192;
iF_ref = -0.02*1.484;
Tm_ref = 1;
vf_ref = 6.4e-4;



x0 = [0.7913
    1.0000
    0.0571
   -0.0555
   -0.0000
   -0.0819
    0.0000
    0.8696
   -0.4438
    0.0526
   -0.0641
    0.8684
   -0.4436
    0.0483
   -0.0729
%    0
   ];
Pm = 0.8;
t0 = [0; 10];
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
iLd = x(14);
iLq = x(15);
% iFInt = x(16);

% vf= 0.001;%%x(14);
t

Tm = Tm_ref - K11*(delta - delta_ref) - K12*(omega - omega0);
vf = vf_ref - K26*(iF - 1.1*iF_ref);%+0.02*iFInt;% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);

% delta =(deltas-pi);
% %Transformation matrix
% Ts2m = [sin(delta) -cos(delta);
%     cos(delta)  sin(delta)];
% V_mach = Ts2m*[vds;vqs]; 
% v_d = V_mach(1); v_q = V_mach(2);

% delta =(deltas-pi);
delta2 = 2*(delta);
 vds = 0;%Id*RL; 
 vqs = 0;%Iq*RL;
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
% 
% Idot = wb.*((-A1+B1*w+C1*Rark+D1*w*Rark-w_wo)*I...
%                 +(Park*F1+Park*w*H1)*i...
%                 +(-M1+Rark*N1)*V...
%                 -Uark*K1*vf);            % Orignal 
% idot = wb.*((C2*Pinv+w3*D2*Pinv)*I...
%                 +(F2+w3*H2)*i...
%                 +N2*Pinv*V...
%                 -K2*vf)      ;   % orignal


            Idot = wb*((-A1+B1*w+C1*Rark+D1*w*Rark-w_wo)*I...
                +(Park*F1+Park*w*H1)*i...
                +(-M1+Rark*N1)*V...
                -Uark*K1*vf); 
           
            
 
            idot = wb*((C2*Pinv+w3*D2*Pinv)*I...
                +(F2+w3*H2)*i...
                +N2*Pinv*V...
                -K2*vf)      ;  

deltasdot =  wb*(omega-omega0);

% Te = 1.5*(psi(1)*I(2) - psi(4)*I(1));
% i_mach = Ts2m*I;
% i_d = i_mach(1); i_q = i_mach(2); 
% psi_mach(1) = L(1,1:5) * [i_mach(1);i(1:2);i_mach(2);i(3)];
% psi_mach(2) = L(2,1:5) * [i_mach(1);i(1:2);i_mach(2);i(3)];
 Te = ((vds*(Id)+vqs*(Iq)));%+ (I(1)^2 + I(2)^2)*rs + (i(1)^2 + i(2)^2 + i(3)^2)*rr;
% Te = v_d*i_d + v_q*i_q;
% plot(t,Te,'b*'); hold on;

%   Te = 1*(psi_mach(1)*i_mach(2) - psi_mach(2)*i_mach(1));
omegadot = (Tm - Te)/(2*H);

iInLd = Id; iInLq = Iq; 
iInRd = -iLd; iInRq = -iLq; 
%Dynamics for TL
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + omega0*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - omega0*vTLRd;

V2 = vTLLd^2 + vTLLq^2;
%Equivalent R and L for Load
RL = PL*V2/(PL^2 + QL^2);
LL = QL*V2/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

diFIntdt = iF-iF_ref;
            
dx = [deltasdot; omegadot; Idot; idot;...
    dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];%diFIntdt];
end
save('MilosData.mat');
end