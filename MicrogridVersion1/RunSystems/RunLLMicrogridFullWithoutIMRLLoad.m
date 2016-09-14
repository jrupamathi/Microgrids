function RunLLMicrogridFull

clear all
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
 
load('PV21.mat', 'RL_PV21', 'LL_PV21');
% RL_PV21 = 5; 
LL_PV21 = -4.7;
% PL_PV21 = -0.01875; QL_PV21 = -0.01;
load('B20.mat', 'RL_B20', 'LL_B20');
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

load('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
load('TL_1_3.mat', 'LTL_TL_1_3', 'RTL_TL_1_3','CTL_TL_1_3');
load('TL_1_4.mat', 'LTL_TL_1_4', 'RTL_TL_1_4','CTL_TL_1_4');

load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');

load('TL_3_5.mat', 'LTL_TL_3_5', 'RTL_TL_3_5','CTL_TL_3_5');
load('TL_3_11.mat', 'LTL_TL_3_11', 'RTL_TL_3_11','CTL_TL_3_11');

load('TL_4_6.mat', 'LTL_TL_4_6', 'RTL_TL_4_6','CTL_TL_4_6');
load('TL_4_7.mat', 'LTL_TL_4_7', 'RTL_TL_4_7','CTL_TL_4_7');
load('TL_4_12.mat', 'LTL_TL_4_12', 'RTL_TL_4_12','CTL_TL_4_12');

load('TL_5_8.mat', 'LTL_TL_5_8', 'RTL_TL_5_8','CTL_TL_5_8');
load('TL_5_9.mat', 'LTL_TL_5_9', 'RTL_TL_5_9','CTL_TL_5_9');

load('TL_6_13.mat', 'LTL_TL_6_13', 'RTL_TL_6_13','CTL_TL_6_13');
load('TL_6_14.mat', 'LTL_TL_6_14', 'RTL_TL_6_14','CTL_TL_6_14');

load('TL_7_22.mat', 'LTL_TL_7_22', 'RTL_TL_7_22','CTL_TL_7_22');
load('TL_7_15.mat', 'LTL_TL_7_15', 'RTL_TL_7_15','CTL_TL_7_15');

load('TL_8_16.mat', 'LTL_TL_8_16', 'RTL_TL_8_16','CTL_TL_8_16');
load('TL_8_17.mat', 'LTL_TL_8_17', 'RTL_TL_8_17','CTL_TL_8_17');
load('TL_8_21.mat', 'LTL_TL_8_21', 'RTL_TL_8_21','CTL_TL_8_21');

load('TL_9_10.mat', 'LTL_TL_9_10', 'RTL_TL_9_10','CTL_TL_9_10');
load('TL_9_18.mat', 'LTL_TL_9_18', 'RTL_TL_9_18','CTL_TL_9_18');

load('TL_10_19.mat', 'LTL_TL_10_19', 'RTL_TL_10_19','CTL_TL_10_19');
load('TL_10_20.mat', 'LTL_TL_10_20', 'RTL_TL_10_20','CTL_TL_10_20');

x0 = [26.9264
   -3.4610
   -0.3197
   23.8979
    0.6313
  -15.8504
    0.9909
   25.8347
    6.9214
   -0.7054
  -23.0760
   -1.8522
    0.3741
    1.2197
    0.1279
    0.0912
   -0.2667
   -0.2028
   -0.0409
   -0.0291
   -0.0189
   -0.0270
   -0.0200
   -0.0297
   -0.2947
   -0.2070
   -0.5193
   -0.4017
   -0.0175
   -0.0143
   -0.0228
   -0.0160
   -0.0549
   -0.0369
   -0.1887
   -0.1207
   -0.5841
   -0.5746
   -3.0626
   -3.2091
   -0.5907
   -0.5833
   33.9592
    0.0638
   -0.5849
   -0.5761
   -5.5939
   10.0231
   -0.5836
   -0.5749
  -16.1621
   -4.8623
   -0.5702
   -0.5446
   14.5803
   -1.9624
   -0.5775
   -0.4569
    5.8787
    0.9219
   -0.7587
   -0.5437
   17.3293
    3.7280
   -0.5839
   -0.5761
  -31.2111
    0.6239
   -0.5862
   -0.5774
    0.6364
    2.9056
   -0.2894
   -0.4622
    5.8937
   -0.5611
   -0.5776
   -0.4570
    8.6229
   -1.4026
   -0.5776
   -0.4569
    0.6522
    2.9242
   -0.2890
   -0.4643
    3.7771
   -0.2785
   -0.7080
   -0.5801
  -25.3311
    4.4749
   -0.5807
   -0.5720
   -0.5003
   -0.4010
   -0.5970
   -0.5707
    0.0996
   -0.0712
   -0.5854
   -0.5932
    0.9211
    0.2694
   -0.5405
   -0.4908
    2.5529
   -0.8063
   -0.6176
   -0.4413
    2.4074
   -0.8838
   -0.6273
   -0.4489
    4.3369
   -0.5577
   -0.5776
   -0.4569
    2.4818
   -0.5968
   -0.6165
   -0.4283
   0
   0];

% V = [    1.6278    1.7794    1.6289    1.6727];

tic  
% Options =  odeset('RelTol',1e-4,'AbsTol',1e-3');

    dphidt = 1;
    [t,x] = ode45(@LLMicrogridDynamics,[0,0.5],x0);
%x=ode5(@LLMicrogridDynamics,0:1e-6:0.01,x0);
%x0 = xTemp(end,:);
    %t = [t ; tTemp];
    %x = [x ; xTemp];
    toc
    
%end

function [dx] = LLMicrogridDynamics(t,x)
t
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
iLd_PV21 = x(15);
iLq_PV21 = x(16);
iLd_L2 = x(17);
iLq_L2 = x(18);
iLd_L11 = x(19);
iLq_L11 = x(20);
iLd_L12 = x(21);
iLq_L12 = x(22);
iLd_L13 = x(23);
iLq_L13 = x(24);
iLd_L14 = x(25);
iLq_L14 = x(26);
iLd_L15 = x(27);
iLq_L15 = x(28);
iLd_L16 = x(29);
iLq_L16 = x(30);
iLd_L17 = x(31);
iLq_L17 = x(32);
iLd_L18 = x(33);
iLq_L18 = x(34);
iLd_L19 = x(35);
iLq_L19 = x(36);
vTLLd_TL_1_2 = x(37);
vTLLq_TL_1_2 = x(38);
iTLMd_TL_1_2 = x(39);
iTLMq_TL_1_2 = x(40);
vTLRd_TL_1_2 = x(41);
vTLRq_TL_1_2 = x(42);
iTLMd_TL_1_3 = x(43);
iTLMq_TL_1_3 = x(44);
vTLRd_TL_1_3 = x(45);
vTLRq_TL_1_3 = x(46);
iTLMd_TL_1_4 = x(47);
iTLMq_TL_1_4 = x(48);
vTLRd_TL_1_4 = x(49);
vTLRq_TL_1_4 = x(50);
iTLMd_TL_2_23 = x(51);
iTLMq_TL_2_23 = x(52);
vTLRd_TL_2_23 = x(53);
vTLRq_TL_2_23 = x(54);
iTLMd_TL_3_5 = x(55);
iTLMq_TL_3_5 = x(56);
vTLRd_TL_3_5 = x(57);
vTLRq_TL_3_5 = x(58);
iTLMd_TL_3_11 = x(59);
iTLMq_TL_3_11 = x(60);
vTLRd_TL_3_11 = x(61);
vTLRq_TL_3_11 = x(62);
iTLMd_TL_4_6 = x(63);
iTLMq_TL_4_6 = x(64);
vTLRd_TL_4_6 = x(65);
vTLRq_TL_4_6 = x(66);
iTLMd_TL_4_7 = x(67);
iTLMq_TL_4_7 = x(68);
vTLRd_TL_4_7 = x(69);
vTLRq_TL_4_7 = x(70);
iTLMd_TL_4_12 = x(71);
iTLMq_TL_4_12 = x(72);
vTLRd_TL_4_12 = x(73);
vTLRq_TL_4_12 = x(74);
iTLMd_TL_5_8 = x(75);
iTLMq_TL_5_8 = x(76);
vTLRd_TL_5_8 = x(77);
vTLRq_TL_5_8 = x(78);
iTLMd_TL_5_9 = x(79);
iTLMq_TL_5_9 = x(80);
vTLRd_TL_5_9 = x(81);
vTLRq_TL_5_9 = x(82);
iTLMd_TL_6_13 = x(83);
iTLMq_TL_6_13 = x(84);
vTLRd_TL_6_13 = x(85);
vTLRq_TL_6_13 = x(86);
iTLMd_TL_6_14 = x(87);
iTLMq_TL_6_14 = x(88);
vTLRd_TL_6_14 = x(89);
vTLRq_TL_6_14 = x(90);
iTLMd_TL_7_22 = x(91);
iTLMq_TL_7_22 = x(92);
vTLRd_TL_7_22 = x(93);
vTLRq_TL_7_22 = x(94);
iTLMd_TL_7_15 = x(95);
iTLMq_TL_7_15 = x(96);
vTLRd_TL_7_15 = x(97);
vTLRq_TL_7_15 = x(98);
iTLMd_TL_8_21 = x(99);
iTLMq_TL_8_21 = x(100);
vTLRd_TL_8_21 = x(101);
vTLRq_TL_8_21 = x(102);
iTLMd_TL_8_16 = x(103);
iTLMq_TL_8_16 = x(104);
vTLRd_TL_8_16 = x(105);
vTLRq_TL_8_16 = x(106);
iTLMd_TL_8_17 = x(107);
iTLMq_TL_8_17 = x(108);
vTLRd_TL_8_17 = x(109);
vTLRq_TL_8_17 = x(110);
iTLMd_TL_9_18 = x(111);
iTLMq_TL_9_18 = x(112);
vTLRd_TL_9_18 = x(113);
vTLRq_TL_9_18 = x(114);
iTLMd_TL_9_10 = x(115);
iTLMq_TL_9_10 = x(116);
vTLRd_TL_9_10 = x(117);
vTLRq_TL_9_10 = x(118);
iTLMd_TL_10_19 = x(119);
iTLMq_TL_10_19 = x(120);
vTLRd_TL_10_19 = x(121);
vTLRq_TL_10_19 = x(122);
Int1 = x(123);
Int2 = x(124);
t
k1 = 3.8; k2 = 0.65;%other
% (vTLRd_TL_8_21^2+ vTLRq_TL_8_21^2)
tauL_G22 = tauL_G22_ref -2*k1*Int1- K11_G22*(delta_G22 - delta_G22_ref) - K12_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K26_G22*(iF_G22 - 1.5*k1*iF_G22_ref);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
tauL_G23 = tauL_G23_ref -2*k1*Int2- K11_G23*(delta_G23 - delta_G23_ref) - K12_G23*(omega_G23 - omega_G23_ref);
vR_G23 = vR_G23_ref - K26_G23*(iF_G23 - 3.2*k2*iF_G23_ref);% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
diSd_G22dt = 377*vTLRd_TL_7_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_7_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_7_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_7_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_7_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_7_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_7_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_7_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_7_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_7_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLRd_TL_7_22 + iSq_G22*vTLRq_TL_7_22)/(2*H_G22);
diSd_G23dt = 377*vTLLd_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((Rkd_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iSq_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLLq_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*vTLLq_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + 377*iRd_G23*((Rkd_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iSd_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLLd_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLLq_TL_1_2*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLLd_TL_1_2*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*Rkq_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLLd_TL_1_2*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLLq_TL_1_2*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLLq_TL_1_2*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLLd_TL_1_2*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLLd_TL_1_2 + iSq_G23*vTLLq_TL_1_2)/(2*H_G23);
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_8_21 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLRq_TL_8_21 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_2 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_3_11 - RL_L11*iLd_L11))/LL_L11;
diLq_L11dt = (377*(vTLRq_TL_3_11 - RL_L11*iLq_L11))/LL_L11 - 377*dphidt*iLd_L11;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_4_12 - RL_L12*iLd_L12))/LL_L12;
diLq_L12dt = (377*(vTLRq_TL_4_12 - RL_L12*iLq_L12))/LL_L12 - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_6_13 - RL_L13*iLd_L13))/LL_L13;
diLq_L13dt = (377*(vTLRq_TL_6_13 - RL_L13*iLq_L13))/LL_L13 - 377*dphidt*iLd_L13;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_6_14 - RL_L14*iLd_L14))/LL_L14;
diLq_L14dt = (377*(vTLRq_TL_6_14 - RL_L14*iLq_L14))/LL_L14 - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_7_15 - RL_L15*iLd_L15))/LL_L15;
diLq_L15dt = (377*(vTLRq_TL_7_15 - RL_L15*iLq_L15))/LL_L15 - 377*dphidt*iLd_L15;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_8_16 - RL_L16*iLd_L16))/LL_L16;
diLq_L16dt = (377*(vTLRq_TL_8_16 - RL_L16*iLq_L16))/LL_L16 - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_8_17 - RL_L17*iLd_L17))/LL_L17;
diLq_L17dt = (377*(vTLRq_TL_8_17 - RL_L17*iLq_L17))/LL_L17 - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_9_18 - RL_L18*iLd_L18))/LL_L18;
diLq_L18dt = (377*(vTLRq_TL_9_18 - RL_L18*iLq_L18))/LL_L18 - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_10_19 - RL_L19*iLd_L19))/LL_L19;
diLq_L19dt = (377*(vTLRq_TL_10_19 - RL_L19*iLq_L19))/LL_L19 - 377*dphidt*iLd_L19;
dvTLLd_TL_1_2dt = (377*(iSd_G23 - iTLMd_TL_1_2 - iTLMd_TL_1_3 - iTLMd_TL_1_4 + CTL_TL_1_2*dphidt*vTLLq_TL_1_2 + CTL_TL_1_3*dphidt*vTLLq_TL_1_2 + CTL_TL_1_4*dphidt*vTLLq_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_3 + CTL_TL_1_4);
dvTLLq_TL_1_2dt = -(377*(iTLMq_TL_1_2 - iSq_G23 + iTLMq_TL_1_3 + iTLMq_TL_1_4 + CTL_TL_1_2*dphidt*vTLLd_TL_1_2 + CTL_TL_1_3*dphidt*vTLLd_TL_1_2 + CTL_TL_1_4*dphidt*vTLLd_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_3 + CTL_TL_1_4);
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_2 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_2 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = (377*(iTLMd_TL_1_2 - iLd_L2 - iTLMd_TL_2_23 + CTL_TL_1_2*dphidt*vTLRq_TL_1_2 + CTL_TL_2_23*dphidt*vTLRq_TL_1_2))/(CTL_TL_1_2 + CTL_TL_2_23);
dvTLRq_TL_1_2dt = -(377*(iLq_L2 - iTLMq_TL_1_2 + iTLMq_TL_2_23 + CTL_TL_1_2*dphidt*vTLRd_TL_1_2 + CTL_TL_2_23*dphidt*vTLRd_TL_1_2))/(CTL_TL_1_2 + CTL_TL_2_23);
diTLMd_TL_1_3dt = 377*dphidt*iTLMq_TL_1_3 - (377*(vTLRd_TL_1_3 - vTLLd_TL_1_2 + RTL_TL_1_3*iTLMd_TL_1_3))/LTL_TL_1_3;
diTLMq_TL_1_3dt = - 377*dphidt*iTLMd_TL_1_3 - (377*(vTLRq_TL_1_3 - vTLLq_TL_1_2 + RTL_TL_1_3*iTLMq_TL_1_3))/LTL_TL_1_3;
dvTLRd_TL_1_3dt = (377*(iTLMd_TL_1_3 - iTLMd_TL_3_5 - iTLMd_TL_3_11 + CTL_TL_1_3*dphidt*vTLRq_TL_1_3 + CTL_TL_3_5*dphidt*vTLRq_TL_1_3 + CTL_TL_3_11*dphidt*vTLRq_TL_1_3))/(CTL_TL_1_3 + CTL_TL_3_5 + CTL_TL_3_11);
dvTLRq_TL_1_3dt = -(377*(iTLMq_TL_3_5 - iTLMq_TL_1_3 + iTLMq_TL_3_11 + CTL_TL_1_3*dphidt*vTLRd_TL_1_3 + CTL_TL_3_5*dphidt*vTLRd_TL_1_3 + CTL_TL_3_11*dphidt*vTLRd_TL_1_3))/(CTL_TL_1_3 + CTL_TL_3_5 + CTL_TL_3_11);
diTLMd_TL_1_4dt = 377*dphidt*iTLMq_TL_1_4 - (377*(vTLRd_TL_1_4 - vTLLd_TL_1_2 + RTL_TL_1_4*iTLMd_TL_1_4))/LTL_TL_1_4;
diTLMq_TL_1_4dt = - 377*dphidt*iTLMd_TL_1_4 - (377*(vTLRq_TL_1_4 - vTLLq_TL_1_2 + RTL_TL_1_4*iTLMq_TL_1_4))/LTL_TL_1_4;
dvTLRd_TL_1_4dt = (377*(iTLMd_TL_1_4 - iTLMd_TL_4_6 - iTLMd_TL_4_7 - iTLMd_TL_4_12 + CTL_TL_1_4*dphidt*vTLRq_TL_1_4 + CTL_TL_4_6*dphidt*vTLRq_TL_1_4 + CTL_TL_4_7*dphidt*vTLRq_TL_1_4 + CTL_TL_4_12*dphidt*vTLRq_TL_1_4))/(CTL_TL_1_4 + CTL_TL_4_6 + CTL_TL_4_7 + CTL_TL_4_12);
dvTLRq_TL_1_4dt = -(377*(iTLMq_TL_4_6 - iTLMq_TL_1_4 + iTLMq_TL_4_7 + iTLMq_TL_4_12 + CTL_TL_1_4*dphidt*vTLRd_TL_1_4 + CTL_TL_4_6*dphidt*vTLRd_TL_1_4 + CTL_TL_4_7*dphidt*vTLRd_TL_1_4 + CTL_TL_4_12*dphidt*vTLRd_TL_1_4))/(CTL_TL_1_4 + CTL_TL_4_6 + CTL_TL_4_7 + CTL_TL_4_12);
diTLMd_TL_2_23dt = 377*dphidt*iTLMq_TL_2_23 - (377*(vTLRd_TL_2_23 - vTLRd_TL_1_2 + RTL_TL_2_23*iTLMd_TL_2_23))/LTL_TL_2_23;
diTLMq_TL_2_23dt = - 377*dphidt*iTLMd_TL_2_23 - (377*(vTLRq_TL_2_23 - vTLRq_TL_1_2 + RTL_TL_2_23*iTLMq_TL_2_23))/LTL_TL_2_23;
dvTLRd_TL_2_23dt = (377*(iSd_G23 + iTLMd_TL_2_23))/CTL_TL_2_23 + 377*dphidt*vTLRq_TL_2_23;
dvTLRq_TL_2_23dt = (377*(iSq_G23 + iTLMq_TL_2_23))/CTL_TL_2_23 - 377*dphidt*vTLRd_TL_2_23;
diTLMd_TL_3_5dt = 377*dphidt*iTLMq_TL_3_5 - (377*(vTLRd_TL_3_5 - vTLRd_TL_1_3 + RTL_TL_3_5*iTLMd_TL_3_5))/LTL_TL_3_5;
diTLMq_TL_3_5dt = - 377*dphidt*iTLMd_TL_3_5 - (377*(vTLRq_TL_3_5 - vTLRq_TL_1_3 + RTL_TL_3_5*iTLMq_TL_3_5))/LTL_TL_3_5;
dvTLRd_TL_3_5dt = (377*(iTLMd_TL_3_5 - iTLMd_TL_5_8 - iTLMd_TL_5_9 + CTL_TL_3_5*dphidt*vTLRq_TL_3_5 + CTL_TL_5_8*dphidt*vTLRq_TL_3_5 + CTL_TL_5_9*dphidt*vTLRq_TL_3_5))/(CTL_TL_3_5 + CTL_TL_5_8 + CTL_TL_5_9);
dvTLRq_TL_3_5dt = -(377*(iTLMq_TL_5_8 - iTLMq_TL_3_5 + iTLMq_TL_5_9 + CTL_TL_3_5*dphidt*vTLRd_TL_3_5 + CTL_TL_5_8*dphidt*vTLRd_TL_3_5 + CTL_TL_5_9*dphidt*vTLRd_TL_3_5))/(CTL_TL_3_5 + CTL_TL_5_8 + CTL_TL_5_9);
diTLMd_TL_3_11dt = 377*dphidt*iTLMq_TL_3_11 - (377*(vTLRd_TL_3_11 - vTLRd_TL_1_3 + RTL_TL_3_11*iTLMd_TL_3_11))/LTL_TL_3_11;
diTLMq_TL_3_11dt = - 377*dphidt*iTLMd_TL_3_11 - (377*(vTLRq_TL_3_11 - vTLRq_TL_1_3 + RTL_TL_3_11*iTLMq_TL_3_11))/LTL_TL_3_11;
dvTLRd_TL_3_11dt = 377*dphidt*vTLRq_TL_3_11 - (377*(iLd_L11 - iTLMd_TL_3_11))/CTL_TL_3_11;
dvTLRq_TL_3_11dt = - 377*dphidt*vTLRd_TL_3_11 - (377*(iLq_L11 - iTLMq_TL_3_11))/CTL_TL_3_11;
diTLMd_TL_4_6dt = 377*dphidt*iTLMq_TL_4_6 - (377*(vTLRd_TL_4_6 - vTLRd_TL_1_4 + RTL_TL_4_6*iTLMd_TL_4_6))/LTL_TL_4_6;
diTLMq_TL_4_6dt = - 377*dphidt*iTLMd_TL_4_6 - (377*(vTLRq_TL_4_6 - vTLRq_TL_1_4 + RTL_TL_4_6*iTLMq_TL_4_6))/LTL_TL_4_6;
dvTLRd_TL_4_6dt = (377*(iTLMd_TL_4_6 - iTLMd_TL_6_13 - iTLMd_TL_6_14 + CTL_TL_4_6*dphidt*vTLRq_TL_4_6 + CTL_TL_6_13*dphidt*vTLRq_TL_4_6 + CTL_TL_6_14*dphidt*vTLRq_TL_4_6))/(CTL_TL_4_6 + CTL_TL_6_13 + CTL_TL_6_14);
dvTLRq_TL_4_6dt = -(377*(iTLMq_TL_6_13 - iTLMq_TL_4_6 + iTLMq_TL_6_14 + CTL_TL_4_6*dphidt*vTLRd_TL_4_6 + CTL_TL_6_13*dphidt*vTLRd_TL_4_6 + CTL_TL_6_14*dphidt*vTLRd_TL_4_6))/(CTL_TL_4_6 + CTL_TL_6_13 + CTL_TL_6_14);
diTLMd_TL_4_7dt = 377*dphidt*iTLMq_TL_4_7 - (377*(vTLRd_TL_4_7 - vTLRd_TL_1_4 + RTL_TL_4_7*iTLMd_TL_4_7))/LTL_TL_4_7;
diTLMq_TL_4_7dt = - 377*dphidt*iTLMd_TL_4_7 - (377*(vTLRq_TL_4_7 - vTLRq_TL_1_4 + RTL_TL_4_7*iTLMq_TL_4_7))/LTL_TL_4_7;
dvTLRd_TL_4_7dt = (377*(iTLMd_TL_4_7 - iTLMd_TL_7_15 - iTLMd_TL_7_22 + CTL_TL_4_7*dphidt*vTLRq_TL_4_7 + CTL_TL_7_15*dphidt*vTLRq_TL_4_7 + CTL_TL_7_22*dphidt*vTLRq_TL_4_7))/(CTL_TL_4_7 + CTL_TL_7_15 + CTL_TL_7_22);
dvTLRq_TL_4_7dt = -(377*(iTLMq_TL_7_15 - iTLMq_TL_4_7 + iTLMq_TL_7_22 + CTL_TL_4_7*dphidt*vTLRd_TL_4_7 + CTL_TL_7_15*dphidt*vTLRd_TL_4_7 + CTL_TL_7_22*dphidt*vTLRd_TL_4_7))/(CTL_TL_4_7 + CTL_TL_7_15 + CTL_TL_7_22);
diTLMd_TL_4_12dt = 377*dphidt*iTLMq_TL_4_12 - (377*(vTLRd_TL_4_12 - vTLRd_TL_1_4 + RTL_TL_4_12*iTLMd_TL_4_12))/LTL_TL_4_12;
diTLMq_TL_4_12dt = - 377*dphidt*iTLMd_TL_4_12 - (377*(vTLRq_TL_4_12 - vTLRq_TL_1_4 + RTL_TL_4_12*iTLMq_TL_4_12))/LTL_TL_4_12;
dvTLRd_TL_4_12dt = 377*dphidt*vTLRq_TL_4_12 - (377*(iLd_L12 - iTLMd_TL_4_12))/CTL_TL_4_12;
dvTLRq_TL_4_12dt = - 377*dphidt*vTLRd_TL_4_12 - (377*(iLq_L12 - iTLMq_TL_4_12))/CTL_TL_4_12;
diTLMd_TL_5_8dt = 377*dphidt*iTLMq_TL_5_8 - (377*(vTLRd_TL_5_8 - vTLRd_TL_3_5 + RTL_TL_5_8*iTLMd_TL_5_8))/LTL_TL_5_8;
diTLMq_TL_5_8dt = - 377*dphidt*iTLMd_TL_5_8 - (377*(vTLRq_TL_5_8 - vTLRq_TL_3_5 + RTL_TL_5_8*iTLMq_TL_5_8))/LTL_TL_5_8;
dvTLRd_TL_5_8dt = (377*(iTLMd_TL_5_8 - iTLMd_TL_8_16 - iTLMd_TL_8_17 - iTLMd_TL_8_21 + CTL_TL_5_8*dphidt*vTLRq_TL_5_8 + CTL_TL_8_16*dphidt*vTLRq_TL_5_8 + CTL_TL_8_17*dphidt*vTLRq_TL_5_8 + CTL_TL_8_21*dphidt*vTLRq_TL_5_8))/(CTL_TL_5_8 + CTL_TL_8_16 + CTL_TL_8_17 + CTL_TL_8_21);
dvTLRq_TL_5_8dt = -(377*(iTLMq_TL_8_16 - iTLMq_TL_5_8 + iTLMq_TL_8_17 + iTLMq_TL_8_21 + CTL_TL_5_8*dphidt*vTLRd_TL_5_8 + CTL_TL_8_16*dphidt*vTLRd_TL_5_8 + CTL_TL_8_17*dphidt*vTLRd_TL_5_8 + CTL_TL_8_21*dphidt*vTLRd_TL_5_8))/(CTL_TL_5_8 + CTL_TL_8_16 + CTL_TL_8_17 + CTL_TL_8_21);
diTLMd_TL_5_9dt = 377*dphidt*iTLMq_TL_5_9 - (377*(vTLRd_TL_5_9 - vTLRd_TL_3_5 + RTL_TL_5_9*iTLMd_TL_5_9))/LTL_TL_5_9;
diTLMq_TL_5_9dt = - 377*dphidt*iTLMd_TL_5_9 - (377*(vTLRq_TL_5_9 - vTLRq_TL_3_5 + RTL_TL_5_9*iTLMq_TL_5_9))/LTL_TL_5_9;
dvTLRd_TL_5_9dt = (377*(iTLMd_TL_5_9 - iTLMd_TL_9_10 - iTLMd_TL_9_18 + CTL_TL_5_9*dphidt*vTLRq_TL_5_9 + CTL_TL_9_10*dphidt*vTLRq_TL_5_9 + CTL_TL_9_18*dphidt*vTLRq_TL_5_9))/(CTL_TL_5_9 + CTL_TL_9_10 + CTL_TL_9_18);
dvTLRq_TL_5_9dt = -(377*(iTLMq_TL_9_10 - iTLMq_TL_5_9 + iTLMq_TL_9_18 + CTL_TL_5_9*dphidt*vTLRd_TL_5_9 + CTL_TL_9_10*dphidt*vTLRd_TL_5_9 + CTL_TL_9_18*dphidt*vTLRd_TL_5_9))/(CTL_TL_5_9 + CTL_TL_9_10 + CTL_TL_9_18);
diTLMd_TL_6_13dt = 377*dphidt*iTLMq_TL_6_13 - (377*(vTLRd_TL_6_13 - vTLRd_TL_4_6 + RTL_TL_6_13*iTLMd_TL_6_13))/LTL_TL_6_13;
diTLMq_TL_6_13dt = - 377*dphidt*iTLMd_TL_6_13 - (377*(vTLRq_TL_6_13 - vTLRq_TL_4_6 + RTL_TL_6_13*iTLMq_TL_6_13))/LTL_TL_6_13;
dvTLRd_TL_6_13dt = 377*dphidt*vTLRq_TL_6_13 - (377*(iLd_L13 - iTLMd_TL_6_13))/CTL_TL_6_13;
dvTLRq_TL_6_13dt = - 377*dphidt*vTLRd_TL_6_13 - (377*(iLq_L13 - iTLMq_TL_6_13))/CTL_TL_6_13;
diTLMd_TL_6_14dt = 377*dphidt*iTLMq_TL_6_14 - (377*(vTLRd_TL_6_14 - vTLRd_TL_4_6 + RTL_TL_6_14*iTLMd_TL_6_14))/LTL_TL_6_14;
diTLMq_TL_6_14dt = - 377*dphidt*iTLMd_TL_6_14 - (377*(vTLRq_TL_6_14 - vTLRq_TL_4_6 + RTL_TL_6_14*iTLMq_TL_6_14))/LTL_TL_6_14;
dvTLRd_TL_6_14dt = 377*dphidt*vTLRq_TL_6_14 - (377*(iLd_L14 - iTLMd_TL_6_14))/CTL_TL_6_14;
dvTLRq_TL_6_14dt = - 377*dphidt*vTLRd_TL_6_14 - (377*(iLq_L14 - iTLMq_TL_6_14))/CTL_TL_6_14;
diTLMd_TL_7_22dt = 377*dphidt*iTLMq_TL_7_22 - (377*(vTLRd_TL_7_22 - vTLRd_TL_4_7 + RTL_TL_7_22*iTLMd_TL_7_22))/LTL_TL_7_22;
diTLMq_TL_7_22dt = - 377*dphidt*iTLMd_TL_7_22 - (377*(vTLRq_TL_7_22 - vTLRq_TL_4_7 + RTL_TL_7_22*iTLMq_TL_7_22))/LTL_TL_7_22;
dvTLRd_TL_7_22dt = (377*(iSd_G22 + iTLMd_TL_7_22))/CTL_TL_7_22 + 377*dphidt*vTLRq_TL_7_22;
dvTLRq_TL_7_22dt = (377*(iSq_G22 + iTLMq_TL_7_22))/CTL_TL_7_22 - 377*dphidt*vTLRd_TL_7_22;
diTLMd_TL_7_15dt = 377*dphidt*iTLMq_TL_7_15 - (377*(vTLRd_TL_7_15 - vTLRd_TL_4_7 + RTL_TL_7_15*iTLMd_TL_7_15))/LTL_TL_7_15;
diTLMq_TL_7_15dt = - 377*dphidt*iTLMd_TL_7_15 - (377*(vTLRq_TL_7_15 - vTLRq_TL_4_7 + RTL_TL_7_15*iTLMq_TL_7_15))/LTL_TL_7_15;
dvTLRd_TL_7_15dt = 377*dphidt*vTLRq_TL_7_15 - (377*(iLd_L15 - iTLMd_TL_7_15))/CTL_TL_7_15;
dvTLRq_TL_7_15dt = - 377*dphidt*vTLRd_TL_7_15 - (377*(iLq_L15 - iTLMq_TL_7_15))/CTL_TL_7_15;
diTLMd_TL_8_21dt = 377*dphidt*iTLMq_TL_8_21 - (377*(vTLRd_TL_8_21 - vTLRd_TL_5_8 + RTL_TL_8_21*iTLMd_TL_8_21))/LTL_TL_8_21;
diTLMq_TL_8_21dt = - 377*dphidt*iTLMd_TL_8_21 - (377*(vTLRq_TL_8_21 - vTLRq_TL_5_8 + RTL_TL_8_21*iTLMq_TL_8_21))/LTL_TL_8_21;
dvTLRd_TL_8_21dt = 377*dphidt*vTLRq_TL_8_21 - (377*(iLd_PV21 - iTLMd_TL_8_21))/CTL_TL_8_21;
dvTLRq_TL_8_21dt = - 377*dphidt*vTLRd_TL_8_21 - (377*(iLq_PV21 - iTLMq_TL_8_21))/CTL_TL_8_21;
diTLMd_TL_8_16dt = 377*dphidt*iTLMq_TL_8_16 - (377*(vTLRd_TL_8_16 - vTLRd_TL_5_8 + RTL_TL_8_16*iTLMd_TL_8_16))/LTL_TL_8_16;
diTLMq_TL_8_16dt = - 377*dphidt*iTLMd_TL_8_16 - (377*(vTLRq_TL_8_16 - vTLRq_TL_5_8 + RTL_TL_8_16*iTLMq_TL_8_16))/LTL_TL_8_16;
dvTLRd_TL_8_16dt = 377*dphidt*vTLRq_TL_8_16 - (377*(iLd_L16 - iTLMd_TL_8_16))/CTL_TL_8_16;
dvTLRq_TL_8_16dt = - 377*dphidt*vTLRd_TL_8_16 - (377*(iLq_L16 - iTLMq_TL_8_16))/CTL_TL_8_16;
diTLMd_TL_8_17dt = 377*dphidt*iTLMq_TL_8_17 - (377*(vTLRd_TL_8_17 - vTLRd_TL_5_8 + RTL_TL_8_17*iTLMd_TL_8_17))/LTL_TL_8_17;
diTLMq_TL_8_17dt = - 377*dphidt*iTLMd_TL_8_17 - (377*(vTLRq_TL_8_17 - vTLRq_TL_5_8 + RTL_TL_8_17*iTLMq_TL_8_17))/LTL_TL_8_17;
dvTLRd_TL_8_17dt = 377*dphidt*vTLRq_TL_8_17 - (377*(iLd_L17 - iTLMd_TL_8_17))/CTL_TL_8_17;
dvTLRq_TL_8_17dt = - 377*dphidt*vTLRd_TL_8_17 - (377*(iLq_L17 - iTLMq_TL_8_17))/CTL_TL_8_17;
diTLMd_TL_9_18dt = 377*dphidt*iTLMq_TL_9_18 - (377*(vTLRd_TL_9_18 - vTLRd_TL_5_9 + RTL_TL_9_18*iTLMd_TL_9_18))/LTL_TL_9_18;
diTLMq_TL_9_18dt = - 377*dphidt*iTLMd_TL_9_18 - (377*(vTLRq_TL_9_18 - vTLRq_TL_5_9 + RTL_TL_9_18*iTLMq_TL_9_18))/LTL_TL_9_18;
dvTLRd_TL_9_18dt = 377*dphidt*vTLRq_TL_9_18 - (377*(iLd_L18 - iTLMd_TL_9_18))/CTL_TL_9_18;
dvTLRq_TL_9_18dt = - 377*dphidt*vTLRd_TL_9_18 - (377*(iLq_L18 - iTLMq_TL_9_18))/CTL_TL_9_18;
diTLMd_TL_9_10dt = 377*dphidt*iTLMq_TL_9_10 - (377*(vTLRd_TL_9_10 - vTLRd_TL_5_9 + RTL_TL_9_10*iTLMd_TL_9_10))/LTL_TL_9_10;
diTLMq_TL_9_10dt = - 377*dphidt*iTLMd_TL_9_10 - (377*(vTLRq_TL_9_10 - vTLRq_TL_5_9 + RTL_TL_9_10*iTLMq_TL_9_10))/LTL_TL_9_10;
dvTLRd_TL_9_10dt = (377*(iTLMd_TL_9_10 - iTLMd_TL_10_19 + CTL_TL_9_10*dphidt*vTLRq_TL_9_10 + CTL_TL_10_19*dphidt*vTLRq_TL_9_10))/(CTL_TL_9_10 + CTL_TL_10_19);
dvTLRq_TL_9_10dt = -(377*(iTLMq_TL_10_19 - iTLMq_TL_9_10 + CTL_TL_9_10*dphidt*vTLRd_TL_9_10 + CTL_TL_10_19*dphidt*vTLRd_TL_9_10))/(CTL_TL_9_10 + CTL_TL_10_19);
diTLMd_TL_10_19dt = 377*dphidt*iTLMq_TL_10_19 - (377*(vTLRd_TL_10_19 - vTLRd_TL_9_10 + RTL_TL_10_19*iTLMd_TL_10_19))/LTL_TL_10_19;
diTLMq_TL_10_19dt = - 377*dphidt*iTLMd_TL_10_19 - (377*(vTLRq_TL_10_19 - vTLRq_TL_9_10 + RTL_TL_10_19*iTLMq_TL_10_19))/LTL_TL_10_19;
dvTLRd_TL_10_19dt = 377*dphidt*vTLRq_TL_10_19 - (377*(iLd_L19 - iTLMd_TL_10_19))/CTL_TL_10_19;
dvTLRq_TL_10_19dt = - 377*dphidt*vTLRd_TL_10_19 - (377*(iLq_L19 - iTLMq_TL_10_19))/CTL_TL_10_19;
dInt1dt = delta_G22 - delta_G22_ref;
dInt2dt = delta_G23 - delta_G23_ref;

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
diLd_PV21dt
diLq_PV21dt
diLd_L2dt
diLq_L2dt
diLd_L11dt
diLq_L11dt
diLd_L12dt
diLq_L12dt
diLd_L13dt
diLq_L13dt
diLd_L14dt
diLq_L14dt
diLd_L15dt
diLq_L15dt
diLd_L16dt
diLq_L16dt
diLd_L17dt
diLq_L17dt
diLd_L18dt
diLq_L18dt
diLd_L19dt
diLq_L19dt
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
diTLMd_TL_1_4dt
diTLMq_TL_1_4dt
dvTLRd_TL_1_4dt
dvTLRq_TL_1_4dt
diTLMd_TL_2_23dt
diTLMq_TL_2_23dt
dvTLRd_TL_2_23dt
dvTLRq_TL_2_23dt
diTLMd_TL_3_5dt
diTLMq_TL_3_5dt
dvTLRd_TL_3_5dt
dvTLRq_TL_3_5dt
diTLMd_TL_3_11dt
diTLMq_TL_3_11dt
dvTLRd_TL_3_11dt
dvTLRq_TL_3_11dt
diTLMd_TL_4_6dt
diTLMq_TL_4_6dt
dvTLRd_TL_4_6dt
dvTLRq_TL_4_6dt
diTLMd_TL_4_7dt
diTLMq_TL_4_7dt
dvTLRd_TL_4_7dt
dvTLRq_TL_4_7dt
diTLMd_TL_4_12dt
diTLMq_TL_4_12dt
dvTLRd_TL_4_12dt
dvTLRq_TL_4_12dt
diTLMd_TL_5_8dt
diTLMq_TL_5_8dt
dvTLRd_TL_5_8dt
dvTLRq_TL_5_8dt
diTLMd_TL_5_9dt
diTLMq_TL_5_9dt
dvTLRd_TL_5_9dt
dvTLRq_TL_5_9dt
diTLMd_TL_6_13dt
diTLMq_TL_6_13dt
dvTLRd_TL_6_13dt
dvTLRq_TL_6_13dt
diTLMd_TL_6_14dt
diTLMq_TL_6_14dt
dvTLRd_TL_6_14dt
dvTLRq_TL_6_14dt
diTLMd_TL_7_22dt
diTLMq_TL_7_22dt
dvTLRd_TL_7_22dt
dvTLRq_TL_7_22dt
diTLMd_TL_7_15dt
diTLMq_TL_7_15dt
dvTLRd_TL_7_15dt
dvTLRq_TL_7_15dt
diTLMd_TL_8_21dt
diTLMq_TL_8_21dt
dvTLRd_TL_8_21dt
dvTLRq_TL_8_21dt
diTLMd_TL_8_16dt
diTLMq_TL_8_16dt
dvTLRd_TL_8_16dt
dvTLRq_TL_8_16dt
diTLMd_TL_8_17dt
diTLMq_TL_8_17dt
dvTLRd_TL_8_17dt
dvTLRq_TL_8_17dt
diTLMd_TL_9_18dt
diTLMq_TL_9_18dt
dvTLRd_TL_9_18dt
dvTLRq_TL_9_18dt
diTLMd_TL_9_10dt
diTLMq_TL_9_10dt
dvTLRd_TL_9_10dt
dvTLRq_TL_9_10dt
diTLMd_TL_10_19dt
diTLMq_TL_10_19dt
dvTLRd_TL_10_19dt
dvTLRq_TL_10_19dt
dInt1dt;
dInt2dt
];
end

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
iLd_PV21 = x(:,15);
iLq_PV21 = x(:,16);
iLd_L2 = x(:,17);
iLq_L2 = x(:,18);
iLd_L11 = x(:,19);
iLq_L11 = x(:,20);
iLd_L12 = x(:,21);
iLq_L12 = x(:,22);
iLd_L13 = x(:,23);
iLq_L13 = x(:,24);
iLd_L14 = x(:,25);
iLq_L14 = x(:,26);
iLd_L15 = x(:,27);
iLq_L15 = x(:,28);
iLd_L16 = x(:,29);
iLq_L16 = x(:,30);
iLd_L17 = x(:,31);
iLq_L17 = x(:,32);
iLd_L18 = x(:,33);
iLq_L18 = x(:,34);
iLd_L19 = x(:,35);
iLq_L19 = x(:,36);
vTLLd_TL_1_2 = x(:,37);
vTLLq_TL_1_2 = x(:,38);
iTLMd_TL_1_2 = x(:,39);
iTLMq_TL_1_2 = x(:,40);
vTLRd_TL_1_2 = x(:,41);
vTLRq_TL_1_2 = x(:,42);
iTLMd_TL_1_3 = x(:,43);
iTLMq_TL_1_3 = x(:,44);
vTLRd_TL_1_3 = x(:,45);
vTLRq_TL_1_3 = x(:,46);
iTLMd_TL_1_4 = x(:,47);
iTLMq_TL_1_4 = x(:,48);
vTLRd_TL_1_4 = x(:,49);
vTLRq_TL_1_4 = x(:,50);
iTLMd_TL_2_23 = x(:,51);
iTLMq_TL_2_23 = x(:,52);
vTLRd_TL_2_23 = x(:,53);
vTLRq_TL_2_23 = x(:,54);
iTLMd_TL_3_5 = x(:,55);
iTLMq_TL_3_5 = x(:,56);
vTLRd_TL_3_5 = x(:,57);
vTLRq_TL_3_5 = x(:,58);
iTLMd_TL_3_11 = x(:,59);
iTLMq_TL_3_11 = x(:,60);
vTLRd_TL_3_11 = x(:,61);
vTLRq_TL_3_11 = x(:,62);
iTLMd_TL_4_6 = x(:,63);
iTLMq_TL_4_6 = x(:,64);
vTLRd_TL_4_6 = x(:,65);
vTLRq_TL_4_6 = x(:,66);
iTLMd_TL_4_7 = x(:,67);
iTLMq_TL_4_7 = x(:,68);
vTLRd_TL_4_7 = x(:,69);
vTLRq_TL_4_7 = x(:,70);
iTLMd_TL_4_12 = x(:,71);
iTLMq_TL_4_12 = x(:,72);
vTLRd_TL_4_12 = x(:,73);
vTLRq_TL_4_12 = x(:,74);
iTLMd_TL_5_8 = x(:,75);
iTLMq_TL_5_8 = x(:,76);
vTLRd_TL_5_8 = x(:,77);
vTLRq_TL_5_8 = x(:,78);
iTLMd_TL_5_9 = x(:,79);
iTLMq_TL_5_9 = x(:,80);
vTLRd_TL_5_9 = x(:,81);
vTLRq_TL_5_9 = x(:,82);
iTLMd_TL_6_13 = x(:,83);
iTLMq_TL_6_13 = x(:,84);
vTLRd_TL_6_13 = x(:,85);
vTLRq_TL_6_13 = x(:,86);
iTLMd_TL_6_14 = x(:,87);
iTLMq_TL_6_14 = x(:,88);
vTLRd_TL_6_14 = x(:,89);
vTLRq_TL_6_14 = x(:,90);
iTLMd_TL_7_22 = x(:,91);
iTLMq_TL_7_22 = x(:,92);
vTLRd_TL_7_22 = x(:,93);
vTLRq_TL_7_22 = x(:,94);
iTLMd_TL_7_15 = x(:,95);
iTLMq_TL_7_15 = x(:,96);
vTLRd_TL_7_15 = x(:,97);
vTLRq_TL_7_15 = x(:,98);
iTLMd_TL_8_21 = x(:,99);
iTLMq_TL_8_21 = x(:,100);
vTLRd_TL_8_21 = x(:,101);
vTLRq_TL_8_21 = x(:,102);
iTLMd_TL_8_16 = x(:,103);
iTLMq_TL_8_16 = x(:,104);
vTLRd_TL_8_16 = x(:,105);
vTLRq_TL_8_16 = x(:,106);
iTLMd_TL_8_17 = x(:,107);
iTLMq_TL_8_17 = x(:,108);
vTLRd_TL_8_17 = x(:,109);
vTLRq_TL_8_17 = x(:,110);
iTLMd_TL_9_18 = x(:,111);
iTLMq_TL_9_18 = x(:,112);
vTLRd_TL_9_18 = x(:,113);
vTLRq_TL_9_18 = x(:,114);
iTLMd_TL_9_10 = x(:,115);
iTLMq_TL_9_10 = x(:,116);
vTLRd_TL_9_10 = x(:,117);
vTLRq_TL_9_10 = x(:,118);
iTLMd_TL_10_19 = x(:,119);
iTLMq_TL_10_19 = x(:,120);
vTLRd_TL_10_19 = x(:,121);
vTLRq_TL_10_19 = x(:,122);
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

V1 = (vTLLd_TL_1_2.^2 + vTLLq_TL_1_2.^2).^0.5;
V21 = (vTLRd_TL_8_21.^2 + vTLRq_TL_8_21.^2).^0.5;
V22 = (vTLRd_TL_7_22.^2 + vTLRq_TL_7_22.^2).^0.5;
V23 = (vTLRd_TL_2_23.^2 + vTLRq_TL_2_23.^2).^0.5;

phi1 = atan(vTLLq_TL_1_2./vTLLd_TL_1_2)*180/pi;
phi21 = atan(vTLRq_TL_8_21./vTLRd_TL_8_21)*180/pi;
phi22 = atan(vTLRq_TL_7_22./vTLRd_TL_7_22)*180/pi;
phi23 = atan(vTLRq_TL_2_23./vTLRd_TL_2_23)*180/pi;
V = [V1(end) V21(end) V22(end) V23(end)]
% V1 = V1(1:250);V21 = V21(1:250);V22 = V22(1:250);V23 = V23(1:250);
% phi1 = phi1(1:250);phi21 = phi21(1:250);phi22 = phi22(1:250);phi23 = phi23(1:250);

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
% save('FullMicrogrid.mat')
end