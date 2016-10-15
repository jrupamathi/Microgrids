function RunMicrogridWithoutIMShortLinePQLoad
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
 
load('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');
load('TL_1_3.mat', 'LTL_TL_1_3', 'RTL_TL_1_3','CTL_TL_1_3');
load('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');

load('TL_3_5.mat', 'LTL_TL_3_5', 'RTL_TL_3_5','CTL_TL_3_5');
load('TL_3_11.mat', 'LTL_TL_3_11', 'RTL_TL_3_11','CTL_TL_3_11');

load('TL_22_6.mat', 'LTL_TL_22_6', 'RTL_TL_22_6','CTL_TL_22_6');
load('TL_22_12.mat', 'LTL_TL_22_12', 'RTL_TL_22_12','CTL_TL_22_12');
load('TL_22_15.mat', 'LTL_TL_22_15', 'RTL_TL_22_15','CTL_TL_22_15');

load('TL_6_13.mat', 'LTL_TL_6_13', 'RTL_TL_6_13','CTL_TL_6_13');
load('TL_6_14.mat', 'LTL_TL_6_14', 'RTL_TL_6_14','CTL_TL_6_14');

load('TL_5_16.mat', 'LTL_TL_5_16', 'RTL_TL_5_16','CTL_TL_5_16');
load('TL_5_17.mat', 'LTL_TL_5_17', 'RTL_TL_5_17','CTL_TL_5_17');
load('TL_5_21.mat', 'LTL_TL_5_21', 'RTL_TL_5_21','CTL_TL_5_21');
load('TL_5_18.mat', 'LTL_TL_5_18', 'RTL_TL_5_18','CTL_TL_5_18');
load('TL_5_19.mat', 'LTL_TL_5_19', 'RTL_TL_5_19','CTL_TL_5_19');
load('TL_5_20.mat', 'LTL_TL_5_20', 'RTL_TL_5_20','CTL_TL_5_20');


load('L2.mat', 'RL_L2', 'LL_L2');
load('L11.mat', 'RL_L11', 'LL_L11');
load('L12.mat', 'RL_L12', 'LL_L12');
load('L13.mat', 'RL_L13', 'LL_L13');
load('L14.mat', 'RL_L14', 'LL_L14');
load('L15.mat', 'RL_L15', 'LL_L15');
load('L16.mat', 'RL_L16', 'LL_L16');
load('L17.mat', 'RL_L17', 'LL_L17');
load('L18.mat', 'RL_L18', 'LL_L18');
load('L19.mat', 'RL_L19', 'LL_L19');
load('PV21.mat', 'RL_PV21', 'LL_PV21');
RL_PV21 = -4.635; LL_PV21 = -1.9776;
dphidt =1;
x0 = [-3.3889
   -0.5623
    0.1733
    2.9109
   -0.8919
   -0.1335
    0.9966
    0.9488
    0.8291
    0.5885
   -1.6792
   -1.7660
  -17.5470
    1.1083
   -0.1071
    0.3110
   -0.0077
    0.0276
   -0.0214
    0.0359
   -0.0355
    0.0929
   -0.0729
    0.3258
    0.0475
    0.3880
   -0.1429
    0.8309
   -0.0075
    0.0483
   -0.0120
    0.0542
   -0.0346
    0.0524
    0.0551
   -0.1708
   -0.4951
    0.9726
    3.2766
    0.8718
   -0.4946
    0.6853
   -1.5070
   -0.7093
   -0.5153
    0.9876
   -2.1824
    0.3551
   -0.5175
    0.9891
   -0.8345
   -0.6209
   -0.6546
    0.9327
   -0.1805
   -0.1736
   -0.6678
    0.9556
   -0.4103
    0.8559
   -0.7841
    1.0336
   -0.2005
   -0.0266
   -0.6190
    0.9635
   -0.2202
    0.0257
   -0.6101
    0.9704
   -0.2568
    0.2651
   -0.5983
    0.9730
    0.0266
   -0.1931
   -0.6643
    0.8941
   -0.8321
   -0.1732
   -0.5153
    0.9875
   -0.1434
    0.8308
   -0.4698
    1.0016
    0.1858
    0.1375
   -0.8490
    0.9780
    0.1802
    0.1427
   -0.8482
    0.9746
   -0.6624
   -0.2524
   -0.6245
    0.9346];
   tspan = [0,1];
   tic
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%,Options,tauL_IM2);
   
    toc
   
function [dx] = LLMicrogridDynamics(t,x)%,tauL_IM2)
t
iSd_G23 = x(1);
iSq_G23 = x(2);
iRd_G23 = x(3);
iRq_G23 = x(4);
iF_G23 = x(5);
delta_G23 = x(6);
omega_G23 = x(7);
iSd_G22 = x(8);
iSq_G22 = x(9);
iRd_G22 = x(10);
iRq_G22 = x(11);
iF_G22 = x(12);
delta_G22 = x(13);
omega_G22 = x(14);
iLd_L2 = x(15);
iLq_L2 = x(16);
iLd_L16 = x(17);
iLq_L16 = x(18);
iLd_L17 = x(19);
iLq_L17 = x(20);
iLd_L18 = x(21);
iLq_L18 = x(22);
iLd_L19 = x(23);
iLq_L19 = x(24);
iLd_L14 = x(25);
iLq_L14 = x(26);
iLd_L15 = x(27);
iLq_L15 = x(28);
iLd_L12 = x(29);
iLq_L12 = x(30);
iLd_L13 = x(31);
iLq_L13 = x(32);
iLd_L11 = x(33);
iLq_L11 = x(34);
iLd_PV21 = x(35);
iLq_PV21 = x(36);
vTLLd_TL_1_23 = x(37);
vTLLq_TL_1_23 = x(38);
iTLMd_TL_1_23 = x(39);
iTLMq_TL_1_23 = x(40);
vTLRd_TL_1_23 = x(41);
vTLRq_TL_1_23 = x(42);
iTLMd_TL_1_3 = x(43);
iTLMq_TL_1_3 = x(44);
vTLRd_TL_1_3 = x(45);
vTLRq_TL_1_3 = x(46);
iTLMd_TL_1_22 = x(47);
iTLMq_TL_1_22 = x(48);
vTLRd_TL_1_22 = x(49);
vTLRq_TL_1_22 = x(50);
iTLMd_TL_3_5 = x(51);
iTLMq_TL_3_5 = x(52);
vTLRd_TL_3_5 = x(53);
vTLRq_TL_3_5 = x(54);
iTLMd_TL_3_11 = x(55);
iTLMq_TL_3_11 = x(56);
vTLRd_TL_3_11 = x(57);
vTLRq_TL_3_11 = x(58);
iTLMd_TL_5_16 = x(59);
iTLMq_TL_5_16 = x(60);
vTLRd_TL_5_16 = x(61);
vTLRq_TL_5_16 = x(62);
iTLMd_TL_5_17 = x(63);
iTLMq_TL_5_17 = x(64);
vTLRd_TL_5_17 = x(65);
vTLRq_TL_5_17 = x(66);
iTLMd_TL_5_18 = x(67);
iTLMq_TL_5_18 = x(68);
vTLRd_TL_5_18 = x(69);
vTLRq_TL_5_18 = x(70);
iTLMd_TL_5_19 = x(71);
iTLMq_TL_5_19 = x(72);
vTLRd_TL_5_19 = x(73);
vTLRq_TL_5_19 = x(74);
iTLMd_TL_5_21 = x(75);
iTLMq_TL_5_21 = x(76);
vTLRd_TL_5_21 = x(77);
vTLRq_TL_5_21 = x(78);
iTLMd_TL_22_6 = x(79);
iTLMq_TL_22_6 = x(80);
vTLRd_TL_22_6 = x(81);
vTLRq_TL_22_6 = x(82);
iTLMd_TL_22_15 = x(83);
iTLMq_TL_22_15 = x(84);
vTLRd_TL_22_15 = x(85);
vTLRq_TL_22_15 = x(86);
iTLMd_TL_22_12 = x(87);
iTLMq_TL_22_12 = x(88);
vTLRd_TL_22_12 = x(89);
vTLRq_TL_22_12 = x(90);
iTLMd_TL_6_13 = x(91);
iTLMq_TL_6_13 = x(92);
vTLRd_TL_6_13 = x(93);
vTLRq_TL_6_13 = x(94);
iTLMd_TL_6_14 = x(95);
iTLMq_TL_6_14 = x(96);
vTLRd_TL_6_14 = x(97);
vTLRq_TL_6_14 = x(98);
PL = 0.15; QL = 0.1;
% k1 = 0.01; k2 = 0.01;
k1 = 4.59; k2 = 0.57;%other
(vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)
% RL_PV21= PL*(vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)/(PL^2 + QL^2); 
% LL_PV21= QL*(vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)/(PL^2 + QL^2);

tauL_G22 = tauL_G22_ref - K11_G22*(delta_G22 - delta_G22_ref) - K12_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K26_G22*(iF_G22 - k1*iF_G22_ref);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
% vR_G22 = vR_G22_ref - K26_G22*(sqrt(vTLRd_TL_1_22^2+vTLRq_TL_1_22^2) - 0.95*1.2);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
tauL_G23 = tauL_G23_ref - K11_G23*(delta_G23 - delta_G23_ref) - K12_G23*(omega_G23 - omega_G23_ref);
vR_G23 = vR_G23_ref - K26_G23*(iF_G23 - k2*iF_G23_ref);% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
% vR_G23 = vR_G23_ref - K26_G23*(sqrt(vTLRd_TL_1_23^2+vTLRq_TL_1_23^2) - 0.95*1.1);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);

diSd_G23dt = 377*vTLRd_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((Rkd_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iSq_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRq_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*vTLRq_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + 377*iRd_G23*((Rkd_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iSd_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRd_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*Rkq_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLRd_TL_1_23 + iSq_G23*vTLRq_TL_1_23)/(2*H_G23);
diSd_G22dt = 377*vTLRd_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_1_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_1_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLRd_TL_1_22 + iSq_G22*vTLRq_TL_1_22)/(2*H_G22);
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_23 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_23 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - RL_L16*iLd_L16))/LL_L16;
diLq_L16dt = (377*(vTLRq_TL_5_16 - RL_L16*iLq_L16))/LL_L16 - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_5_17 - RL_L17*iLd_L17))/LL_L17;
diLq_L17dt = (377*(vTLRq_TL_5_17 - RL_L17*iLq_L17))/LL_L17 - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_5_18 - RL_L18*iLd_L18))/LL_L18;
diLq_L18dt = (377*(vTLRq_TL_5_18 - RL_L18*iLq_L18))/LL_L18 - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_5_19 - RL_L19*iLd_L19))/LL_L19;
diLq_L19dt = (377*(vTLRq_TL_5_19 - RL_L19*iLq_L19))/LL_L19 - 377*dphidt*iLd_L19;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_6_14 - RL_L14*iLd_L14))/LL_L14;
diLq_L14dt = (377*(vTLRq_TL_6_14 - RL_L14*iLq_L14))/LL_L14 - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_22_15 - RL_L15*iLd_L15))/LL_L15;
diLq_L15dt = (377*(vTLRq_TL_22_15 - RL_L15*iLq_L15))/LL_L15 - 377*dphidt*iLd_L15;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_22_12 - RL_L12*iLd_L12))/LL_L12;
diLq_L12dt = (377*(vTLRq_TL_22_12 - RL_L12*iLq_L12))/LL_L12 - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_6_13 - RL_L13*iLd_L13))/LL_L13;
diLq_L13dt = (377*(vTLRq_TL_6_13 - RL_L13*iLq_L13))/LL_L13 - 377*dphidt*iLd_L13;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_3_11 - RL_L11*iLd_L11))/LL_L11;
diLq_L11dt = (377*(vTLRq_TL_3_11 - RL_L11*iLq_L11))/LL_L11 - 377*dphidt*iLd_L11;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_5_21 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLRq_TL_5_21 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;
dvTLLd_TL_1_23dt = -(377*(iTLMd_TL_1_3 + iTLMd_TL_1_22 + iTLMd_TL_1_23 - CTL_TL_1_3*dphidt*vTLLq_TL_1_23 - CTL_TL_1_22*dphidt*vTLLq_TL_1_23 - CTL_TL_1_23*dphidt*vTLLq_TL_1_23))/(CTL_TL_1_3 + CTL_TL_1_22 + CTL_TL_1_23);
dvTLLq_TL_1_23dt = -(377*(iTLMq_TL_1_3 + iTLMq_TL_1_22 + iTLMq_TL_1_23 + CTL_TL_1_3*dphidt*vTLLd_TL_1_23 + CTL_TL_1_22*dphidt*vTLLd_TL_1_23 + CTL_TL_1_23*dphidt*vTLLd_TL_1_23))/(CTL_TL_1_3 + CTL_TL_1_22 + CTL_TL_1_23);
diTLMd_TL_1_23dt = 377*dphidt*iTLMq_TL_1_23 - (377*(vTLRd_TL_1_23 - vTLLd_TL_1_23 + RTL_TL_1_23*iTLMd_TL_1_23))/LTL_TL_1_23;
diTLMq_TL_1_23dt = - 377*dphidt*iTLMd_TL_1_23 - (377*(vTLRq_TL_1_23 - vTLLq_TL_1_23 + RTL_TL_1_23*iTLMq_TL_1_23))/LTL_TL_1_23;
dvTLRd_TL_1_23dt = 377*dphidt*vTLRq_TL_1_23 + (377*(iSd_G23 - iLd_L2 + iTLMd_TL_1_23))/CTL_TL_1_23;
dvTLRq_TL_1_23dt = (377*(iSq_G23 - iLq_L2 + iTLMq_TL_1_23))/CTL_TL_1_23 - 377*dphidt*vTLRd_TL_1_23;
diTLMd_TL_1_3dt = 377*dphidt*iTLMq_TL_1_3 - (377*(vTLRd_TL_1_3 - vTLLd_TL_1_23 + RTL_TL_1_3*iTLMd_TL_1_3))/LTL_TL_1_3;
diTLMq_TL_1_3dt = - 377*dphidt*iTLMd_TL_1_3 - (377*(vTLRq_TL_1_3 - vTLLq_TL_1_23 + RTL_TL_1_3*iTLMq_TL_1_3))/LTL_TL_1_3;
dvTLRd_TL_1_3dt = (377*(iTLMd_TL_1_3 - iTLMd_TL_3_5 - iTLMd_TL_3_11 + CTL_TL_1_3*dphidt*vTLRq_TL_1_3 + CTL_TL_3_5*dphidt*vTLRq_TL_1_3 + CTL_TL_3_11*dphidt*vTLRq_TL_1_3))/(CTL_TL_1_3 + CTL_TL_3_5 + CTL_TL_3_11);
dvTLRq_TL_1_3dt = -(377*(iTLMq_TL_3_5 - iTLMq_TL_1_3 + iTLMq_TL_3_11 + CTL_TL_1_3*dphidt*vTLRd_TL_1_3 + CTL_TL_3_5*dphidt*vTLRd_TL_1_3 + CTL_TL_3_11*dphidt*vTLRd_TL_1_3))/(CTL_TL_1_3 + CTL_TL_3_5 + CTL_TL_3_11);
diTLMd_TL_1_22dt = 377*dphidt*iTLMq_TL_1_22 - (377*(vTLRd_TL_1_22 - vTLLd_TL_1_23 + RTL_TL_1_22*iTLMd_TL_1_22))/LTL_TL_1_22;
diTLMq_TL_1_22dt = - 377*dphidt*iTLMd_TL_1_22 - (377*(vTLRq_TL_1_22 - vTLLq_TL_1_23 + RTL_TL_1_22*iTLMq_TL_1_22))/LTL_TL_1_22;
dvTLRd_TL_1_22dt = (377*(iSd_G22 + iTLMd_TL_1_22 - iTLMd_TL_22_6 - iTLMd_TL_22_12 - iTLMd_TL_22_15 + CTL_TL_1_22*dphidt*vTLRq_TL_1_22 + CTL_TL_22_6*dphidt*vTLRq_TL_1_22 + CTL_TL_22_12*dphidt*vTLRq_TL_1_22 + CTL_TL_22_15*dphidt*vTLRq_TL_1_22))/(CTL_TL_1_22 + CTL_TL_22_6 + CTL_TL_22_12 + CTL_TL_22_15);
dvTLRq_TL_1_22dt = -(377*(iTLMq_TL_22_6 - iTLMq_TL_1_22 - iSq_G22 + iTLMq_TL_22_12 + iTLMq_TL_22_15 + CTL_TL_1_22*dphidt*vTLRd_TL_1_22 + CTL_TL_22_6*dphidt*vTLRd_TL_1_22 + CTL_TL_22_12*dphidt*vTLRd_TL_1_22 + CTL_TL_22_15*dphidt*vTLRd_TL_1_22))/(CTL_TL_1_22 + CTL_TL_22_6 + CTL_TL_22_12 + CTL_TL_22_15);
diTLMd_TL_3_5dt = 377*dphidt*iTLMq_TL_3_5 - (377*(vTLRd_TL_3_5 - vTLRd_TL_1_3 + RTL_TL_3_5*iTLMd_TL_3_5))/LTL_TL_3_5;
diTLMq_TL_3_5dt = - 377*dphidt*iTLMd_TL_3_5 - (377*(vTLRq_TL_3_5 - vTLRq_TL_1_3 + RTL_TL_3_5*iTLMq_TL_3_5))/LTL_TL_3_5;
dvTLRd_TL_3_5dt = (377*(iTLMd_TL_3_5 - iTLMd_TL_5_16 - iTLMd_TL_5_17 - iTLMd_TL_5_18 - iTLMd_TL_5_19 - iTLMd_TL_5_21 + CTL_TL_3_5*dphidt*vTLRq_TL_3_5 + CTL_TL_5_16*dphidt*vTLRq_TL_3_5 + CTL_TL_5_17*dphidt*vTLRq_TL_3_5 + CTL_TL_5_18*dphidt*vTLRq_TL_3_5 + CTL_TL_5_19*dphidt*vTLRq_TL_3_5 + CTL_TL_5_21*dphidt*vTLRq_TL_3_5))/(CTL_TL_3_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
dvTLRq_TL_3_5dt = -(377*(iTLMq_TL_5_16 - iTLMq_TL_3_5 + iTLMq_TL_5_17 + iTLMq_TL_5_18 + iTLMq_TL_5_19 + iTLMq_TL_5_21 + CTL_TL_3_5*dphidt*vTLRd_TL_3_5 + CTL_TL_5_16*dphidt*vTLRd_TL_3_5 + CTL_TL_5_17*dphidt*vTLRd_TL_3_5 + CTL_TL_5_18*dphidt*vTLRd_TL_3_5 + CTL_TL_5_19*dphidt*vTLRd_TL_3_5 + CTL_TL_5_21*dphidt*vTLRd_TL_3_5))/(CTL_TL_3_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
diTLMd_TL_3_11dt = 377*dphidt*iTLMq_TL_3_11 - (377*(vTLRd_TL_3_11 - vTLRd_TL_1_3 + RTL_TL_3_11*iTLMd_TL_3_11))/LTL_TL_3_11;
diTLMq_TL_3_11dt = - 377*dphidt*iTLMd_TL_3_11 - (377*(vTLRq_TL_3_11 - vTLRq_TL_1_3 + RTL_TL_3_11*iTLMq_TL_3_11))/LTL_TL_3_11;
dvTLRd_TL_3_11dt = 377*dphidt*vTLRq_TL_3_11 - (377*(iLd_L11 - iTLMd_TL_3_11))/CTL_TL_3_11;
dvTLRq_TL_3_11dt = - 377*dphidt*vTLRd_TL_3_11 - (377*(iLq_L11 - iTLMq_TL_3_11))/CTL_TL_3_11;
diTLMd_TL_5_16dt = 377*dphidt*iTLMq_TL_5_16 - (377*(vTLRd_TL_5_16 - vTLRd_TL_3_5 + RTL_TL_5_16*iTLMd_TL_5_16))/LTL_TL_5_16;
diTLMq_TL_5_16dt = - 377*dphidt*iTLMd_TL_5_16 - (377*(vTLRq_TL_5_16 - vTLRq_TL_3_5 + RTL_TL_5_16*iTLMq_TL_5_16))/LTL_TL_5_16;
dvTLRd_TL_5_16dt = 377*dphidt*vTLRq_TL_5_16 - (377*(iLd_L16 - iTLMd_TL_5_16))/CTL_TL_5_16;
dvTLRq_TL_5_16dt = - 377*dphidt*vTLRd_TL_5_16 - (377*(iLq_L16 - iTLMq_TL_5_16))/CTL_TL_5_16;
diTLMd_TL_5_17dt = 377*dphidt*iTLMq_TL_5_17 - (377*(vTLRd_TL_5_17 - vTLRd_TL_3_5 + RTL_TL_5_17*iTLMd_TL_5_17))/LTL_TL_5_17;
diTLMq_TL_5_17dt = - 377*dphidt*iTLMd_TL_5_17 - (377*(vTLRq_TL_5_17 - vTLRq_TL_3_5 + RTL_TL_5_17*iTLMq_TL_5_17))/LTL_TL_5_17;
dvTLRd_TL_5_17dt = 377*dphidt*vTLRq_TL_5_17 - (377*(iLd_L17 - iTLMd_TL_5_17))/CTL_TL_5_17;
dvTLRq_TL_5_17dt = - 377*dphidt*vTLRd_TL_5_17 - (377*(iLq_L17 - iTLMq_TL_5_17))/CTL_TL_5_17;
diTLMd_TL_5_18dt = 377*dphidt*iTLMq_TL_5_18 - (377*(vTLRd_TL_5_18 - vTLRd_TL_3_5 + RTL_TL_5_18*iTLMd_TL_5_18))/LTL_TL_5_18;
diTLMq_TL_5_18dt = - 377*dphidt*iTLMd_TL_5_18 - (377*(vTLRq_TL_5_18 - vTLRq_TL_3_5 + RTL_TL_5_18*iTLMq_TL_5_18))/LTL_TL_5_18;
dvTLRd_TL_5_18dt = 377*dphidt*vTLRq_TL_5_18 - (377*(iLd_L18 - iTLMd_TL_5_18))/CTL_TL_5_18;
dvTLRq_TL_5_18dt = - 377*dphidt*vTLRd_TL_5_18 - (377*(iLq_L18 - iTLMq_TL_5_18))/CTL_TL_5_18;
diTLMd_TL_5_19dt = 377*dphidt*iTLMq_TL_5_19 - (377*(vTLRd_TL_5_19 - vTLRd_TL_3_5 + RTL_TL_5_19*iTLMd_TL_5_19))/LTL_TL_5_19;
diTLMq_TL_5_19dt = - 377*dphidt*iTLMd_TL_5_19 - (377*(vTLRq_TL_5_19 - vTLRq_TL_3_5 + RTL_TL_5_19*iTLMq_TL_5_19))/LTL_TL_5_19;
dvTLRd_TL_5_19dt = 377*dphidt*vTLRq_TL_5_19 - (377*(iLd_L19 - iTLMd_TL_5_19))/CTL_TL_5_19;
dvTLRq_TL_5_19dt = - 377*dphidt*vTLRd_TL_5_19 - (377*(iLq_L19 - iTLMq_TL_5_19))/CTL_TL_5_19;
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLRd_TL_3_5 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLRq_TL_3_5 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
diTLMd_TL_22_6dt = 377*dphidt*iTLMq_TL_22_6 - (377*(vTLRd_TL_22_6 - vTLRd_TL_1_22 + RTL_TL_22_6*iTLMd_TL_22_6))/LTL_TL_22_6;
diTLMq_TL_22_6dt = - 377*dphidt*iTLMd_TL_22_6 - (377*(vTLRq_TL_22_6 - vTLRq_TL_1_22 + RTL_TL_22_6*iTLMq_TL_22_6))/LTL_TL_22_6;
dvTLRd_TL_22_6dt = (377*(iTLMd_TL_22_6 - iTLMd_TL_6_13 - iTLMd_TL_6_14 + CTL_TL_22_6*dphidt*vTLRq_TL_22_6 + CTL_TL_6_13*dphidt*vTLRq_TL_22_6 + CTL_TL_6_14*dphidt*vTLRq_TL_22_6))/(CTL_TL_22_6 + CTL_TL_6_13 + CTL_TL_6_14);
dvTLRq_TL_22_6dt = -(377*(iTLMq_TL_6_13 - iTLMq_TL_22_6 + iTLMq_TL_6_14 + CTL_TL_22_6*dphidt*vTLRd_TL_22_6 + CTL_TL_6_13*dphidt*vTLRd_TL_22_6 + CTL_TL_6_14*dphidt*vTLRd_TL_22_6))/(CTL_TL_22_6 + CTL_TL_6_13 + CTL_TL_6_14);
diTLMd_TL_22_15dt = 377*dphidt*iTLMq_TL_22_15 - (377*(vTLRd_TL_22_15 - vTLRd_TL_1_22 + RTL_TL_22_15*iTLMd_TL_22_15))/LTL_TL_22_15;
diTLMq_TL_22_15dt = - 377*dphidt*iTLMd_TL_22_15 - (377*(vTLRq_TL_22_15 - vTLRq_TL_1_22 + RTL_TL_22_15*iTLMq_TL_22_15))/LTL_TL_22_15;
dvTLRd_TL_22_15dt = 377*dphidt*vTLRq_TL_22_15 - (377*(iLd_L15 - iTLMd_TL_22_15))/CTL_TL_22_15;
dvTLRq_TL_22_15dt = - 377*dphidt*vTLRd_TL_22_15 - (377*(iLq_L15 - iTLMq_TL_22_15))/CTL_TL_22_15;
diTLMd_TL_22_12dt = 377*dphidt*iTLMq_TL_22_12 - (377*(vTLRd_TL_22_12 - vTLRd_TL_1_22 + RTL_TL_22_12*iTLMd_TL_22_12))/LTL_TL_22_12;
diTLMq_TL_22_12dt = - 377*dphidt*iTLMd_TL_22_12 - (377*(vTLRq_TL_22_12 - vTLRq_TL_1_22 + RTL_TL_22_12*iTLMq_TL_22_12))/LTL_TL_22_12;
dvTLRd_TL_22_12dt = 377*dphidt*vTLRq_TL_22_12 - (377*(iLd_L12 - iTLMd_TL_22_12))/CTL_TL_22_12;
dvTLRq_TL_22_12dt = - 377*dphidt*vTLRd_TL_22_12 - (377*(iLq_L12 - iTLMq_TL_22_12))/CTL_TL_22_12;
diTLMd_TL_6_13dt = 377*dphidt*iTLMq_TL_6_13 - (377*(vTLRd_TL_6_13 - vTLRd_TL_22_6 + RTL_TL_6_13*iTLMd_TL_6_13))/LTL_TL_6_13;
diTLMq_TL_6_13dt = - 377*dphidt*iTLMd_TL_6_13 - (377*(vTLRq_TL_6_13 - vTLRq_TL_22_6 + RTL_TL_6_13*iTLMq_TL_6_13))/LTL_TL_6_13;
dvTLRd_TL_6_13dt = 377*dphidt*vTLRq_TL_6_13 - (377*(iLd_L13 - iTLMd_TL_6_13))/CTL_TL_6_13;
dvTLRq_TL_6_13dt = - 377*dphidt*vTLRd_TL_6_13 - (377*(iLq_L13 - iTLMq_TL_6_13))/CTL_TL_6_13;
diTLMd_TL_6_14dt = 377*dphidt*iTLMq_TL_6_14 - (377*(vTLRd_TL_6_14 - vTLRd_TL_22_6 + RTL_TL_6_14*iTLMd_TL_6_14))/LTL_TL_6_14;
diTLMq_TL_6_14dt = - 377*dphidt*iTLMd_TL_6_14 - (377*(vTLRq_TL_6_14 - vTLRq_TL_22_6 + RTL_TL_6_14*iTLMq_TL_6_14))/LTL_TL_6_14;
dvTLRd_TL_6_14dt = 377*dphidt*vTLRq_TL_6_14 - (377*(iLd_L14 - iTLMd_TL_6_14))/CTL_TL_6_14;
dvTLRq_TL_6_14dt = - 377*dphidt*vTLRd_TL_6_14 - (377*(iLq_L14 - iTLMq_TL_6_14))/CTL_TL_6_14;
dx = [diSd_G23dt
diSq_G23dt
diRd_G23dt
diRq_G23dt
diF_G23dt
ddelta_G23dt
domega_G23dt
diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diLd_L2dt
diLq_L2dt
diLd_L16dt
diLq_L16dt
diLd_L17dt
diLq_L17dt
diLd_L18dt
diLq_L18dt
diLd_L19dt
diLq_L19dt
diLd_L14dt
diLq_L14dt
diLd_L15dt
diLq_L15dt
diLd_L12dt
diLq_L12dt
diLd_L13dt
diLq_L13dt
diLd_L11dt
diLq_L11dt
diLd_PV21dt
diLq_PV21dt
dvTLLd_TL_1_23dt
dvTLLq_TL_1_23dt
diTLMd_TL_1_23dt
diTLMq_TL_1_23dt
dvTLRd_TL_1_23dt
dvTLRq_TL_1_23dt
diTLMd_TL_1_3dt
diTLMq_TL_1_3dt
dvTLRd_TL_1_3dt
dvTLRq_TL_1_3dt
diTLMd_TL_1_22dt
diTLMq_TL_1_22dt
dvTLRd_TL_1_22dt
dvTLRq_TL_1_22dt
diTLMd_TL_3_5dt
diTLMq_TL_3_5dt
dvTLRd_TL_3_5dt
dvTLRq_TL_3_5dt
diTLMd_TL_3_11dt
diTLMq_TL_3_11dt
dvTLRd_TL_3_11dt
dvTLRq_TL_3_11dt
diTLMd_TL_5_16dt
diTLMq_TL_5_16dt
dvTLRd_TL_5_16dt
dvTLRq_TL_5_16dt
diTLMd_TL_5_17dt
diTLMq_TL_5_17dt
dvTLRd_TL_5_17dt
dvTLRq_TL_5_17dt
diTLMd_TL_5_18dt
diTLMq_TL_5_18dt
dvTLRd_TL_5_18dt
dvTLRq_TL_5_18dt
diTLMd_TL_5_19dt
diTLMq_TL_5_19dt
dvTLRd_TL_5_19dt
dvTLRq_TL_5_19dt
diTLMd_TL_5_21dt
diTLMq_TL_5_21dt
dvTLRd_TL_5_21dt
dvTLRq_TL_5_21dt
diTLMd_TL_22_6dt
diTLMq_TL_22_6dt
dvTLRd_TL_22_6dt
dvTLRq_TL_22_6dt
diTLMd_TL_22_15dt
diTLMq_TL_22_15dt
dvTLRd_TL_22_15dt
dvTLRq_TL_22_15dt
diTLMd_TL_22_12dt
diTLMq_TL_22_12dt
dvTLRd_TL_22_12dt
dvTLRq_TL_22_12dt
diTLMd_TL_6_13dt
diTLMq_TL_6_13dt
dvTLRd_TL_6_13dt
dvTLRq_TL_6_13dt
diTLMd_TL_6_14dt
diTLMq_TL_6_14dt
dvTLRd_TL_6_14dt
dvTLRq_TL_6_14dt
];
end
iSd_G23 = x(:,1);
iSq_G23 = x(:,2);
iRd_G23 = x(:,3);
iRq_G23 = x(:,4);
iF_G23 = x(:,5);
delta_G23 = x(:,6);
omega_G23 = x(:,7);
iSd_G22 = x(:,8);
iSq_G22 = x(:,9);
iRd_G22 = x(:,10);
iRq_G22 = x(:,11);
iF_G22 = x(:,12);
delta_G22 = x(:,13);
omega_G22 = x(:,14);
iLd_L2 = x(:,15);
iLq_L2 = x(:,16);
iLd_L16 = x(:,17);
iLq_L16 = x(:,18);
iLd_L17 = x(:,19);
iLq_L17 = x(:,20);
iLd_L18 = x(:,21);
iLq_L18 = x(:,22);
iLd_L19 = x(:,23);
iLq_L19 = x(:,24);
iLd_L14 = x(:,25);
iLq_L14 = x(:,26);
iLd_L15 = x(:,27);
iLq_L15 = x(:,28);
iLd_L12 = x(:,29);
iLq_L12 = x(:,30);
iLd_L13 = x(:,31);
iLq_L13 = x(:,32);
iLd_L11 = x(:,33);
iLq_L11 = x(:,34);
iLd_PV21 = x(:,35);
iLq_PV21 = x(:,36);
vTLLd_TL_1_23 = x(:,37);
vTLLq_TL_1_23 = x(:,38);
iTLMd_TL_1_23 = x(:,39);
iTLMq_TL_1_23 = x(:,40);
vTLRd_TL_1_23 = x(:,41);
vTLRq_TL_1_23 = x(:,42);
iTLMd_TL_1_3 = x(:,43);
iTLMq_TL_1_3 = x(:,44);
vTLRd_TL_1_3 = x(:,45);
vTLRq_TL_1_3 = x(:,46);
iTLMd_TL_1_22 = x(:,47);
iTLMq_TL_1_22 = x(:,48);
vTLRd_TL_1_22 = x(:,49);
vTLRq_TL_1_22 = x(:,50);
iTLMd_TL_3_5 = x(:,51);
iTLMq_TL_3_5 = x(:,52);
vTLRd_TL_3_5 = x(:,53);
vTLRq_TL_3_5 = x(:,54);
iTLMd_TL_3_11 = x(:,55);
iTLMq_TL_3_11 = x(:,56);
vTLRd_TL_3_11 = x(:,57);
vTLRq_TL_3_11 = x(:,58);
iTLMd_TL_5_16 = x(:,59);
iTLMq_TL_5_16 = x(:,60);
vTLRd_TL_5_16 = x(:,61);
vTLRq_TL_5_16 = x(:,62);
iTLMd_TL_5_17 = x(:,63);
iTLMq_TL_5_17 = x(:,64);
vTLRd_TL_5_17 = x(:,65);
vTLRq_TL_5_17 = x(:,66);
iTLMd_TL_5_18 = x(:,67);
iTLMq_TL_5_18 = x(:,68);
vTLRd_TL_5_18 = x(:,69);
vTLRq_TL_5_18 = x(:,70);
iTLMd_TL_5_19 = x(:,71);
iTLMq_TL_5_19 = x(:,72);
vTLRd_TL_5_19 = x(:,73);
vTLRq_TL_5_19 = x(:,74);
iTLMd_TL_5_21 = x(:,75);
iTLMq_TL_5_21 = x(:,76);
vTLRd_TL_5_21 = x(:,77);
vTLRq_TL_5_21 = x(:,78);
iTLMd_TL_22_6 = x(:,79);
iTLMq_TL_22_6 = x(:,80);
vTLRd_TL_22_6 = x(:,81);
vTLRq_TL_22_6 = x(:,82);
iTLMd_TL_22_15 = x(:,83);
iTLMq_TL_22_15 = x(:,84);
vTLRd_TL_22_15 = x(:,85);
vTLRq_TL_22_15 = x(:,86);
iTLMd_TL_22_12 = x(:,87);
iTLMq_TL_22_12 = x(:,88);
vTLRd_TL_22_12 = x(:,89);
vTLRq_TL_22_12 = x(:,90);
iTLMd_TL_6_13 = x(:,91);
iTLMq_TL_6_13 = x(:,92);
vTLRd_TL_6_13 = x(:,93);
vTLRq_TL_6_13 = x(:,94);
iTLMd_TL_6_14 = x(:,95);
iTLMq_TL_6_14 = x(:,96);
vTLRd_TL_6_14 = x(:,97);
vTLRq_TL_6_14 = x(:,98);

figure(1);
iS23 = sqrt(iSd_G23.^2 + iSq_G23.^2);
iS22 = sqrt(iSd_G22.^2 + iSq_G22.^2);
% t = t(1:250); iS23 = iS23(1:250); iS22 = iS22(1:250);
% iF_G22 = iF_G22(1:250); iF_G23 = iF_G23(1:250);
% delta_G22 = delta_G22(1:250); delta_G23 = delta_G23(1:250);
% omega_G22 = omega_G22(1:250); omega_G23 = omega_G23(1:250);

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

V1 = (vTLLd_TL_1_23.^2 + vTLLq_TL_1_23.^2).^0.5;
V21 = (vTLRd_TL_5_21.^2 + vTLRq_TL_5_21.^2).^0.5;
V22 = (vTLRd_TL_1_22.^2 + vTLRq_TL_1_22.^2).^0.5;
V23 = (vTLRd_TL_1_23.^2 + vTLRq_TL_1_23.^2).^0.5;

phi1 = atan(vTLLq_TL_1_23./vTLLd_TL_1_23)*180/pi;
phi21 = atan(vTLRq_TL_5_21./vTLRd_TL_5_21)*180/pi;
phi22 = atan(vTLRq_TL_1_22./vTLRd_TL_1_22)*180/pi;
phi23 = atan(vTLRq_TL_1_23./vTLRd_TL_1_23)*180/pi;
V = [V1(end) V21(end) V22(end) V23(end)]

figure(3);
subplot(2,1,1)
plot(t,V23,'g',t,V21,'r',t,V22,'b',t,V1,'k');
title('Voltages at all the buses');
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

end