function dx = SolveReducedNetwork(x)
% generator parameters
close all

addpath('../MicrogridVersion1/Parameters')

iSd_G1 = x(1);
iSq_G1 = x(2);
iRd_G1 = x(3);
iRq_G1 = x(4);
iF_G1 = x(5);
delta_G1 = x(6);
omega_G1 = x(7);
iSd_G2 = x(8);
iSq_G2 = x(9);
iRd_G2 = x(10);
iRq_G2 = x(11);
iF_G2 = x(12);
delta_G2 = x(13);
omega_G2 = x(14);
iLd_L1 = x(15);
iLq_L1 = x(16);
iLd_L2 = x(17);
iLq_L2 = x(18);
iLd_L3 = x(19);
iLq_L3 = x(20);
iLd_PV3 = x(21);
iLq_PV3 = x(22);
vTLLd_TL_1_2 = x(23);
vTLLq_TL_1_2 = x(24);
iTLMd_TL_1_2 = x(25);
iTLMq_TL_1_2 = x(26);
vTLRd_TL_1_2 = x(27);
vTLRq_TL_1_2 = x(28);
iTLMd_TL_1_3 = x(29);
iTLMq_TL_1_3 = x(30);
vTLRd_TL_1_3 = x(31);
vTLRq_TL_1_3 = x(32);
iTLMd_TL_2_3 = x(33);
iTLMq_TL_2_3 = x(34);


load('G1.mat','Lad_G1','Laf_G1','Laq_G1','Ldf_G1','LSd_G1','LSq_G1','LRD_G1','LF_G1','LRQ_G1','RS_G1','RR_G1','RF_G1','H_G1','B_G1')
load('G2.mat','Lad_G2','Laf_G2','Laq_G2','Ldf_G2','LSd_G2','LSq_G2','LRD_G2','LF_G2','LRQ_G2','RS_G2','RR_G2','RF_G2','H_G2','B_G2')

RL_PV3 = -3/(9+0.01^2); 
LL_PV3 = -0.01/(9+0.01^2);

RL_L1 = 0.4508; 
LL_L1 = 0.6201;

RL_L2 = 0.0065; 
LL_L2 = 0.0218;

RL_L3 = 0.088; 
LL_L3 = -0.0305;

LTL_TL_1_2=0.5998;
RTL_TL_1_2=-0.0979;
CTL_TL_1_2=0.01;

LTL_TL_1_3=0.6299;
RTL_TL_1_3=-0.0941;
CTL_TL_1_3=0.01;

LTL_TL_2_3=0.63;
RTL_TL_2_3=-0.0937;
CTL_TL_2_3=0.01;

% syms iSd_G1 iSq_G1 iRd_G1 iRq_G1 iF_G1 delta_G1 omega_G1 ...
%     iSd_G2 iSq_G2 iRd_G2 iRq_G2 iF_G2 delta_G2 omega_G2...
%     iLd_L1 iLq_L1 iLd_L2 iLq_L2 iLd_L3 iLq_L3 iLd_PV3 iLq_PV3...
%     vTLLd_TL_1_2 vTLLq_TL_1_2 iTLMd_TL_1_2 iTLMq_TL_1_2 vTLRd_TL_1_2 vTLRq_TL_1_2...
%     iTLMd_TL_1_3 iTLMq_TL_1_3 vTLRd_TL_1_3 vTLRq_TL_1_3;


% % States
% x=[iSd_G1
% iSq_G1
% iRd_G1
% iRq_G1
% iF_G1
% delta_G1
% omega_G1
% iSd_G2
% iSq_G2
% iRd_G2
% iRq_G2
% iF_G2
% delta_G2
% omega_G2
% iLd_L1
% iLq_L1
% iLd_L2
% iLq_L2
% iLd_L3
% iLq_L3
% iLd_PV3
% iLq_PV3
% vTLLd_TL_1_2
% vTLLq_TL_1_2
% iTLMd_TL_1_2
% iTLMq_TL_1_2
% vTLRd_TL_1_2
% vTLRq_TL_1_2
% iTLMd_TL_1_3
% iTLMq_TL_1_3
% vTLRd_TL_1_3
% vTLRq_TL_1_3];
   
dphidt = 1; 
% k1=[5.8125   35.5171   -1.1682   -2.5449    1.3147    1.3279   -2.3964
%    -3.5568   -9.1728   -3.9072    8.0164   -8.7656   -9.8039    1.4338];
% reqd1=[0.6192, 1.0, 0.8426, -0.5012, 1.19e-13, -1.484, 9.292e-14]';
% Tm_G1=-(k1(1,:)*([delta_G1;omega_G1;iSd_G1;iSq_G1;iRd_G1;iF_G1;iRq_G1]-reqd1))+1.00;
%     vR_G1=-(k1(2,:)*([delta_G1;omega_G1;iSd_G1;iSq_G1;iRd_G1;iF_G1;iRq_G1]-reqd1))+0.003729;
% 
% Tm_G2=-(k1(1,:)*([delta_G2;omega_G2;iSd_G2;iSq_G2;iRd_G2;iF_G2;iRq_G2]-reqd1))+1.00;
%     vR_G2=-(k1(2,:)*([delta_G2;omega_G2;iSd_G2;iSq_G2;iRd_G2;iF_G2;iRq_G2]-reqd1))+0.003729;

Tm_G1 = 1; vR_G1 = 0.003728;
Tm_G2 = 1; vR_G2 = 0.003728;
diSd_G1dt = 377*vTLLd_TL_1_2*(cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - 377*iRq_G1*((Laq_G1*RR_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (Laq_G1*omega_G1*sin(delta_G1)*(Ldf_G1^2 - LF_G1*LRD_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSq_G1*(omega_G1 - dphidt + omega_G1*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + omega_G1*cos(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - RS_G1*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) + 377*iSd_G1*(RS_G1*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + omega_G1*sin(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) - 377*iF_G1*((RF_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LRQ_G1*Laf_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - 377*iRd_G1*((RR_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LRQ_G1*Lad_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*vTLLq_TL_1_2*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diSq_G1dt = 377*iSd_G1*(omega_G1 - dphidt + omega_G1*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - omega_G1*cos(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) - 377*iRq_G1*((Laq_G1*RR_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) + (Laq_G1*omega_G1*cos(delta_G1)*(Ldf_G1^2 - LF_G1*LRD_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*vTLLq_TL_1_2*(cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSq_G1*(omega_G1*sin(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - RS_G1*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) + 377*iF_G1*((RF_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LRQ_G1*Laf_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*iRd_G1*((RR_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LRQ_G1*Lad_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*vTLLd_TL_1_2*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + (377*vR_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diRd_G1dt = 377*iSq_G1*((RS_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LSq_G1*omega_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSd_G1*((RS_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LSq_G1*omega_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*vTLLq_TL_1_2*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*vTLLd_TL_1_2*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RR_G1*iRd_G1*(Laf_G1^2 - LF_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RF_G1*iF_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*Laq_G1*iRq_G1*omega_G1*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diRq_G1dt = (377*LSq_G1*RR_G1*iRq_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1) - 377*iSq_G1*((Laq_G1*RS_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (LSd_G1*Laq_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - (377*Laq_G1*vTLLd_TL_1_2*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (377*Laq_G1*vTLLq_TL_1_2*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - 377*iSd_G1*((Laq_G1*RS_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) + (LSd_G1*Laq_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - (377*Laf_G1*Laq_G1*iF_G1*omega_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1) - (377*Lad_G1*Laq_G1*iRd_G1*omega_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1);
diF_G1dt = 377*iSq_G1*((RS_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LSq_G1*omega_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSd_G1*((RS_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LSq_G1*omega_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*(Lad_G1^2 - LRD_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*vTLLq_TL_1_2*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*vTLLd_TL_1_2*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RF_G1*iF_G1*(Lad_G1^2 - LRD_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RR_G1*iRd_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*Laq_G1*iRq_G1*omega_G1*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
ddelta_G1dt = 377*omega_G1 - 377;
domega_G1dt = -(B_G1*omega_G1 - Tm_G1 + iSd_G1*vTLLd_TL_1_2 + iSq_G1*vTLLq_TL_1_2)/(2*H_G1);
diSd_G2dt = 377*vTLRd_TL_1_2*(cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - 377*iRq_G2*((Laq_G2*RR_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (Laq_G2*omega_G2*sin(delta_G2)*(Ldf_G2^2 - LF_G2*LRD_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSq_G2*(omega_G2 - dphidt + omega_G2*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + omega_G2*cos(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - RS_G2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) + 377*iSd_G2*(RS_G2*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + omega_G2*sin(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) - 377*iF_G2*((RF_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LRQ_G2*Laf_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - 377*iRd_G2*((RR_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LRQ_G2*Lad_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*vTLRq_TL_1_2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diSq_G2dt = 377*iSd_G2*(omega_G2 - dphidt + omega_G2*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - omega_G2*cos(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) - 377*iRq_G2*((Laq_G2*RR_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) + (Laq_G2*omega_G2*cos(delta_G2)*(Ldf_G2^2 - LF_G2*LRD_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*vTLRq_TL_1_2*(cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSq_G2*(omega_G2*sin(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - RS_G2*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) + 377*iF_G2*((RF_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LRQ_G2*Laf_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*iRd_G2*((RR_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LRQ_G2*Lad_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*vTLRd_TL_1_2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + (377*vR_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diRd_G2dt = 377*iSq_G2*((RS_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LSq_G2*omega_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSd_G2*((RS_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LSq_G2*omega_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*vTLRq_TL_1_2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*vTLRd_TL_1_2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RR_G2*iRd_G2*(Laf_G2^2 - LF_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RF_G2*iF_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*Laq_G2*iRq_G2*omega_G2*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diRq_G2dt = (377*LSq_G2*RR_G2*iRq_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2) - 377*iSq_G2*((Laq_G2*RS_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (LSd_G2*Laq_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - (377*Laq_G2*vTLRd_TL_1_2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (377*Laq_G2*vTLRq_TL_1_2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - 377*iSd_G2*((Laq_G2*RS_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) + (LSd_G2*Laq_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - (377*Laf_G2*Laq_G2*iF_G2*omega_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2) - (377*Lad_G2*Laq_G2*iRd_G2*omega_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2);
diF_G2dt = 377*iSq_G2*((RS_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LSq_G2*omega_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSd_G2*((RS_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LSq_G2*omega_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*(Lad_G2^2 - LRD_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*vTLRq_TL_1_2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*vTLRd_TL_1_2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RF_G2*iF_G2*(Lad_G2^2 - LRD_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RR_G2*iRd_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*Laq_G2*iRq_G2*omega_G2*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
ddelta_G2dt = 377*omega_G2 - 377;
domega_G2dt = -(B_G2*omega_G2 - Tm_G2 + iSd_G2*vTLRd_TL_1_2 + iSq_G2*vTLRq_TL_1_2)/(2*H_G2);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLLd_TL_1_2 - RL_L1*iLd_L1))/LL_L1;
diLq_L1dt = (377*(vTLLq_TL_1_2 - RL_L1*iLq_L1))/LL_L1 - 377*dphidt*iLd_L1;
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_2 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L3dt = 377*dphidt*iLq_L3 + (377*(vTLRd_TL_1_3 - RL_L3*iLd_L3))/LL_L3;
diLq_L3dt = (377*(vTLRq_TL_1_3 - RL_L3*iLq_L3))/LL_L3 - 377*dphidt*iLd_L3;
diLd_PV3dt = 377*dphidt*iLq_PV3 + (377*(vTLRd_TL_1_3 - RL_PV3*iLd_PV3))/LL_PV3;
diLq_PV3dt = (377*(vTLRq_TL_1_3 - RL_PV3*iLq_PV3))/LL_PV3 - 377*dphidt*iLd_PV3;
dvTLLd_TL_1_2dt = -(377*(iLd_L1 - iSd_G1 + iTLMd_TL_1_2 + iTLMd_TL_1_3 - CTL_TL_1_2*dphidt*vTLLq_TL_1_2 - CTL_TL_1_3*dphidt*vTLLq_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_3);
dvTLLq_TL_1_2dt = -(377*(iLq_L1 - iSq_G1 + iTLMq_TL_1_2 + iTLMq_TL_1_3 + CTL_TL_1_2*dphidt*vTLLd_TL_1_2 + CTL_TL_1_3*dphidt*vTLLd_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_3);
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_2 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_2 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = (377*(iSd_G2 - iLd_L2 + iTLMd_TL_1_2 - iTLMd_TL_2_3 + CTL_TL_1_2*dphidt*vTLRq_TL_1_2 + CTL_TL_2_3*dphidt*vTLRq_TL_1_2))/(CTL_TL_1_2 + CTL_TL_2_3);
dvTLRq_TL_1_2dt = -(377*(iLq_L2 - iSq_G2 - iTLMq_TL_1_2 + iTLMq_TL_2_3 + CTL_TL_1_2*dphidt*vTLRd_TL_1_2 + CTL_TL_2_3*dphidt*vTLRd_TL_1_2))/(CTL_TL_1_2 + CTL_TL_2_3);
diTLMd_TL_1_3dt = 377*dphidt*iTLMq_TL_1_3 - (377*(vTLRd_TL_1_3 - vTLLd_TL_1_2 + RTL_TL_1_3*iTLMd_TL_1_3))/LTL_TL_1_3;
diTLMq_TL_1_3dt = - 377*dphidt*iTLMd_TL_1_3 - (377*(vTLRq_TL_1_3 - vTLLq_TL_1_2 + RTL_TL_1_3*iTLMq_TL_1_3))/LTL_TL_1_3;
dvTLRd_TL_1_3dt = (377*(iTLMd_TL_1_3 - iLd_PV3 - iLd_L3 + iTLMd_TL_2_3 + CTL_TL_1_3*dphidt*vTLRq_TL_1_3 + CTL_TL_2_3*dphidt*vTLRq_TL_1_3))/(CTL_TL_1_3 + CTL_TL_2_3);
dvTLRq_TL_1_3dt = -(377*(iLq_L3 + iLq_PV3 - iTLMq_TL_1_3 - iTLMq_TL_2_3 + CTL_TL_1_3*dphidt*vTLRd_TL_1_3 + CTL_TL_2_3*dphidt*vTLRd_TL_1_3))/(CTL_TL_1_3 + CTL_TL_2_3);
diTLMd_TL_2_3dt = 377*dphidt*iTLMq_TL_2_3 - (377*(vTLRd_TL_1_3 - vTLRd_TL_1_2 + RTL_TL_2_3*iTLMd_TL_2_3))/LTL_TL_2_3;
diTLMq_TL_2_3dt = - 377*dphidt*iTLMd_TL_2_3 - (377*(vTLRq_TL_1_3 - vTLRq_TL_1_2 + RTL_TL_2_3*iTLMq_TL_2_3))/LTL_TL_2_3;
dx = [diSd_G1dt
diSq_G1dt
diRd_G1dt
diRq_G1dt
diF_G1dt
ddelta_G1dt
domega_G1dt
diSd_G2dt
diSq_G2dt
diRd_G2dt
diRq_G2dt
diF_G2dt
ddelta_G2dt
domega_G2dt
diLd_L1dt
diLq_L1dt
diLd_L2dt
diLq_L2dt
diLd_L3dt
diLq_L3dt
diLd_PV3dt
diLq_PV3dt
dvTLLd_TL_1_2dt
dvTLLq_TL_1_2dt
diTLMd_TL_1_2dt
diTLMq_TL_1_2dt
dvTLRd_TL_1_2dt
dvTLRq_TL_1_2dt
diTLMd_TL_1_3dt
diTLMq_TL_1_3dt
dvTLRd_TL_1_3dt
dvTLRq_TL_1_3dt
diTLMd_TL_2_3dt
diTLMq_TL_2_3dt
];
end
%Soln = solve(dx,x);