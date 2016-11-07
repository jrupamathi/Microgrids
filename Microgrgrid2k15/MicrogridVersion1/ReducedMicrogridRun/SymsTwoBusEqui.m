function SymsTwoBusEqui
% generator parameters

set(0,'defaultlinelinewidth',1.5)
addpath('../Parameters')

load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','RF_G22','H_G22','B_G22','Rkq_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

tauL_G22_ref = 0.47423;
vR_G22_ref = 0.003126;
% delta_G22_ref = 0.2863;
% iF_G22_ref = -1.518;
K1_G22 = 2.2092; K2_G22 = 24.8318;
K3_G22 = -5.7645;

%Load Parameters
RL_L21 = 4.9098; LL_L21 = 2.8962;
RL_L22 = 0.5587; LL_L22 = 0.4054;

%Line Parameters
RTL_TL_21_22 = 0.0287; LTL_TL_21_22 = 0.1104;
CTL_TL_21_22 = 0.01;

%PV Parameters
iPV = 0.9773;
Rf = 0.0069;
Lf = 0.9425;
% Rdc = 10*Rf;
Cdc = 0.0921;
Cf = Cdc;
RL_PV21 = Rf; 
LL_PV21 = Lf;

PPV_ref = 0.875; QPV_ref = 0.01; 
V21_ref = 1.008;
alpha_eq = PPV_ref/(V21_ref^2);

omega0 = 1; wb = 377; dphidt = 1;
%Control gains
Kpvt = 1e0; Kivt = 0.1e3;
Kpv = 0e0; Kiv = 0.1e0;
Kpp = 1e0; Kip = 0.1e0;
Kpc = 0e0; Kic = 0.1e0;

tic
faulton = 2; faultoff = 2;

x0 = [0.465
     -0.995
  2.352e-16
 -6.401e-15
 -1.518
 0.2863
    1.0
    0.1511
    -0.0891
    1.1722
    -0.8508
    1
    0
    -0.6
    -0.1
    1
    0
    1.1428
    0.0033
    1.1428
    0.0033
    1
    1
    0
    0
    0
    0
    0
    0
    0];
x0 = [0.4186
   -0.3970
   -0.2408
   -0.2338
   -0.5626
    0.2651
    0.9898
    0.1271
   -0.0869
    0.8833
   -0.5826
    0.7248
    0.1080
    0.4642
   -0.1787
    0.6950
    0.0596
    0.5902
   -0.2584
    0.0523
   -0.0045
    0.0124
    0.9003
    7.7086
   -0.0921
   -0.0440
    0.0646
  -62.5348
   -0.0007
   -0.0003];

options = optimoptions('fsolve','Display','iter');
options.MaxFunctionEvaluations = 100000;
options.TolX = 1e-4;
options.MaxIterations = 1000000;
fin = fsolve(@(x)Numericsolve(x),x0,options);
disp(fin)

function dx = Numericsolve(x)  
iSd_G22 = x(1);
iSq_G22 = x(2);
iRd_G22 = x(3);
iRq_G22 = x(4);
iF_G22 = x(5);
delta_G22 = x(6);
omega_G22 = x(7);
iLd_L21 = x(8);
iLq_L21 = x(9);
iLd_L22 = x(10);
iLq_L22 = x(11);
vTLLd_TL_21_22 = x(12);
vTLLq_TL_21_22 = x(13);
if (faulton==2)
    iTLMd_TL_21_22 = x(14);
    iTLMq_TL_21_22 = x(15);
else
    iTLMd_TL_21_22 = 0;
    iTLMq_TL_21_22 = 0;
end
vTLRd_TL_21_22 = x(16);
vTLRq_TL_21_22 = x(17);
iLd_PV21 = x(18);
iLq_PV21 = x(19);

iFd = x(20);
iFq = x(21);
vDC = x(22);
vOutd = x(23);
vOutq = x(24);
gammad = x(25);
gammaq = x(26);
VdiffInt = x(27);
delP = x(28);
phid =x(29);
phiq =x(30);

% Vt23 = sqrt(vTLRd_TL_21_22^2 + vTLRq_TL_21_22^2);

tauL_G22 = tauL_G22_ref - K1_G22*(delta_G22 - delta_G22_ref) - K2_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K3_G22*(iF_G22 - iF_G22_ref);
diSd_G22dt = 377*vTLRd_TL_21_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_21_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_21_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_21_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_21_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_21_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*(omega_G22-omega0) - tauL_G22 + iSd_G22*vTLRd_TL_21_22 + iSq_G22*vTLRq_TL_21_22)/(2*H_G22);
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLLd_TL_21_22 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLLq_TL_21_22 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
diLd_L22dt = 377*dphidt*iLq_L22 + (377*(vTLRd_TL_21_22 - RL_L22*iLd_L22))/LL_L22;
diLq_L22dt = (377*(vTLRq_TL_21_22 - RL_L22*iLq_L22))/LL_L22 - 377*dphidt*iLd_L22;
dvTLLd_TL_21_22dt = 377*dphidt*vTLLq_TL_21_22 - (377*(iLd_L21 - iLd_PV21 + iTLMd_TL_21_22))/CTL_TL_21_22;
dvTLLq_TL_21_22dt = - 377*dphidt*vTLLd_TL_21_22 - (377*(iLq_L21 - iLq_PV21 + iTLMq_TL_21_22))/CTL_TL_21_22;
if (faulton==2)
    diTLMd_TL_21_22dt = 377*dphidt*iTLMq_TL_21_22 - (377*(vTLRd_TL_21_22 - vTLLd_TL_21_22 + RTL_TL_21_22*iTLMd_TL_21_22))/LTL_TL_21_22;
    diTLMq_TL_21_22dt = - 377*dphidt*iTLMd_TL_21_22 - (377*(vTLRq_TL_21_22 - vTLLq_TL_21_22 + RTL_TL_21_22*iTLMq_TL_21_22))/LTL_TL_21_22;
else
    diTLMd_TL_21_22dt = 0;
    diTLMq_TL_21_22dt = 0;
end
dvTLRd_TL_21_22dt = 377*dphidt*vTLRq_TL_21_22 + (377*(iSd_G22 - iLd_L22 + iTLMd_TL_21_22))/CTL_TL_21_22;
dvTLRq_TL_21_22dt = (377*(iSq_G22 - iLq_L22 + iTLMq_TL_21_22))/CTL_TL_21_22 - 377*dphidt*vTLRd_TL_21_22;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLLd_TL_21_22 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLLq_TL_21_22 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;

%PV internal dynamics
iOutd = iLd_PV21;
iOutq = iLq_PV21;
vBd = vTLLd_TL_21_22;
vBq = vTLLq_TL_21_22;
P = vBd*iOutd + vBq*iOutq;
Q = vBq*iOutd - vBd*iOutq;

%PQ control mode
if (faulton==2)
    alpha = -Kpp*(P - PPV_ref) + atan(vBq/vBd) + alpha_eq - Kip*delP;
    Vc = V21_ref*(1+ Kpvt*(Q-QPV_ref) + Kivt*VdiffInt); 
    dVdiffdt = (Q - QPV_ref);
    ddelPdt = P - PPV_ref;        
%Vf mode    
else
    Vt = sqrt(vBd^2 + vBq^2);
    f = 1 +1/0.3*(P-PPV_ref);
    alpha = -Kpp*(f - 1)+ atan(vBq/vBd) + alpha_eq - Kip*delP ;
    Vc = V21_ref*(1+ Kpvt*(Vt-V21_ref) + 1*Kivt*VdiffInt);
    dVdiffdt = (Vt - V21_ref);
    ddelPdt = f - 1;        
end

%Voltage Reference points
vOutd_ref = Vc*cos(alpha);
vOutq_ref = Vc*sin(alpha);
%Outer Voltage control
iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
        
%Inner current control
ud = (Rf*iFd_ref + 1*vOutd - omega0*Lf*iFq)/vDC;
uq = (Rf*iFq_ref + 1*vOutq + omega0*Lf*iFd)/vDC;
        
diFddt = -(Rf/Lf + 1*Kpc)*(iFd - iFd_ref) -Kic*phid;
diFqdt = -(Rf/Lf+ 1*Kpc)*(iFq - iFq_ref) -Kic*phiq;
% diFddt = -Rf*iFd/Lf + (vDC*ud - vOutd)/Lf + omega0*iFq;
% diFqdt = -Rf*iFq/Lf + (vDC*uq - vOutq)/Lf - omega0*iFd;
dvDCdt = (iPV - (iFd*ud + iFq*uq))/Cdc;% - vDCOut/(10*Rf);
        
dvOutddt = -Kpv*Cf*(vOutd-vOutd_ref)-Kiv*Cf*gammad;%(iFd - iOutd)/CTL + omega0*iFq;% - vTd/(1000*Rf);
dvOutqdt = -Kpv*Cf*(vOutq-vOutq_ref)-Kiv*Cf*gammaq;%-(-iFq + iLq)/CTL - omega0*iFd;% - vTq/(1000*Rf);

dgammaddt = vOutd-vOutd_ref;
dgammaqdt = vOutq-vOutq_ref;

dphiddt = iFd - iFd_ref;
dphiqdt = iFq - iFq_ref;

dx = [diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diLd_L21dt
diLq_L21dt
diLd_L22dt
diLq_L22dt
dvTLLd_TL_21_22dt
dvTLLq_TL_21_22dt
diTLMd_TL_21_22dt
diTLMq_TL_21_22dt
dvTLRd_TL_21_22dt
dvTLRq_TL_21_22dt
diLd_PV21dt
diLq_PV21dt
377*[diFddt;
diFqdt;
dvDCdt;
dvOutddt;
dvOutqdt;dgammaddt; dgammaqdt;...
dVdiffdt;ddelPdt; dphiddt; dphiqdt];
];    
end
end



