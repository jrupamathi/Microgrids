function RunCasePVReducedWithoutIM
%Case1: PQLoad with infinite bus and without IM with PV Injection Reduced
clear all
close all

set(0,'defaultlinelinewidth',1.5)


addpath('../Parameters')
            
load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22');

load('L2.mat', 'RL_L2', 'LL_L2');
load('L16.mat', 'RL_L16', 'LL_L16');
load('L17.mat', 'RL_L17', 'LL_L17');
load('L18.mat', 'RL_L18', 'LL_L18');
load('L19.mat', 'RL_L19', 'LL_L19');
load('L14.mat', 'RL_L14', 'LL_L14');
load('L12.mat', 'RL_L12', 'LL_L12');
load('L13.mat', 'RL_L13', 'LL_L13');
load('L15.mat', 'RL_L15', 'LL_L15');
load('L11.mat', 'RL_L11', 'LL_L11');
load('PV21.mat', 'RL_PV21', 'LL_PV21');
load('IM2.mat','LR_IM2','LRR_IM2','LS_IM2','LSS_IM2','M_IM2','RR_IM2','RS_IM2','J_IM2','tauL_IM2','B_IM2');
load('IM14.mat','LR_IM14','LRR_IM14','LS_IM14','LSS_IM14','M_IM14','RR_IM14','RS_IM14','J_IM14','tauL_IM14','B_IM14');
%load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
load('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
load('TL_1_5.mat', 'LTL_TL_1_5', 'RTL_TL_1_5','CTL_TL_1_5');
load('TL_1_14.mat', 'LTL_TL_1_14', 'RTL_TL_1_14','CTL_TL_1_14');
load('TL_1_12.mat', 'LTL_TL_1_12', 'RTL_TL_1_12','CTL_TL_1_12');
load('TL_1_13.mat', 'LTL_TL_1_13', 'RTL_TL_1_13','CTL_TL_1_13');
load('TL_1_11.mat', 'LTL_TL_1_11', 'RTL_TL_1_11','CTL_TL_1_11');
load('TL_1_15.mat', 'LTL_TL_1_15', 'RTL_TL_1_15','CTL_TL_1_15');
load('TL_5_16.mat', 'LTL_TL_5_16', 'RTL_TL_5_16','CTL_TL_5_16');
load('TL_5_17.mat', 'LTL_TL_5_17', 'RTL_TL_5_17','CTL_TL_5_17');
load('TL_5_18.mat', 'LTL_TL_5_18', 'RTL_TL_5_18','CTL_TL_5_18');
load('TL_5_19.mat', 'LTL_TL_5_19', 'RTL_TL_5_19','CTL_TL_5_19');
load('TL_5_21.mat', 'LTL_TL_5_21', 'RTL_TL_5_21','CTL_TL_5_21');

%LTL_TL_2_23=0.1;
%RL_L16=0.0005; LL_L16=0.0002;
%RL_L17=0.0005; LL_L17=0.0002;
%RL_L18=0.0005; LL_L18=0.0002;
%RL_L2=0.05; LL_L2=0.02;
%RL_L14=0.05; LL_L14=0.02;
%RL_L15=0.05; LL_L15=0.02;
RL_PV21 =0.001*RL_PV21; LL_PV21 = 0.01;
x0 = 0.5*randn(86,1);

tic  
tArray = [4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5];
RR_G22 = 0.2825;
RR_G23 = 0.2825;


%Options =  odeset('RelTol',1e-4,'AbsTol',1e-3');

t = [];
x = [];
%for i = 1:numel(tauL_IM2Array)
    tspan = [tArray(1),5];
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%Options);

    toc


function [dx] = LLMicrogridDynamics(t,x)
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
vTLLd_TL_1_5 = 1;%x(55);
vTLLq_TL_1_5 = 0;%x(56);
iTLMd_TL_1_5 = x(57);
iTLMq_TL_1_5 = x(58);
iTLMd_TL_1_14 = x(59);
iTLMq_TL_1_14 = x(60);
vTLRd_TL_1_14 = x(61);
vTLRq_TL_1_14 = x(62);
iTLMd_TL_1_15 = x(63);
iTLMq_TL_1_15 = x(64);
vTLRd_TL_1_15 = x(65);
vTLRq_TL_1_15 = x(66);
iTLMd_TL_1_2 = x(67);
iTLMq_TL_1_2 = x(68);
vTLRd_TL_1_2 = x(69);
vTLRq_TL_1_2 = x(70);
iTLMd_TL_1_12 = x(71);
iTLMq_TL_1_12 = x(72);
vTLRd_TL_1_12 = x(73);
vTLRq_TL_1_12 = x(74);
iTLMd_TL_1_13 = x(75);
iTLMq_TL_1_13 = x(76);
vTLRd_TL_1_13 = x(77);
vTLRq_TL_1_13 = x(78);
iTLMd_TL_1_11 = x(79);
iTLMq_TL_1_11 = x(80);
vTLRd_TL_1_11 = x(81);
vTLRq_TL_1_11 = x(82);
iTLMd_TL_5_21 = x(83);
iTLMq_TL_5_21 = x(84);
vTLRd_TL_5_21 = x(85);
vTLRq_TL_5_21 = x(86);
dphidt = 1; 
k=[5.8125   35.5171   -1.1682   -2.5449    1.3147    1.3279   -2.3964
   -3.5568   -9.1728   -3.9072    8.0164   -8.7656   -9.8039    1.4338];
reqd=[0.6192, 1.0, 0.8426, -0.5012, 1.19e-13, -1.484, 9.292e-14]';
Tm_G23=-(k(1,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+1.00;
    vR_G23=-(k(2,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+0.000641;

    reqd1 = [ 0.7241, 1.0, 0.8426, -0.5012, 2.558e-16, -1.81, -5.773e-16]';
k1  =[2.3522   33.1838    0.3140   -0.2362    0.5317    0.3897    0.2586
   -1.0142  -10.7170   -0.5415    0.9354   -1.0996   -1.9404    0.0550];

Tm_G22=-(k(1,:)*([delta_G22;omega_G22;iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22]-reqd))+1.00;
    vR_G22=-(k(2,:)*([delta_G22;omega_G22;iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22]-reqd))+0.0037;

diSd_G23dt = 377*vTLRd_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_2*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_2*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - Tm_G23 + iSd_G23*vTLRd_TL_1_2 + iSq_G23*vTLRq_TL_1_2)/(2*H_G23);
diSd_G22dt = 377*vTLLd_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*RR_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((RR_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLLq_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iSd_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iRq_G22*((Laq_G22*RR_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*vTLLq_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iRd_G22*((RR_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLLd_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*RR_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLLd_TL_1_5*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLLq_TL_1_5*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - Tm_G22 + iSd_G22*vTLLd_TL_1_5 + iSq_G22*vTLLq_TL_1_5)/(2*H_G22);
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_2 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - RL_L16*iLd_L16))/LL_L16;
diLq_L16dt = (377*(vTLRq_TL_5_16 - RL_L16*iLq_L16))/LL_L16 - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_5_17 - RL_L17*iLd_L17))/LL_L17;
diLq_L17dt = (377*(vTLRq_TL_5_17 - RL_L17*iLq_L17))/LL_L17 - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_5_18 - RL_L18*iLd_L18))/LL_L18;
diLq_L18dt = (377*(vTLRq_TL_5_18 - RL_L18*iLq_L18))/LL_L18 - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_5_19 - RL_L19*iLd_L19))/LL_L19;
diLq_L19dt = (377*(vTLRq_TL_5_19 - RL_L19*iLq_L19))/LL_L19 - 377*dphidt*iLd_L19;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_1_14 - RL_L14*iLd_L14))/LL_L14;
diLq_L14dt = (377*(vTLRq_TL_1_14 - RL_L14*iLq_L14))/LL_L14 - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_1_15 - RL_L15*iLd_L15))/LL_L15;
diLq_L15dt = (377*(vTLRq_TL_1_15 - RL_L15*iLq_L15))/LL_L15 - 377*dphidt*iLd_L15;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_1_12 - RL_L12*iLd_L12))/LL_L12;
diLq_L12dt = (377*(vTLRq_TL_1_12 - RL_L12*iLq_L12))/LL_L12 - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_1_13 - RL_L13*iLd_L13))/LL_L13;
diLq_L13dt = (377*(vTLRq_TL_1_13 - RL_L13*iLq_L13))/LL_L13 - 377*dphidt*iLd_L13;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_1_11 - RL_L11*iLd_L11))/LL_L11;
diLq_L11dt = (377*(vTLRq_TL_1_11 - RL_L11*iLq_L11))/LL_L11 - 377*dphidt*iLd_L11;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_5_21 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLRq_TL_5_21 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;
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
dvTLLd_TL_1_5dt = 0;%(377*(iSd_G22 - iTLMd_TL_1_2 - iTLMd_TL_1_5 - iTLMd_TL_1_11 - iTLMd_TL_1_12 - iTLMd_TL_1_13 - iTLMd_TL_1_14 - iTLMd_TL_1_15 + CTL_TL_1_2*dphidt*vTLLq_TL_1_5 + CTL_TL_1_5*dphidt*vTLLq_TL_1_5 + CTL_TL_1_11*dphidt*vTLLq_TL_1_5 + CTL_TL_1_12*dphidt*vTLLq_TL_1_5 + CTL_TL_1_13*dphidt*vTLLq_TL_1_5 + CTL_TL_1_14*dphidt*vTLLq_TL_1_5 + CTL_TL_1_15*dphidt*vTLLq_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
dvTLLq_TL_1_5dt = 0;%-(377*(iTLMq_TL_1_2 - iSq_G22 + iTLMq_TL_1_5 + iTLMq_TL_1_11 + iTLMq_TL_1_12 + iTLMq_TL_1_13 + iTLMq_TL_1_14 + iTLMq_TL_1_15 + CTL_TL_1_2*dphidt*vTLLd_TL_1_5 + CTL_TL_1_5*dphidt*vTLLd_TL_1_5 + CTL_TL_1_11*dphidt*vTLLd_TL_1_5 + CTL_TL_1_12*dphidt*vTLLd_TL_1_5 + CTL_TL_1_13*dphidt*vTLLd_TL_1_5 + CTL_TL_1_14*dphidt*vTLLd_TL_1_5 + CTL_TL_1_15*dphidt*vTLLd_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
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
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLLd_TL_5_16 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLLq_TL_5_16 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
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
diTLMd_TL_5_21dt
diTLMq_TL_5_21dt
dvTLRd_TL_5_21dt
dvTLRq_TL_5_21dt
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
vTLLd_TL_5_16 = x(:,37);
vTLLq_TL_5_16 = x(:,38);
iTLMd_TL_5_16 = x(:,39);
iTLMq_TL_5_16 = x(:,40);
vTLRd_TL_5_16 = x(:,41);
vTLRq_TL_5_16 = x(:,42);
iTLMd_TL_5_17 = x(:,43);
iTLMq_TL_5_17 = x(:,44);
vTLRd_TL_5_17 = x(:,45);
vTLRq_TL_5_17 = x(:,46);
iTLMd_TL_5_18 = x(:,47);
iTLMq_TL_5_18 = x(:,48);
vTLRd_TL_5_18 = x(:,49);
vTLRq_TL_5_18 = x(:,50);
iTLMd_TL_5_19 = x(:,51);
iTLMq_TL_5_19 = x(:,52);
vTLRd_TL_5_19 = x(:,53);
vTLRq_TL_5_19 = x(:,54);
vTLLd_TL_1_5 = x(:,55);
vTLLq_TL_1_5 = x(:,56);
iTLMd_TL_1_5 = x(:,57);
iTLMq_TL_1_5 = x(:,58);
iTLMd_TL_1_14 = x(:,59);
iTLMq_TL_1_14 = x(:,60);
vTLRd_TL_1_14 = x(:,61);
vTLRq_TL_1_14 = x(:,62);
iTLMd_TL_1_15 = x(:,63);
iTLMq_TL_1_15 = x(:,64);
vTLRd_TL_1_15 = x(:,65);
vTLRq_TL_1_15 = x(:,66);
iTLMd_TL_1_2 = x(:,67);
iTLMq_TL_1_2 = x(:,68);
vTLRd_TL_1_2 = x(:,69);
vTLRq_TL_1_2 = x(:,70);
iTLMd_TL_1_12 = x(:,71);
iTLMq_TL_1_12 = x(:,72);
vTLRd_TL_1_12 = x(:,73);
vTLRq_TL_1_12 = x(:,74);
iTLMd_TL_1_13 = x(:,75);
iTLMq_TL_1_13 = x(:,76);
vTLRd_TL_1_13 = x(:,77);
vTLRq_TL_1_13 = x(:,78);
iTLMd_TL_1_11 = x(:,79);
iTLMq_TL_1_11 = x(:,80);
vTLRd_TL_1_11 = x(:,81);
vTLRq_TL_1_11 = x(:,82);
iTLMd_TL_5_21 = x(:,83);
iTLMq_TL_5_21 = x(:,84);
vTLRd_TL_5_21 = x(:,85);
vTLRq_TL_5_21 = x(:,86);

save('DataCasePV.mat');

figure(1);
subplot(2,1,1)
plot(t,iSd_G23,'b',t,iSq_G23,'r');
title('Stator Currents of G1');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G23,'b',t,iRq_G23,'r',t,iF_G23,'k');
title('Rotor Currents of G1');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(2);
plot(t,delta_G23,t,omega_G23)
title('Rotor Mechanical states of G1')
xlabel('Time (in seconds)');
legend('Rotor Relative angle','Rotor angular frequency');

figure(3);
subplot(2,1,1)
plot(t,iSd_G22,'b',t,iSq_G22,'r');
title('Stator Currents of G2');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G22,'b',t,iRq_G22,'r',t,iF_G22,'k');
title('Rotor Currents of G2');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(4);
plot(t,delta_G22,t,omega_G22)
title('Rotor Mechanical states of G2')
xlabel('Time (in seconds)');
legend('Rotor Relative angle','Rotor angular frequency');

figure(9);
plot(t,vTLRd_TL_1_2,'b',t,vTLRq_TL_1_2,'r');
title('Voltages at bus 2');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(10);
plot(t,vTLLd_TL_5_16,'b',t,vTLLq_TL_5_16,'r');
title('Voltages at bus 5');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(11);
plot(t,vTLRd_TL_1_14,'b',t,vTLRq_TL_1_14,'r');
title('Voltages at bus 14');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

end