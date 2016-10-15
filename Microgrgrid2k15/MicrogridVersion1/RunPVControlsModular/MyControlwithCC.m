function PVRLLoad
% generator parameters

addpath('../Parameters')
set(0,'defaultlinelinewidth',1.5)

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

% K1_G23 = 3.3713; K2_G23 = 38.5757; K3_G23 = -0.3292;
% K1_G22 = 0.5568; K2_G22 = 6.8132; K3_G22 = -0.3893;

K1_G23 = 0.8808; K2_G23 = 12.8569; K3_G23 = -0.9281;
K1_G22 = 1.9259; K2_G22 = 23.1891; K3_G22 = -0.1457;

load('L1.mat', 'RL_L1', 'LL_L1');
load('L21.mat', 'RL_L21', 'LL_L21');
load('L22.mat', 'RL_L22', 'LL_L22');
load('L23.mat', 'RL_L23', 'LL_L23');
load('PV21.mat', 'RL_PV21', 'LL_PV21');
% LL_PV21 = -0.9;

load('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
load('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
load('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

dphidt = 1;

x0 = [0.828269
     0.380941
     0.171494
    -0.207645
 -0.000223893
  0.000275205
    -0.563425
     0.488893
      1.00012
    0.0967286
     -0.25228
 -0.000311012
  0.000535032
    -0.550412
     0.322612
      1.00003
     0.181737
     0.013807
     0.181737
     0.013807
     0.569674
    -0.117078
      0.18149
    -0.028138
     0.652868
     0.261899
    -0.652194
       -0.362
     0.513212
     0.566789
     0.396352
    0.0971713
     0.654253
     0.242901
    0.0825076
     0.231477
     0.733174
     0.227288
      0.0236;
      0];
tic
[t,x]=ode45(@MilosSmTlWorking,[0,2],x0);
time  = toc

function dx = MilosSmTlWorking(t,x)  
iPVd_PV21 = x(1);
iPVq_PV21 = x(2);
iSd_G22 = x(3);
iSq_G22 = x(4);
iRd_G22 = x(5);
iRq_G22 = x(6);
iF_G22 = x(7);
delta_G22 = x(8);
omega_G22 = x(9);
iSd_G23 = x(10);
iSq_G23 = x(11);
iRd_G23 = x(12);
iRq_G23 = x(13);
iF_G23 = x(14);
delta_G23 = x(15);
omega_G23 = x(16);
iLd_L1 = x(17);
iLq_L1 = x(18);
iLd_L21 = x(19);
iLq_L21 = x(20);
iLd_L22 = x(21);
iLq_L22 = x(22);
iLd_L23 = x(23);
iLq_L23 = x(24);
vTLLd_TL_1_21 = x(25);
vTLLq_TL_1_21 = x(26);
iTLMd_TL_1_21 = x(27);
iTLMq_TL_1_21 = x(28);
vTLRd_TL_1_21 = x(29);
vTLRq_TL_1_21 = x(30);
iTLMd_TL_1_22 = x(31);
iTLMq_TL_1_22 = x(32);
vTLRd_TL_1_22 = x(33);
vTLRq_TL_1_22 = x(34);
iTLMd_TL_1_23 = x(35);
iTLMq_TL_1_23 = x(36);
vTLRd_TL_1_23 = x(37);
vTLRq_TL_1_23 = x(38);
delPInt = x(39);
delVInt = x(40);
t
tauL_G22 = tauL_G22_ref - K1_G22*(delta_G22 - delta_G22_ref) - K2_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K3_G22*(iF_G22 - iF_G22_ref);%+ 4.4605*(delta_G22 - delta_G22_ref);
tauL_G23 = tauL_G23_ref - K1_G23*(delta_G23 - delta_G23_ref) - K2_G23*(omega_G23 - omega_G23_ref);
vR_G23 = vR_G23_ref - K3_G23*(iF_G23 - iF_G23_ref);% + 2.699*(delta_G23 - delta_G23_ref);

Zbase = 2.4^2/4;
omega0 = 1;
RPV = 0.01/Zbase;
LPV = 3.6e-3*377/Zbase;
CPV = (1/(377*0.02))/Zbase;

Pref = 0.875; Vref = 1;
iRd = iPVd_PV21; iRq = iPVq_PV21;
P = (vTLRd_TL_1_21*iRd + vTLRq_TL_1_21*iRq);
Vt = sqrt(vTLRd_TL_1_21^2+ vTLRq_TL_1_21^2);

ddelPIntdt = Pref - P;
ddelVIntdt = Vref - Vt;

Kp1 = -2; Ki1 = 0.2;
Kp2 = -100; Ki2 = -1;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt;% + atan(vTLRq_TL_1_21/vTLRd_TL_1_21);% + vTLLq/vTLLd - (vTLLq/vTLLd)^3/3;
Vcstar = Vref+(Kp2*(Vref-Vt) + Ki2*delVInt)*Vref;

vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLRd_TL_1_21; vRRq = vTLRq_TL_1_21;

diPVd_PV21dt = (vRLd - RPV*iRd - vRRd)/LPV + omega0*iRq;
diPVq_PV21dt = (vRLq - RPV*iRq - vRRq)/LPV - omega0*iRd;

%             dVsdt = 377*( -(id*ud + iq*uq)/CPV + iDC/CPV);

% diPVd_PV21dt = 377*dphidt*iPVq_PV21 + (377*(vTLRd_TL_1_21 - RL_PV21*iPVd_PV21))/LL_PV21;
% diPVq_PV21dt = (377*(vTLRq_TL_1_21 - RL_PV21*iPVq_PV21))/LL_PV21 - 377*dphidt*iPVd_PV21;
diSd_G22dt = 377*vTLRd_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*RR_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((RR_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLRq_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iSd_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iRq_G22*((Laq_G22*RR_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*vTLRq_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iRd_G22*((RR_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLRd_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*RR_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_1_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_1_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLRd_TL_1_22 + iSq_G22*vTLRq_TL_1_22)/(2*H_G22);
diSd_G23dt = 377*vTLRd_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLRd_TL_1_23 + iSq_G23*vTLRq_TL_1_23)/(2*H_G23);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLLd_TL_1_21 - RL_L21*iLd_L1))/LL_L21;
diLq_L1dt = (377*(vTLLq_TL_1_21 - RL_L21*iLq_L1))/LL_L21 - 377*dphidt*iLd_L1;
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLLd_TL_1_21 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLLq_TL_1_21 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
diLd_L22dt = 377*dphidt*iLq_L22 + (377*(vTLRd_TL_1_22 - RL_L22*iLd_L22))/LL_L22;
diLq_L22dt = (377*(vTLRq_TL_1_22 - RL_L22*iLq_L22))/LL_L22 - 377*dphidt*iLd_L22;
diLd_L23dt = 377*dphidt*iLq_L23 + (377*(vTLRd_TL_1_23 - RL_L23*iLd_L23))/LL_L23;
diLq_L23dt = (377*(vTLRq_TL_1_23 - RL_L23*iLq_L23))/LL_L23 - 377*dphidt*iLd_L23;
dvTLLd_TL_1_21dt = -(377*(iLd_L21 + iTLMd_TL_1_21 + iTLMd_TL_1_22 + iTLMd_TL_1_23 - CTL_TL_1_21*dphidt*vTLLq_TL_1_21 - CTL_TL_1_22*dphidt*vTLLq_TL_1_21 - CTL_TL_1_23*dphidt*vTLLq_TL_1_21))/(CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
dvTLLq_TL_1_21dt = -(377*(iLq_L21 + iTLMq_TL_1_21 + iTLMq_TL_1_22 + iTLMq_TL_1_23 + CTL_TL_1_21*dphidt*vTLLd_TL_1_21 + CTL_TL_1_22*dphidt*vTLLd_TL_1_21 + CTL_TL_1_23*dphidt*vTLLd_TL_1_21))/(CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
diTLMd_TL_1_21dt = 377*dphidt*iTLMq_TL_1_21 - (377*(vTLRd_TL_1_21 - vTLLd_TL_1_21 + RTL_TL_1_21*iTLMd_TL_1_21))/LTL_TL_1_21;
diTLMq_TL_1_21dt = - 377*dphidt*iTLMd_TL_1_21 - (377*(vTLRq_TL_1_21 - vTLLq_TL_1_21 + RTL_TL_1_21*iTLMq_TL_1_21))/LTL_TL_1_21;
dvTLRd_TL_1_21dt = 377*dphidt*vTLRq_TL_1_21 - (377*(iLd_L21 - iPVd_PV21 - iTLMd_TL_1_21))/CTL_TL_1_21;
dvTLRq_TL_1_21dt = - 377*dphidt*vTLRd_TL_1_21 - (377*(iLq_L21 - iPVq_PV21 - iTLMq_TL_1_21))/CTL_TL_1_21;
diTLMd_TL_1_22dt = 377*dphidt*iTLMq_TL_1_22 - (377*(vTLRd_TL_1_22 - vTLLd_TL_1_21 + RTL_TL_1_22*iTLMd_TL_1_22))/LTL_TL_1_22;
diTLMq_TL_1_22dt = - 377*dphidt*iTLMd_TL_1_22 - (377*(vTLRq_TL_1_22 - vTLLq_TL_1_21 + RTL_TL_1_22*iTLMq_TL_1_22))/LTL_TL_1_22;
dvTLRd_TL_1_22dt = 377*dphidt*vTLRq_TL_1_22 + (377*(iSd_G22 - iLd_L22 + iTLMd_TL_1_22))/CTL_TL_1_22;
dvTLRq_TL_1_22dt = (377*(iSq_G22 - iLq_L22 + iTLMq_TL_1_22))/CTL_TL_1_22 - 377*dphidt*vTLRd_TL_1_22;
diTLMd_TL_1_23dt = 377*dphidt*iTLMq_TL_1_23 - (377*(vTLRd_TL_1_23 - vTLLd_TL_1_21 + RTL_TL_1_23*iTLMd_TL_1_23))/LTL_TL_1_23;
diTLMq_TL_1_23dt = - 377*dphidt*iTLMd_TL_1_23 - (377*(vTLRq_TL_1_23 - vTLLq_TL_1_21 + RTL_TL_1_23*iTLMq_TL_1_23))/LTL_TL_1_23;
dvTLRd_TL_1_23dt = 377*dphidt*vTLRq_TL_1_23 + (377*(iSd_G23 - iLd_L23 + iTLMd_TL_1_23))/CTL_TL_1_23;
dvTLRq_TL_1_23dt = (377*(iSq_G23 - iLq_L23 + iTLMq_TL_1_23))/CTL_TL_1_23 - 377*dphidt*vTLRd_TL_1_23;
dx = [diPVd_PV21dt
diPVq_PV21dt
diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diSd_G23dt
diSq_G23dt
diRd_G23dt
diRq_G23dt
diF_G23dt
ddelta_G23dt
domega_G23dt
diLd_L1dt
diLq_L1dt
diLd_L21dt
diLq_L21dt
diLd_L22dt
diLq_L22dt
diLd_L23dt
diLq_L23dt
dvTLLd_TL_1_21dt
dvTLLq_TL_1_21dt
diTLMd_TL_1_21dt
diTLMq_TL_1_21dt
dvTLRd_TL_1_21dt
dvTLRq_TL_1_21dt
diTLMd_TL_1_22dt
diTLMq_TL_1_22dt
dvTLRd_TL_1_22dt
dvTLRq_TL_1_22dt
diTLMd_TL_1_23dt
diTLMq_TL_1_23dt
dvTLRd_TL_1_23dt
dvTLRq_TL_1_23dt
ddelPIntdt
ddelVIntdt
];
end
iPVd_PV21 = x(:,1);
iPVq_PV21 = x(:,2);
iSd_G22 = x(:,3);
iSq_G22 = x(:,4);
iRd_G22 = x(:,5);
iRq_G22 = x(:,6);
iF_G22 = x(:,7);
delta_G22 = x(:,8);
omega_G22 = x(:,9);
iSd_G23 = x(:,10);
iSq_G23 = x(:,11);
iRd_G23 = x(:,12);
iRq_G23 = x(:,13);
iF_G23 = x(:,14);
delta_G23 = x(:,15);
omega_G23 = x(:,16);
iLd_L1 = x(:,17);
iLq_L1 = x(:,18);
iLd_L21 = x(:,19);
iLq_L21 = x(:,20);
iLd_L22 = x(:,21);
iLq_L22 = x(:,22);
iLd_L23 = x(:,23);
iLq_L23 = x(:,24);
vTLLd_TL_1_21 = x(:,25);
vTLLq_TL_1_21 = x(:,26);
iTLMd_TL_1_21 = x(:,27);
iTLMq_TL_1_21 = x(:,28);
vTLRd_TL_1_21 = x(:,29);
vTLRq_TL_1_21 = x(:,30);
iTLMd_TL_1_22 = x(:,31);
iTLMq_TL_1_22 = x(:,32);
vTLRd_TL_1_22 = x(:,33);
vTLRq_TL_1_22 = x(:,34);
iTLMd_TL_1_23 = x(:,35);
iTLMq_TL_1_23 = x(:,36);
vTLRd_TL_1_23 = x(:,37);
vTLRq_TL_1_23 = x(:,38);
Vs = x(:,39);

figure(1);
iS23 = sqrt(iSd_G23.^2 + iSq_G23.^2);
iS22 = sqrt(iSd_G22.^2 + iSq_G22.^2);
subplot(2,1,1)
plot(t,iS23,'b',t,iF_G23,'r');
title('Electrical quantites of G23');
legend('Stator current magnitude of G23','Field current magnitude of G23');
xlabel('Time in seconds');
ylabel('Current Magnitude (in p.u)');

subplot(2,1,2)
plot(t,iS22,'b',t,iF_G22,'r');
title('Electrical quantites of G22');
legend('Stator current magnitude of G22','Field current magnitude of G22');
xlabel('Time in seconds');
ylabel('Current Magnitude (in p.u)');

figure(2);
subplot(2,1,1)
plot(t,delta_G23,'b',t,omega_G23,'r');
title('Mechanical quantites of G23');
legend('Rotor relative angle of G23','Angular velocity of G23');
xlabel('Time in seconds');
ylabel('in p.u');

subplot(2,1,2)
plot(t,delta_G22,'b',t,omega_G22,'r');
title('Mechanical quantites of G22');
legend('Rotor relative angle of G22','Angular velocity of G22');
xlabel('Time in seconds');
ylabel('in p.u');

V1 = (vTLLd_TL_1_21.^2 + vTLLq_TL_1_21.^2).^0.5;
V21 = (vTLRd_TL_1_21.^2 + vTLRq_TL_1_21.^2).^0.5;
V22 = (vTLRd_TL_1_22.^2 + vTLRq_TL_1_22.^2).^0.5;
V23 = (vTLRd_TL_1_23.^2 + vTLRq_TL_1_23.^2).^0.5;

phi1 = atan(vTLLq_TL_1_21./vTLLd_TL_1_21)*180/pi;
phi21 = atan(vTLRq_TL_1_21./vTLRd_TL_1_21)*180/pi;
phi22 = atan(vTLRq_TL_1_22./vTLRd_TL_1_22)*180/pi;
phi23 = atan(vTLRq_TL_1_23./vTLRd_TL_1_23)*180/pi;
V = [V1(end) V21(end) V22(end) V23(end)]
% V1 = V1(1:250);V21 = V21(1:250);V22 = V22(1:250);V23 = V23(1:250);
% phi1 = phi1(1:250);phi21 = phi21(1:250);phi22 = phi22(1:250);phi23 = phi23(1:250);

figure(3);
subplot(2,1,1)
plot(t,V23,'g',t,V21,'r',t,V22,'b',t,V1,'k');
title('Voltage profile (for isolated mode)');
legend('V23','V21','V22','V1');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,phi23,'g',t,phi21,'r',t,phi22,'b',t,phi1,'k');
title('Voltage angles at all the buses');
legend('phi23','phi21','phi22','phi1');
xlabel('Time in seconds');
ylabel('Voltage angle (in degrees)');

% figure(4)
% vd = vTLRd_TL_1_21; vq = vTLRq_TL_1_21;
% id_star = (P*vd + Q*vq)./(vd.^2 + vq.^2);
% iq_star = (P*vq - Q*vd)./(vd.^2 + vq.^2);
% uq = ((-RPV*iq_star +vq)  - dphidt*LPV*id_star);
% ud = ((-RPV*id_star +vd) + dphidt*LPV*iq_star);
% 
% subplot(2,1,1)
% plot(t,iPVd_PV21,'b',t,id_star,'b--',t,iPVq_PV21,'r',t,iq_star,'r--');
% title('Currents out of the PV and their reference values');
% legend('iPVd','iPVd_{ref}','iPVq','iPVq_{ref}');
% xlabel('Time in seconds');
% ylabel('Currents (in p.u)');
% 
% % figure(6);
% subplot(2,1,2)
% plot(t,ud,'g',t,uq,'r');
% title('Duty ratios of the switches');
% legend('u_d','u_q');
% xlabel('Time in seconds');
% ylabel('Duty ratio');

P21 = (vTLRd_TL_1_21.*iPVd_PV21 + vTLRq_TL_1_21.*iPVq_PV21);
Q21 = (vTLRq_TL_1_21.*iPVd_PV21 - vTLRd_TL_1_21.*iPVq_PV21);
P22 = vTLRd_TL_1_22.*iSd_G22 + vTLRq_TL_1_21.*iPVq_PV21;
Q22 = vTLRq_TL_1_22.*iSd_G22 - vTLRd_TL_1_21.*iPVq_PV21;
P23 = vTLRd_TL_1_23.*iSd_G23 + vTLRq_TL_1_21.*iPVq_PV21;
Q23 = vTLRq_TL_1_23.*iSq_G23 - vTLRd_TL_1_21.*iPVq_PV21;

P = [P21(end) P22(end) P23(end)]
Q = [Q21(end) Q22(end) Q23(end)]

figure(5)
subplot(2,1,1)
plot(t,P23,'g',t,P21,'r',t,P22,'b');
title('Real power generation (for isolated mode)');
legend('P23','P21','P22');
xlabel('Time in seconds');
ylabel('Real Power (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,Q23,'g',t,Q21,'r',t,Q22,'b');
title('Reactive power generation (for isolated mode)');
legend('Q23','Q21','Q22');
xlabel('Time in seconds');
ylabel('Reactive Power (in p.u)');



Vs(end)
save('DataRLLoad.mat')
end
