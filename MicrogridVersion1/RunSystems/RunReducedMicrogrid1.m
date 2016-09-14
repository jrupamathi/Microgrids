function RunReducedMicrogrid1
% generator parameters
close all

set(0,'defaultlinelinewidth',1.5)
addpath('../Parameters')

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','Rkq_G23','RF_G23','H_G23','B_G23',...
    'K11_G23','K12_G23','K13_G23','K14_G23','K15_G23','K16_G23','K17_G23',...
    'K21_G23','K22_G23','K23_G23','K24_G23','K25_G23','K26_G23','K27_G23',...
    'delta_G23_ref','omega_G23_ref','iSd_G23_ref','iSq_G23_ref','iRd_G23_ref','iRq_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','Rkq_G22','RF_G22','H_G22','B_G22',...
    'K11_G22','K12_G22','K13_G22','K14_G22','K15_G22','K16_G22','K17_G22',...
    'K21_G22','K22_G22','K23_G22','K24_G22','K25_G22','K26_G22','K27_G22',...
    'delta_G22_ref','omega_G22_ref','iSd_G22_ref','iSq_G22_ref','iRd_G22_ref','iRq_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

load('L1.mat', 'RL_L1', 'LL_L1');
load('L2.mat', 'RL_L2', 'LL_L2');
load('L3.mat', 'RL_L3', 'LL_L3');
load('L4.mat', 'RL_L4', 'LL_L4');
load('PV2.mat', 'RL_PV2', 'LL_PV2');
RL_PV2= -1.1427; LL_PV2 = -0.0131;
load('TL_1_4.mat', 'LTL_TL_1_4', 'RTL_TL_1_4','CTL_TL_1_4');
load('TL_2_4.mat', 'LTL_TL_2_4', 'RTL_TL_2_4','CTL_TL_2_4');
load('TL_3_4.mat', 'LTL_TL_3_4', 'RTL_TL_3_4','CTL_TL_3_4');

dphidt = 1;


x0=[0.6971;-0.3827;-0.0000;-0.0000;-1.7720;0.6476;1.0000;
    0.6186;   -0.4276;   -0.0094;   -0.0070;   -1.3263;    0.6395;    1.0001 ;
    0.2965;   -0.1537;
    0.2965;   -0.1537;
    0.2965;   -0.1537;
    0.2965;   -0.1537;
    0.2965;   -0.1537;
    1.0019; 0.0001;-0.6187 ;   0.4378; 1.0; 0.008 ;
    1.0019; 0.0001;-0.6187 ;   0.4378;
    1.0019; 0.0001;-0.6187 ;   0.4378];
tic
[t,x]=ode45(@MilosSmTlWorking,[0,0.001],x0);
time  = toc
% x=ode5(@MilosSmTlWorking,[0,0.1],x0);
% for j = 1:numel(t)
% [~,iInd(j,:),iInq(j,:)]=MilosSmTlWorking(t(j),x(j,:)); 
% end

function dx = MilosSmTlWorking(t,x)  
    t
    % States
iSd_G22 = x(1);
iSq_G22 = x(2);
iRd_G22 = x(3);
iRq_G22 = x(4);
iF_G22 = x(5);
delta_G22 = x(6);
omega_G22 = x(7);
iSd_G23 = x(8);
iSq_G23 = x(9);
iRd_G23 = x(10);
iRq_G23 = x(11);
iF_G23 = x(12);
delta_G23 = x(13);
omega_G23 = x(14);
iLd_L1 = x(15);
iLq_L1 = x(16);
iLd_L2 = x(17);
iLq_L2 = x(18);
iLd_L3 = x(19);
iLq_L3 = x(20);
iLd_L4 = x(21);
iLq_L4 = x(22);
iLd_PV2 = x(23);
iLq_PV2 = x(24);
vTLLd_TL_1_4 = x(25);
vTLLq_TL_1_4 = x(26);
iTLMd_TL_1_4 = x(27);
iTLMq_TL_1_4 = x(28);
vTLRd_TL_1_4 = x(29);
vTLRq_TL_1_4 = x(30);
vTLLd_TL_2_4 = x(31);
vTLLq_TL_2_4 = x(32);
iTLMd_TL_2_4 = x(33);
iTLMq_TL_2_4 = x(34);
vTLLd_TL_3_4 = x(35);
vTLLq_TL_3_4 = x(36);
iTLMd_TL_3_4 = x(37);
iTLMq_TL_3_4 = x(38);
tauL_G22 = tauL_G22_ref - K11_G22*(delta_G22 - delta_G22_ref) - K16_G22*(iF_G22 - iF_G22_ref) - K15_G22*(iRd_G22 - iRd_G22_ref) - K17_G22*(iRq_G22 - iRq_G22_ref) - K13_G22*(iSd_G22 - iSd_G22_ref) - K14_G22*(iSq_G22 - iSq_G22_ref) - K12_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K21_G22*(delta_G22 - delta_G22_ref) - K26_G22*(iF_G22 - iF_G22_ref) - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
tauL_G23 = tauL_G23_ref - K11_G23*(delta_G23 - delta_G23_ref) - K16_G23*(iF_G23 - iF_G23_ref) - K15_G23*(iRd_G23 - iRd_G23_ref) - K17_G23*(iRq_G23 - iRq_G23_ref) - K13_G23*(iSd_G23 - iSd_G23_ref) - K14_G23*(iSq_G23 - iSq_G23_ref) - K12_G23*(omega_G23 - omega_G23_ref);
vR_G23 = vR_G23_ref - K21_G23*(delta_G23 - delta_G23_ref) - K26_G23*(iF_G23 - iF_G23_ref) - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
diSd_G22dt = 377*vTLLd_TL_3_4*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLLq_TL_3_4*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLLq_TL_3_4*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLLd_TL_3_4*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_3_4*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_3_4*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLLd_TL_3_4*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLLq_TL_3_4*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_3_4*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_3_4*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLLd_TL_3_4 + iSq_G22*vTLLq_TL_3_4)/(2*H_G22);
diSd_G23dt = 377*vTLLd_TL_1_4*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((Rkd_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iSq_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLLq_TL_1_4*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*vTLLq_TL_1_4*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + 377*iRd_G23*((Rkd_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iSd_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLLd_TL_1_4*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLLq_TL_1_4*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLLd_TL_1_4*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*Rkq_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLLd_TL_1_4*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLLq_TL_1_4*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLLq_TL_1_4*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLLd_TL_1_4*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLLd_TL_1_4 + iSq_G23*vTLLq_TL_1_4)/(2*H_G23);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLLd_TL_1_4 - RL_L1*iLd_L1))/LL_L1;
diLq_L1dt = (377*(vTLLq_TL_1_4 - RL_L1*iLq_L1))/LL_L1 - 377*dphidt*iLd_L1;
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLLd_TL_2_4 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLLq_TL_2_4 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L3dt = 377*dphidt*iLq_L3 + (377*(vTLLd_TL_3_4 - RL_L3*iLd_L3))/LL_L3;
diLq_L3dt = (377*(vTLLq_TL_3_4 - RL_L3*iLq_L3))/LL_L3 - 377*dphidt*iLd_L3;
diLd_L4dt = 377*dphidt*iLq_L4 + (377*(vTLRd_TL_1_4 - RL_L4*iLd_L4))/LL_L4;
diLq_L4dt = (377*(vTLRq_TL_1_4 - RL_L4*iLq_L4))/LL_L4 - 377*dphidt*iLd_L4;
diLd_PV2dt = 377*dphidt*iLq_PV2 + (377*(vTLLd_TL_2_4 - RL_PV2*iLd_PV2))/LL_PV2;
diLq_PV2dt = (377*(vTLLq_TL_2_4 - RL_PV2*iLq_PV2))/LL_PV2 - 377*dphidt*iLd_PV2;
dvTLLd_TL_1_4dt = 377*dphidt*vTLLq_TL_1_4 - (377*(iLd_L1 - iSd_G23 + iTLMd_TL_1_4))/CTL_TL_1_4;
dvTLLq_TL_1_4dt = - 377*dphidt*vTLLd_TL_1_4 - (377*(iLq_L1 - iSq_G23 + iTLMq_TL_1_4))/CTL_TL_1_4;
diTLMd_TL_1_4dt = 377*dphidt*iTLMq_TL_1_4 - (377*(vTLRd_TL_1_4 - vTLLd_TL_1_4 + RTL_TL_1_4*iTLMd_TL_1_4))/LTL_TL_1_4;
diTLMq_TL_1_4dt = - 377*dphidt*iTLMd_TL_1_4 - (377*(vTLRq_TL_1_4 - vTLLq_TL_1_4 + RTL_TL_1_4*iTLMq_TL_1_4))/LTL_TL_1_4;
dvTLRd_TL_1_4dt = (377*(iTLMd_TL_1_4 - iLd_L4 + iTLMd_TL_2_4 + iTLMd_TL_3_4 + CTL_TL_1_4*dphidt*vTLRq_TL_1_4 + CTL_TL_2_4*dphidt*vTLRq_TL_1_4 + CTL_TL_3_4*dphidt*vTLRq_TL_1_4))/(CTL_TL_1_4 + CTL_TL_2_4 + CTL_TL_3_4);
dvTLRq_TL_1_4dt = -(377*(iLq_L4 - iTLMq_TL_1_4 - iTLMq_TL_2_4 - iTLMq_TL_3_4 + CTL_TL_1_4*dphidt*vTLRd_TL_1_4 + CTL_TL_2_4*dphidt*vTLRd_TL_1_4 + CTL_TL_3_4*dphidt*vTLRd_TL_1_4))/(CTL_TL_1_4 + CTL_TL_2_4 + CTL_TL_3_4);
dvTLLd_TL_2_4dt = 377*dphidt*vTLLq_TL_2_4 - (377*(iLd_L2 + iLd_PV2 + iTLMd_TL_2_4))/CTL_TL_2_4;
dvTLLq_TL_2_4dt = - 377*dphidt*vTLLd_TL_2_4 - (377*(iLq_L2 + iLq_PV2 + iTLMq_TL_2_4))/CTL_TL_2_4;
diTLMd_TL_2_4dt = 377*dphidt*iTLMq_TL_2_4 - (377*(vTLRd_TL_1_4 - vTLLd_TL_2_4 + RTL_TL_2_4*iTLMd_TL_2_4))/LTL_TL_2_4;
diTLMq_TL_2_4dt = - 377*dphidt*iTLMd_TL_2_4 - (377*(vTLRq_TL_1_4 - vTLLq_TL_2_4 + RTL_TL_2_4*iTLMq_TL_2_4))/LTL_TL_2_4;
dvTLLd_TL_3_4dt = 377*dphidt*vTLLq_TL_3_4 - (377*(iLd_L3 - iSd_G22 + iTLMd_TL_3_4))/CTL_TL_3_4;
dvTLLq_TL_3_4dt = - 377*dphidt*vTLLd_TL_3_4 - (377*(iLq_L3 - iSq_G22 + iTLMq_TL_3_4))/CTL_TL_3_4;
diTLMd_TL_3_4dt = 377*dphidt*iTLMq_TL_3_4 - (377*(vTLRd_TL_1_4 - vTLLd_TL_3_4 + RTL_TL_3_4*iTLMd_TL_3_4))/LTL_TL_3_4;
diTLMq_TL_3_4dt = - 377*dphidt*iTLMd_TL_3_4 - (377*(vTLRq_TL_1_4 - vTLLq_TL_3_4 + RTL_TL_3_4*iTLMq_TL_3_4))/LTL_TL_3_4;
dx = [diSd_G22dt
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
diLd_L2dt
diLq_L2dt
diLd_L3dt
diLq_L3dt
diLd_L4dt
diLq_L4dt
diLd_PV2dt
diLq_PV2dt
dvTLLd_TL_1_4dt
dvTLLq_TL_1_4dt
diTLMd_TL_1_4dt
diTLMq_TL_1_4dt
dvTLRd_TL_1_4dt
dvTLRq_TL_1_4dt
dvTLLd_TL_2_4dt
dvTLLq_TL_2_4dt
diTLMd_TL_2_4dt
diTLMq_TL_2_4dt
dvTLLd_TL_3_4dt
dvTLLq_TL_3_4dt
diTLMd_TL_3_4dt
diTLMq_TL_3_4dt
];
end

save('DataReducedMicrogrid1.mat')
iSd_G22 = x(:,1);
iSq_G22 = x(:,2);
iRd_G22 = x(:,3);
iRq_G22 = x(:,4);
iF_G22 = x(:,5);
delta_G22 = x(:,6);
omega_G22 = x(:,7);
iSd_G23 = x(:,8);
iSq_G23 = x(:,9);
iRd_G23 = x(:,10);
iRq_G23 = x(:,11);
iF_G23 = x(:,12);
delta_G23 = x(:,13);
omega_G23 = x(:,14);
iLd_L1 = x(:,15);
iLq_L1 = x(:,16);
iLd_L2 = x(:,17);
iLq_L2 = x(:,18);
iLd_L3 = x(:,19);
iLq_L3 = x(:,20);
iLd_L4 = x(:,21);
iLq_L4 = x(:,22);
iLd_PV2 = x(:,23);
iLq_PV2 = x(:,24);
vTLLd_TL_1_4 = x(:,25);
vTLLq_TL_1_4 = x(:,26);
iTLMd_TL_1_4 = x(:,27);
iTLMq_TL_1_4 = x(:,28);
vTLRd_TL_1_4 = x(:,29);
vTLRq_TL_1_4 = x(:,30);
vTLLd_TL_2_4 = x(:,31);
vTLLq_TL_2_4 = x(:,32);
iTLMd_TL_2_4 = x(:,33);
iTLMq_TL_2_4 = x(:,34);
vTLLd_TL_3_4 = x(:,35);
vTLLq_TL_3_4 = x(:,36);
iTLMd_TL_3_4 = x(:,37);
iTLMq_TL_3_4 = x(:,38);

figure(1);
subplot(2,1,1)
plot(t,iSd_G23,'b',t,iSq_G23,'r');
title('Stator Currents of G23');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G23,'b',t,iRq_G23,'r',t,iF_G23,'k');
title('Rotor Currents of G23');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(2);
plot(t,delta_G23,t,omega_G23)
title('Rotor Mechanical states of G23')
xlabel('Time (in seconds)');
ylabel ('in p.u.')
legend('Rotor Relative angle','Rotor angular frequency');

figure(3);
subplot(2,1,1)
plot(t,iSd_G22,'b',t,iSq_G22,'r');
title('Stator Currents of G22');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G22,'b',t,iRq_G22,'r',t,iF_G22,'k');
title('Rotor Currents of G22');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(4);
plot(t,delta_G22,t,omega_G22)
title('Rotor Mechanical states of G22')
xlabel('Time (in seconds)');
ylabel ('in p.u.')
legend('Rotor Relative angle','Rotor angular frequency');

figure(5);
plot(t,vTLLd_TL_1_2,'b',t,vTLLq_TL_1_2,'r');
title('Voltages at bus 1');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(6);
plot(t,vTLRd_TL_1_2,'b',t,vTLRq_TL_1_2,'r');
title('Voltages at bus 2');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(7);
plot(t,vTLRd_TL_1_3,'b',t,vTLRq_TL_1_3,'r');
title('Voltages at bus 3');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');
end
