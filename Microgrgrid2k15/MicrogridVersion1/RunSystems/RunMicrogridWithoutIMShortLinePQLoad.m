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
 
load('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
load('TL_1_5.mat', 'LTL_TL_1_5','RTL_TL_1_5','CTL_TL_1_5');
load('TL_1_11.mat', 'LTL_TL_1_11','RTL_TL_1_11','CTL_TL_1_11');
load('TL_1_12.mat', 'LTL_TL_1_12','RTL_TL_1_12','CTL_TL_1_12');
load('TL_1_13.mat', 'LTL_TL_1_13','RTL_TL_1_13','CTL_TL_1_13');
load('TL_1_14.mat', 'LTL_TL_1_14','RTL_TL_1_14','CTL_TL_1_14');
load('TL_1_15.mat', 'LTL_TL_1_15','RTL_TL_1_15','CTL_TL_1_15');
load('TL_1_22.mat', 'LTL_TL_1_22','RTL_TL_1_22','CTL_TL_1_22');
load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
load('TL_5_16.mat', 'LTL_TL_5_16','RTL_TL_5_16','CTL_TL_5_16');
load('TL_5_17.mat', 'LTL_TL_5_17','RTL_TL_5_17','CTL_TL_5_17');
load('TL_5_21.mat', 'LTL_TL_5_21','RTL_TL_5_21','CTL_TL_5_21');
load('TL_5_18.mat', 'LTL_TL_5_18','RTL_TL_5_18','CTL_TL_5_18');
load('TL_5_19.mat', 'LTL_TL_5_19','RTL_TL_5_19','CTL_TL_5_19');
load('TL_5_21.mat', 'LTL_TL_5_21','RTL_TL_5_21','CTL_TL_5_21');

load('L2.mat', 'PL_L2', 'QL_L2');
load('L11.mat', 'PL_L11', 'QL_L11');
load('L12.mat', 'PL_L12', 'QL_L12');
load('L13.mat', 'PL_L13', 'QL_L13');
load('L14.mat', 'PL_L14', 'QL_L14');
load('L15.mat', 'PL_L15', 'QL_L15');
load('L16.mat', 'PL_L16', 'QL_L16');
load('L17.mat', 'PL_L17', 'QL_L17');
load('L18.mat', 'PL_L18', 'QL_L18');
load('L19.mat', 'PL_L19', 'QL_L19');
load('IM2.mat','LR_IM2','LRR_IM2','LS_IM2','LSS_IM2','M_IM2','RR_IM2','RS_IM2','J_IM2','tauL_IM2','B_IM2');
load('IM14.mat','LR_IM14','LRR_IM14','LS_IM14','LSS_IM14','M_IM14','RR_IM14','RS_IM14','J_IM14','tauL_IM14','B_IM14');
load('PV21.mat', 'PL_PV21', 'QL_PV21');
PL_PV21 = -0.1875; 
QL_PV21 = -0.08;
dphidt =1;
x0 = 0.9*[0.0363
    0.7003
   -0.0098
    0.0756
   -0.1969
    0.7800
    1.0001
   -0.0375
   -0.2402
   -0.0010
    0.0070
    1.2105
  -15.5066
    0.9998
    0.0486
   -0.0137
    0.0035
   -0.0005
    0.0050
    0.0010
    0.0107
   -0.0007
    0.0311
   -0.0069
    0.0312
   -0.0159
    0.1005
   -0.0163
    0.0058
   -0.0019
    0.0065
   -0.0017
    0.0082
    0.0004
   -0.0267
   -0.0038
    2.2595
    0.6359
    0.1043
   -0.0391
    2.4123
    0.4299
    0.0459
    0.0658
    2.3919
    0.6840
    0.0689
    0.0502
    2.3763
    0.5756
    0.0967
    0.0468
    2.3602
    0.6108
   -0.0969
   -0.0193
    1.8669
    0.9592
    2.0545
    0.5683
   -0.0729
    0.1507
    0.0297
    0.0771
    2.0114
    0.4589
    0.1262
   -0.0448
    1.5098
    0.4667
   -0.1155
   -1.2509
    3.0821
    1.0702
   -0.0098
    0.1110
    2.0810
    0.5627
   -0.0105
    0.1173
    2.0434
    0.5119
   -0.0280
    0.0987
    2.0514
    0.5282];
   tspan = [0,1];
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
vTLLd_TL_5_16 = x(37);
vTLLq_TL_5_16 = x(38);
iTLMd_TL_5_16 = x(39);
iTLMq_TL_5_16 = x(40);
vTLRd_TL_5_16 = x(41);
vTLRq_TL_5_16 = x(42);
iTLMd_TL_5_17 = x(43);
iTLMq_TL_5_17 = x(44);
vTLRd_TL_5_17 = x(45);
vTLRq_TL_5_17 = x(46);
iTLMd_TL_5_18 = x(47);
iTLMq_TL_5_18 = x(48);
vTLRd_TL_5_18 = x(49);
vTLRq_TL_5_18 = x(50);
iTLMd_TL_5_19 = x(51);
iTLMq_TL_5_19 = x(52);
vTLRd_TL_5_19 = x(53);
vTLRq_TL_5_19 = x(54);
iTLMd_TL_5_21 = x(55);
iTLMq_TL_5_21 = x(56);
vTLRd_TL_5_21 = x(57);
vTLRq_TL_5_21 = x(58);
vTLLd_TL_1_5 = x(59);
vTLLq_TL_1_5 = x(60);
iTLMd_TL_1_5 = x(61);
iTLMq_TL_1_5 = x(62);
iTLMd_TL_1_14 = x(63);
iTLMq_TL_1_14 = x(64);
vTLRd_TL_1_14 = x(65);
vTLRq_TL_1_14 = x(66);
iTLMd_TL_1_15 = x(67);
iTLMq_TL_1_15 = x(68);
vTLRd_TL_1_15 = x(69);
vTLRq_TL_1_15 = x(70);
iTLMd_TL_1_2 = x(71);
iTLMq_TL_1_2 = x(72);
vTLRd_TL_1_2 = x(73);
vTLRq_TL_1_2 = x(74);
iTLMd_TL_1_12 = x(75);
iTLMq_TL_1_12 = x(76);
vTLRd_TL_1_12 = x(77);
vTLRq_TL_1_12 = x(78);
iTLMd_TL_1_13 = x(79);
iTLMq_TL_1_13 = x(80);
vTLRd_TL_1_13 = x(81);
vTLRq_TL_1_13 = x(82);
iTLMd_TL_1_11 = x(83);
iTLMq_TL_1_11 = x(84);
vTLRd_TL_1_11 = x(85);
vTLRq_TL_1_11 = x(86);
tauL_G23 = tauL_G23_ref - K11_G23*(delta_G23 - delta_G23_ref) - K16_G23*(iF_G23 - iF_G23_ref) - K15_G23*(iRd_G23 - iRd_G23_ref) - K17_G23*(iRq_G23 - iRq_G23_ref) - K13_G23*(iSd_G23 - iSd_G23_ref) - K14_G23*(iSq_G23 - iSq_G23_ref) - K12_G23*(omega_G23 - omega_G23_ref);
vR_G23 = vR_G23_ref - K21_G23*(delta_G23 - delta_G23_ref) - K26_G23*(iF_G23 - iF_G23_ref) - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
tauL_G22 = tauL_G22_ref - K11_G22*(delta_G22 - delta_G22_ref) - K16_G22*(iF_G22 - iF_G22_ref) - K15_G22*(iRd_G22 - iRd_G22_ref) - K17_G22*(iRq_G22 - iRq_G22_ref) - K13_G22*(iSd_G22 - iSd_G22_ref) - K14_G22*(iSq_G22 - iSq_G22_ref) - K12_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K21_G22*(delta_G22 - delta_G22_ref) - K26_G22*(iF_G22 - iF_G22_ref) - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
diSd_G23dt = 377*vTLRd_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((Rkd_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iSq_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRq_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*vTLRq_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + 377*iRd_G23*((Rkd_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iSd_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRd_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*Rkq_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_2*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_2*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLRd_TL_1_2 + iSq_G23*vTLRq_TL_1_2)/(2*H_G23);
diSd_G22dt = 377*vTLLd_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLLq_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLLq_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLLd_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLLd_TL_1_5*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLLq_TL_1_5*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLLd_TL_1_5 + iSq_G22*vTLLq_TL_1_5)/(2*H_G22);
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - (PL_L2*iLd_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2)/(PL_L2^2 + QL_L2^2))*(PL_L2^2 + QL_L2^2))/(QL_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2);
diLq_L2dt = (377*(vTLRq_TL_1_2 - (PL_L2*iLq_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2)/(PL_L2^2 + QL_L2^2))*(PL_L2^2 + QL_L2^2))/(QL_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2) - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - (PL_L16*iLd_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2)/(PL_L16^2 + QL_L16^2))*(PL_L16^2 + QL_L16^2))/(QL_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2);
diLq_L16dt = (377*(vTLRq_TL_5_16 - (PL_L16*iLq_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2)/(PL_L16^2 + QL_L16^2))*(PL_L16^2 + QL_L16^2))/(QL_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2) - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_5_17 - (PL_L17*iLd_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2)/(PL_L17^2 + QL_L17^2))*(PL_L17^2 + QL_L17^2))/(QL_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2);
diLq_L17dt = (377*(vTLRq_TL_5_17 - (PL_L17*iLq_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2)/(PL_L17^2 + QL_L17^2))*(PL_L17^2 + QL_L17^2))/(QL_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2) - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_5_18 - (PL_L18*iLd_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2)/(PL_L18^2 + QL_L18^2))*(PL_L18^2 + QL_L18^2))/(QL_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2);
diLq_L18dt = (377*(vTLRq_TL_5_18 - (PL_L18*iLq_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2)/(PL_L18^2 + QL_L18^2))*(PL_L18^2 + QL_L18^2))/(QL_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2) - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_5_19 - (PL_L19*iLd_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2)/(PL_L19^2 + QL_L19^2))*(PL_L19^2 + QL_L19^2))/(QL_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2);
diLq_L19dt = (377*(vTLRq_TL_5_19 - (PL_L19*iLq_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2)/(PL_L19^2 + QL_L19^2))*(PL_L19^2 + QL_L19^2))/(QL_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2) - 377*dphidt*iLd_L19;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_1_14 - (PL_L14*iLd_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2)/(PL_L14^2 + QL_L14^2))*(PL_L14^2 + QL_L14^2))/(QL_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2);
diLq_L14dt = (377*(vTLRq_TL_1_14 - (PL_L14*iLq_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2)/(PL_L14^2 + QL_L14^2))*(PL_L14^2 + QL_L14^2))/(QL_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2) - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_1_15 - (PL_L15*iLd_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2)/(PL_L15^2 + QL_L15^2))*(PL_L15^2 + QL_L15^2))/(QL_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2);
diLq_L15dt = (377*(vTLRq_TL_1_15 - (PL_L15*iLq_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2)/(PL_L15^2 + QL_L15^2))*(PL_L15^2 + QL_L15^2))/(QL_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2) - 377*dphidt*iLd_L15;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_1_12 - (PL_L12*iLd_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2)/(PL_L12^2 + QL_L12^2))*(PL_L12^2 + QL_L12^2))/(QL_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2);
diLq_L12dt = (377*(vTLRq_TL_1_12 - (PL_L12*iLq_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2)/(PL_L12^2 + QL_L12^2))*(PL_L12^2 + QL_L12^2))/(QL_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2) - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_1_13 - (PL_L13*iLd_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2)/(PL_L13^2 + QL_L13^2))*(PL_L13^2 + QL_L13^2))/(QL_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2);
diLq_L13dt = (377*(vTLRq_TL_1_13 - (PL_L13*iLq_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2)/(PL_L13^2 + QL_L13^2))*(PL_L13^2 + QL_L13^2))/(QL_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2) - 377*dphidt*iLd_L13;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_1_11 - (PL_L11*iLd_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2)/(PL_L11^2 + QL_L11^2))*(PL_L11^2 + QL_L11^2))/(QL_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2);
diLq_L11dt = (377*(vTLRq_TL_1_11 - (PL_L11*iLq_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2)/(PL_L11^2 + QL_L11^2))*(PL_L11^2 + QL_L11^2))/(QL_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2) - 377*dphidt*iLd_L11;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_5_21 - (PL_PV21*iLd_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2)/(PL_PV21^2 + QL_PV21^2))*(PL_PV21^2 + QL_PV21^2))/(QL_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2);
diLq_PV21dt = (377*(vTLRq_TL_5_21 - (PL_PV21*iLq_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2)/(PL_PV21^2 + QL_PV21^2))*(PL_PV21^2 + QL_PV21^2))/(QL_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2) - 377*dphidt*iLd_PV21;
dvTLLd_TL_5_16dt = (377*(iTLMd_TL_1_5 - iTLMd_TL_5_16 - iTLMd_TL_5_17 - iTLMd_TL_5_18 - iTLMd_TL_5_19 - iTLMd_TL_5_21 + CTL_TL_1_5*dphidt*vTLLq_TL_5_16 + CTL_TL_5_16*dphidt*vTLLq_TL_5_16 + CTL_TL_5_17*dphidt*vTLLq_TL_5_16 + CTL_TL_5_18*dphidt*vTLLq_TL_5_16 + CTL_TL_5_19*dphidt*vTLLq_TL_5_16 + CTL_TL_5_21*dphidt*vTLLq_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
dvTLLq_TL_5_16dt = -(377*(iTLMq_TL_5_16 - iTLMq_TL_1_5 + iTLMq_TL_5_17 + iTLMq_TL_5_18 + iTLMq_TL_5_19 + iTLMq_TL_5_21 + CTL_TL_1_5*dphidt*vTLLd_TL_5_16 + CTL_TL_5_16*dphidt*vTLLd_TL_5_16 + CTL_TL_5_17*dphidt*vTLLd_TL_5_16 + CTL_TL_5_18*dphidt*vTLLd_TL_5_16 + CTL_TL_5_19*dphidt*vTLLd_TL_5_16 + CTL_TL_5_21*dphidt*vTLLd_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
diTLMd_TL_5_16dt = 377*dphidt*iTLMq_TL_5_16 - (377*(vTLRd_TL_5_16 - vTLLd_TL_5_16 + RTL_TL_5_16*iTLMd_TL_5_16))/LTL_TL_5_16;
diTLMq_TL_5_16dt = - 377*dphidt*iTLMd_TL_5_16 - (377*(vTLRq_TL_5_16 - vTLLq_TL_5_16 + RTL_TL_5_16*iTLMq_TL_5_16))/LTL_TL_5_16;
dvTLRd_TL_5_16dt = 377*dphidt*vTLRq_TL_5_16 - (377*(iLd_L16 - iTLMd_TL_5_16))/CTL_TL_5_16;
dvTLRq_TL_5_16dt = - 377*dphidt*vTLRd_TL_5_16 - (377*(iLq_L16 - iTLMq_TL_5_16))/CTL_TL_5_16;
diTLMd_TL_5_17dt = 377*dphidt*iTLMq_TL_5_17 - (377*(vTLRd_TL_5_17 - vTLLd_TL_5_16 + RTL_TL_5_17*iTLMd_TL_5_17))/LTL_TL_5_17;
diTLMq_TL_5_17dt = - 377*dphidt*iTLMd_TL_5_17 - (377*(vTLRq_TL_5_17 - vTLLq_TL_5_16 + RTL_TL_5_17*iTLMq_TL_5_17))/LTL_TL_5_17;
dvTLRd_TL_5_17dt = 377*dphidt*vTLRq_TL_5_17 - (377*(iLd_L17 - iTLMd_TL_5_17))/CTL_TL_5_17;
dvTLRq_TL_5_17dt = - 377*dphidt*vTLRd_TL_5_17 - (377*(iLq_L17 - iTLMq_TL_5_17))/CTL_TL_5_17;
diTLMd_TL_5_18dt = 377*dphidt*iTLMq_TL_5_18 - (377*(vTLRd_TL_5_18 - vTLLd_TL_5_16 + RTL_TL_5_18*iTLMd_TL_5_18))/LTL_TL_5_18;
diTLMq_TL_5_18dt = - 377*dphidt*iTLMd_TL_5_18 - (377*(vTLRq_TL_5_18 - vTLLq_TL_5_16 + RTL_TL_5_18*iTLMq_TL_5_18))/LTL_TL_5_18;
dvTLRd_TL_5_18dt = 377*dphidt*vTLRq_TL_5_18 - (377*(iLd_L18 - iTLMd_TL_5_18))/CTL_TL_5_18;
dvTLRq_TL_5_18dt = - 377*dphidt*vTLRd_TL_5_18 - (377*(iLq_L18 - iTLMq_TL_5_18))/CTL_TL_5_18;
diTLMd_TL_5_19dt = 377*dphidt*iTLMq_TL_5_19 - (377*(vTLRd_TL_5_19 - vTLLd_TL_5_16 + RTL_TL_5_19*iTLMd_TL_5_19))/LTL_TL_5_19;
diTLMq_TL_5_19dt = - 377*dphidt*iTLMd_TL_5_19 - (377*(vTLRq_TL_5_19 - vTLLq_TL_5_16 + RTL_TL_5_19*iTLMq_TL_5_19))/LTL_TL_5_19;
dvTLRd_TL_5_19dt = 377*dphidt*vTLRq_TL_5_19 - (377*(iLd_L19 - iTLMd_TL_5_19))/CTL_TL_5_19;
dvTLRq_TL_5_19dt = - 377*dphidt*vTLRd_TL_5_19 - (377*(iLq_L19 - iTLMq_TL_5_19))/CTL_TL_5_19;
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLLd_TL_5_16 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLLq_TL_5_16 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
dvTLLd_TL_1_5dt = (377*(iSd_G22 - iTLMd_TL_1_2 - iTLMd_TL_1_5 - iTLMd_TL_1_11 - iTLMd_TL_1_12 - iTLMd_TL_1_13 - iTLMd_TL_1_14 - iTLMd_TL_1_15 + CTL_TL_1_2*dphidt*vTLLq_TL_1_5 + CTL_TL_1_5*dphidt*vTLLq_TL_1_5 + CTL_TL_1_11*dphidt*vTLLq_TL_1_5 + CTL_TL_1_12*dphidt*vTLLq_TL_1_5 + CTL_TL_1_13*dphidt*vTLLq_TL_1_5 + CTL_TL_1_14*dphidt*vTLLq_TL_1_5 + CTL_TL_1_15*dphidt*vTLLq_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
dvTLLq_TL_1_5dt = -(377*(iTLMq_TL_1_2 - iSq_G22 + iTLMq_TL_1_5 + iTLMq_TL_1_11 + iTLMq_TL_1_12 + iTLMq_TL_1_13 + iTLMq_TL_1_14 + iTLMq_TL_1_15 + CTL_TL_1_2*dphidt*vTLLd_TL_1_5 + CTL_TL_1_5*dphidt*vTLLd_TL_1_5 + CTL_TL_1_11*dphidt*vTLLd_TL_1_5 + CTL_TL_1_12*dphidt*vTLLd_TL_1_5 + CTL_TL_1_13*dphidt*vTLLd_TL_1_5 + CTL_TL_1_14*dphidt*vTLLd_TL_1_5 + CTL_TL_1_15*dphidt*vTLLd_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
diTLMd_TL_1_5dt = 377*dphidt*iTLMq_TL_1_5 - (377*(vTLLd_TL_5_16 - vTLLd_TL_1_5 + RTL_TL_1_5*iTLMd_TL_1_5))/LTL_TL_1_5;
diTLMq_TL_1_5dt = - 377*dphidt*iTLMd_TL_1_5 - (377*(vTLLq_TL_5_16 - vTLLq_TL_1_5 + RTL_TL_1_5*iTLMq_TL_1_5))/LTL_TL_1_5;
diTLMd_TL_1_14dt = 377*dphidt*iTLMq_TL_1_14 - (377*(vTLRd_TL_1_14 - vTLLd_TL_1_5 + RTL_TL_1_14*iTLMd_TL_1_14))/LTL_TL_1_14;
diTLMq_TL_1_14dt = - 377*dphidt*iTLMd_TL_1_14 - (377*(vTLRq_TL_1_14 - vTLLq_TL_1_5 + RTL_TL_1_14*iTLMq_TL_1_14))/LTL_TL_1_14;
dvTLRd_TL_1_14dt = 377*dphidt*vTLRq_TL_1_14 - (377*(iLd_L14 - iTLMd_TL_1_14))/CTL_TL_1_14;
dvTLRq_TL_1_14dt = - 377*dphidt*vTLRd_TL_1_14 - (377*(iLq_L14 - iTLMq_TL_1_14))/CTL_TL_1_14;
diTLMd_TL_1_15dt = 377*dphidt*iTLMq_TL_1_15 - (377*(vTLRd_TL_1_15 - vTLLd_TL_1_5 + RTL_TL_1_15*iTLMd_TL_1_15))/LTL_TL_1_15;
diTLMq_TL_1_15dt = - 377*dphidt*iTLMd_TL_1_15 - (377*(vTLRq_TL_1_15 - vTLLq_TL_1_5 + RTL_TL_1_15*iTLMq_TL_1_15))/LTL_TL_1_15;
dvTLRd_TL_1_15dt = 377*dphidt*vTLRq_TL_1_15 - (377*(iLd_L15 - iTLMd_TL_1_15))/CTL_TL_1_15;
dvTLRq_TL_1_15dt = - 377*dphidt*vTLRd_TL_1_15 - (377*(iLq_L15 - iTLMq_TL_1_15))/CTL_TL_1_15;
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_5 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_5 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = 377*dphidt*vTLRq_TL_1_2 + (377*(iSd_G23 - iLd_L2 + iTLMd_TL_1_2))/CTL_TL_1_2;
dvTLRq_TL_1_2dt = (377*(iSq_G23 - iLq_L2 + iTLMq_TL_1_2))/CTL_TL_1_2 - 377*dphidt*vTLRd_TL_1_2;
diTLMd_TL_1_12dt = 377*dphidt*iTLMq_TL_1_12 - (377*(vTLRd_TL_1_12 - vTLLd_TL_1_5 + RTL_TL_1_12*iTLMd_TL_1_12))/LTL_TL_1_12;
diTLMq_TL_1_12dt = - 377*dphidt*iTLMd_TL_1_12 - (377*(vTLRq_TL_1_12 - vTLLq_TL_1_5 + RTL_TL_1_12*iTLMq_TL_1_12))/LTL_TL_1_12;
dvTLRd_TL_1_12dt = 377*dphidt*vTLRq_TL_1_12 - (377*(iLd_L12 - iTLMd_TL_1_12))/CTL_TL_1_12;
dvTLRq_TL_1_12dt = - 377*dphidt*vTLRd_TL_1_12 - (377*(iLq_L12 - iTLMq_TL_1_12))/CTL_TL_1_12;
diTLMd_TL_1_13dt = 377*dphidt*iTLMq_TL_1_13 - (377*(vTLRd_TL_1_13 - vTLLd_TL_1_5 + RTL_TL_1_13*iTLMd_TL_1_13))/LTL_TL_1_13;
diTLMq_TL_1_13dt = - 377*dphidt*iTLMd_TL_1_13 - (377*(vTLRq_TL_1_13 - vTLLq_TL_1_5 + RTL_TL_1_13*iTLMq_TL_1_13))/LTL_TL_1_13;
dvTLRd_TL_1_13dt = 377*dphidt*vTLRq_TL_1_13 - (377*(iLd_L13 - iTLMd_TL_1_13))/CTL_TL_1_13;
dvTLRq_TL_1_13dt = - 377*dphidt*vTLRd_TL_1_13 - (377*(iLq_L13 - iTLMq_TL_1_13))/CTL_TL_1_13;
diTLMd_TL_1_11dt = 377*dphidt*iTLMq_TL_1_11 - (377*(vTLRd_TL_1_11 - vTLLd_TL_1_5 + RTL_TL_1_11*iTLMd_TL_1_11))/LTL_TL_1_11;
diTLMq_TL_1_11dt = - 377*dphidt*iTLMd_TL_1_11 - (377*(vTLRq_TL_1_11 - vTLLq_TL_1_5 + RTL_TL_1_11*iTLMq_TL_1_11))/LTL_TL_1_11;
dvTLRd_TL_1_11dt = 377*dphidt*vTLRq_TL_1_11 - (377*(iLd_L11 - iTLMd_TL_1_11))/CTL_TL_1_11;
dvTLRq_TL_1_11dt = - 377*dphidt*vTLRd_TL_1_11 - (377*(iLq_L11 - iTLMq_TL_1_11))/CTL_TL_1_11;
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
dvTLLd_TL_5_16dt
dvTLLq_TL_5_16dt
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
dvTLLd_TL_1_5dt
dvTLLq_TL_1_5dt
diTLMd_TL_1_5dt
diTLMq_TL_1_5dt
diTLMd_TL_1_14dt
diTLMq_TL_1_14dt
dvTLRd_TL_1_14dt
dvTLRq_TL_1_14dt
diTLMd_TL_1_15dt
diTLMq_TL_1_15dt
dvTLRd_TL_1_15dt
dvTLRq_TL_1_15dt
diTLMd_TL_1_2dt
diTLMq_TL_1_2dt
dvTLRd_TL_1_2dt
dvTLRq_TL_1_2dt
diTLMd_TL_1_12dt
diTLMq_TL_1_12dt
dvTLRd_TL_1_12dt
dvTLRq_TL_1_12dt
diTLMd_TL_1_13dt
diTLMq_TL_1_13dt
dvTLRd_TL_1_13dt
dvTLRq_TL_1_13dt
diTLMd_TL_1_11dt
diTLMq_TL_1_11dt
dvTLRd_TL_1_11dt
dvTLRq_TL_1_11dt
];
end
save('ShortGrid.mat')
plot(t,x(:,7),'b',t,x(:,14),'r');
end