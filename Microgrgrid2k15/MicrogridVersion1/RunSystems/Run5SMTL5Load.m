function RunSMTLLoad

clear all
close all

set(0,'defaultlinelinewidth',1.5)


addpath('../Parameters')
            
load('G1.mat','Lad_G1','Laf_G1','Laq_G1','Ldf_G1','LSd_G1','LSq_G1','LRD_G1','LF_G1','LRQ_G1','RS_G1','RR_G1','RF_G1','H_G1','B_G1')
load('G2.mat','Lad_G2','Laf_G2','Laq_G2','Ldf_G2','LSd_G2','LSq_G2','LRD_G2','LF_G2','LRQ_G2','RS_G2','RR_G2','RF_G2','H_G2','B_G2')
load('G3.mat','Lad_G3','Laf_G3','Laq_G3','Ldf_G3','LSd_G3','LSq_G3','LRD_G3','LF_G3','LRQ_G3','RS_G3','RR_G3','RF_G3','H_G3','B_G3')
load('G4.mat','Lad_G4','Laf_G4','Laq_G4','Ldf_G4','LSd_G4','LSq_G4','LRD_G4','LF_G4','LRQ_G4','RS_G4','RR_G4','RF_G4','H_G4','B_G4')
load('G5.mat','Lad_G5','Laf_G5','Laq_G5','Ldf_G5','LSd_G5','LSq_G5','LRD_G5','LF_G5','LRQ_G5','RS_G5','RR_G5','RF_G5','H_G5','B_G5')

load('L1.mat', 'RL_L1', 'LL_L1');
load('L2.mat', 'RL_L2', 'LL_L2');
load('L3.mat', 'RL_L3', 'LL_L3');
load('L4.mat', 'RL_L4', 'LL_L4');
load('L5.mat', 'RL_L5', 'LL_L5');

load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
LTL_TL_1_2=LTL_TL_2_23;
RTL_TL_1_2=RTL_TL_2_23;
CTL_TL_1_2=CTL_TL_2_23;
x0 = 0.5*ones(51,1);

tic  
tArray = [4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5];

t = [];
x = [];
%for i = 1:numel(tauL_IM2Array)
    tspan = [tArray(1),5];
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%Options);

    toc


function [dx] = LLMicrogridDynamics(t,x)
    t
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
iSd_G3 = x(15);
iSq_G3 = x(16);
iRd_G3 = x(17);
iRq_G3 = x(18);
iF_G3 = x(19);
delta_G3 = x(20);
omega_G3 = x(21);
iSd_G4 = x(22);
iSq_G4 = x(23);
iRd_G4 = x(24);
iRq_G4 = x(25);
iF_G4 = x(26);
delta_G4 = x(27);
omega_G4 = x(28);
iSd_G5 = x(29);
iSq_G5 = x(30);
iRd_G5 = x(31);
iRq_G5 = x(32);
iF_G5 = x(33);
delta_G5 = x(34);
omega_G5 = x(35);
iLd_L1 = x(36);
iLq_L1 = x(37);
iLd_L2 = x(38);
iLq_L2 = x(39);
iLd_L3 = x(40);
iLq_L3 = x(41);
iLd_L4 = x(42);
iLq_L4 = x(43);
iLd_L5 = x(44);
iLq_L5 = x(45);
vTLLd_TL_1_2 = x(46);
vTLLq_TL_1_2 = x(47);
iTLMd_TL_1_2 = x(48);
iTLMq_TL_1_2 = x(49);
vTLRd_TL_1_2 = x(50);
vTLRq_TL_1_2 = x(51);

dphidt = 1; 
reqd1 = [ 0.7241, 1.0, 0.8426, -0.5012, 2.558e-16, -1.81, -5.773e-16]';
k1  =[2.3522   33.1838    0.3140   -0.2362    0.5317    0.3897    0.2586
   -1.0142  -10.7170   -0.5415    0.9354   -1.0996   -1.9404    0.0550];
Tm_G1=-(k1(1,:)*([delta_G1;omega_G1;iSd_G1;iSq_G1;iRd_G1;iF_G1;iRq_G1]-reqd1))+1.00;
    vR_G1=-(k1(2,:)*([delta_G1;omega_G1;iSd_G1;iSq_G1;iRd_G1;iF_G1;iRq_G1]-reqd1))+0.003729;

Tm_G2=-(k1(1,:)*([delta_G2;omega_G2;iSd_G2;iSq_G2;iRd_G2;iF_G2;iRq_G2]-reqd1))+1.00;
    vR_G2=-(k1(2,:)*([delta_G2;omega_G2;iSd_G2;iSq_G2;iRd_G2;iF_G2;iRq_G2]-reqd1))+0.003729;

Tm_G3=-(k1(1,:)*([delta_G3;omega_G3;iSd_G3;iSq_G3;iRd_G3;iF_G3;iRq_G3]-reqd1))+1.00;
    vR_G3=-(k1(2,:)*([delta_G3;omega_G3;iSd_G3;iSq_G3;iRd_G3;iF_G3;iRq_G3]-reqd1))+0.003729;

Tm_G4=-(k1(1,:)*([delta_G4;omega_G4;iSd_G4;iSq_G4;iRd_G4;iF_G4;iRq_G4]-reqd1))+1.00;
    vR_G4=-(k1(2,:)*([delta_G4;omega_G4;iSd_G4;iSq_G4;iRd_G4;iF_G4;iRq_G4]-reqd1))+0.003729;

Tm_G5=-(k1(1,:)*([delta_G5;omega_G5;iSd_G5;iSq_G5;iRd_G5;iF_G5;iRq_G5]-reqd1))+1.00;
    vR_G5=-(k1(2,:)*([delta_G5;omega_G5;iSd_G5;iSq_G5;iRd_G5;iF_G5;iRq_G5]-reqd1))+0.003729;
    
    
diSd_G1dt = 377*vTLLd_TL_1_2*(cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - 377*iRq_G1*((Laq_G1*RR_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (Laq_G1*omega_G1*sin(delta_G1)*(Ldf_G1^2 - LF_G1*LRD_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSq_G1*(omega_G1 - dphidt + omega_G1*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + omega_G1*cos(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - RS_G1*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) + 377*iSd_G1*(RS_G1*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + omega_G1*sin(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) - 377*iF_G1*((RF_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LRQ_G1*Laf_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - 377*iRd_G1*((RR_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LRQ_G1*Lad_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*vTLLq_TL_1_2*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diSq_G1dt = 377*iSd_G1*(omega_G1 - dphidt + omega_G1*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - omega_G1*cos(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) - 377*iRq_G1*((Laq_G1*RR_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) + (Laq_G1*omega_G1*cos(delta_G1)*(Ldf_G1^2 - LF_G1*LRD_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*vTLLq_TL_1_2*(cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSq_G1*(omega_G1*sin(2*delta_G1)*((LRQ_G1*LSd_G1)/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (LSq_G1*(Ldf_G1^2 - LF_G1*LRD_G1))/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) - RS_G1*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) - (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + RS_G1*cos(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1))) + 377*iF_G1*((RF_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LRQ_G1*Laf_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*iRd_G1*((RR_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LRQ_G1*Lad_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) + 377*vTLLd_TL_1_2*sin(2*delta_G1)*(LRQ_G1/(2*Laq_G1^2 - 2*LRQ_G1*LSq_G1) + (Ldf_G1^2 - LF_G1*LRD_G1)/(2*LF_G1*Lad_G1^2 + 2*LRD_G1*Laf_G1^2 + 2*LSd_G1*Ldf_G1^2 - 2*LF_G1*LRD_G1*LSd_G1 - 4*Lad_G1*Laf_G1*Ldf_G1)) + (377*vR_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diRd_G1dt = 377*iSq_G1*((RS_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LSq_G1*omega_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSd_G1*((RS_G1*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LSq_G1*omega_G1*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*vTLLq_TL_1_2*cos(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*vTLLd_TL_1_2*sin(delta_G1)*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RR_G1*iRd_G1*(Laf_G1^2 - LF_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RF_G1*iF_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*Laq_G1*iRq_G1*omega_G1*(LF_G1*Lad_G1 - Laf_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
diRq_G1dt = (377*LSq_G1*RR_G1*iRq_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1) - 377*iSq_G1*((Laq_G1*RS_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (LSd_G1*Laq_G1*omega_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - (377*Laq_G1*vTLLd_TL_1_2*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - (377*Laq_G1*vTLLq_TL_1_2*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) - 377*iSd_G1*((Laq_G1*RS_G1*cos(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1) + (LSd_G1*Laq_G1*omega_G1*sin(delta_G1))/(Laq_G1^2 - LRQ_G1*LSq_G1)) - (377*Laf_G1*Laq_G1*iF_G1*omega_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1) - (377*Lad_G1*Laq_G1*iRd_G1*omega_G1)/(Laq_G1^2 - LRQ_G1*LSq_G1);
diF_G1dt = 377*iSq_G1*((RS_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (LSq_G1*omega_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - 377*iSd_G1*((RS_G1*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (LSq_G1*omega_G1*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1)) - (377*vR_G1*(Lad_G1^2 - LRD_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*vTLLq_TL_1_2*cos(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*vTLLd_TL_1_2*sin(delta_G1)*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RF_G1*iF_G1*(Lad_G1^2 - LRD_G1*LSd_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) - (377*RR_G1*iRd_G1*(LSd_G1*Ldf_G1 - Lad_G1*Laf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1) + (377*Laq_G1*iRq_G1*omega_G1*(LRD_G1*Laf_G1 - Lad_G1*Ldf_G1))/(LF_G1*Lad_G1^2 + LRD_G1*Laf_G1^2 + LSd_G1*Ldf_G1^2 - LF_G1*LRD_G1*LSd_G1 - 2*Lad_G1*Laf_G1*Ldf_G1);
ddelta_G1dt = 377*omega_G1 - 377;
domega_G1dt = -(B_G1*omega_G1 - Tm_G1 + iSd_G1*vTLLd_TL_1_2 + iSq_G1*vTLLq_TL_1_2)/(2*H_G1);
diSd_G2dt = 377*vTLLd_TL_1_2*(cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - 377*iRq_G2*((Laq_G2*RR_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (Laq_G2*omega_G2*sin(delta_G2)*(Ldf_G2^2 - LF_G2*LRD_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSq_G2*(omega_G2 - dphidt + omega_G2*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + omega_G2*cos(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - RS_G2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) + 377*iSd_G2*(RS_G2*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + omega_G2*sin(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) - 377*iF_G2*((RF_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LRQ_G2*Laf_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - 377*iRd_G2*((RR_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LRQ_G2*Lad_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*vTLLq_TL_1_2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diSq_G2dt = 377*iSd_G2*(omega_G2 - dphidt + omega_G2*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - omega_G2*cos(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) - 377*iRq_G2*((Laq_G2*RR_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) + (Laq_G2*omega_G2*cos(delta_G2)*(Ldf_G2^2 - LF_G2*LRD_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*vTLLq_TL_1_2*(cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSq_G2*(omega_G2*sin(2*delta_G2)*((LRQ_G2*LSd_G2)/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (LSq_G2*(Ldf_G2^2 - LF_G2*LRD_G2))/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) - RS_G2*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) - (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + RS_G2*cos(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2))) + 377*iF_G2*((RF_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LRQ_G2*Laf_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*iRd_G2*((RR_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LRQ_G2*Lad_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) + 377*vTLLd_TL_1_2*sin(2*delta_G2)*(LRQ_G2/(2*Laq_G2^2 - 2*LRQ_G2*LSq_G2) + (Ldf_G2^2 - LF_G2*LRD_G2)/(2*LF_G2*Lad_G2^2 + 2*LRD_G2*Laf_G2^2 + 2*LSd_G2*Ldf_G2^2 - 2*LF_G2*LRD_G2*LSd_G2 - 4*Lad_G2*Laf_G2*Ldf_G2)) + (377*vR_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diRd_G2dt = 377*iSq_G2*((RS_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LSq_G2*omega_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSd_G2*((RS_G2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LSq_G2*omega_G2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*vTLLq_TL_1_2*cos(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*vTLLd_TL_1_2*sin(delta_G2)*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RR_G2*iRd_G2*(Laf_G2^2 - LF_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RF_G2*iF_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*Laq_G2*iRq_G2*omega_G2*(LF_G2*Lad_G2 - Laf_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
diRq_G2dt = (377*LSq_G2*RR_G2*iRq_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2) - 377*iSq_G2*((Laq_G2*RS_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (LSd_G2*Laq_G2*omega_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - (377*Laq_G2*vTLLd_TL_1_2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - (377*Laq_G2*vTLLq_TL_1_2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) - 377*iSd_G2*((Laq_G2*RS_G2*cos(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2) + (LSd_G2*Laq_G2*omega_G2*sin(delta_G2))/(Laq_G2^2 - LRQ_G2*LSq_G2)) - (377*Laf_G2*Laq_G2*iF_G2*omega_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2) - (377*Lad_G2*Laq_G2*iRd_G2*omega_G2)/(Laq_G2^2 - LRQ_G2*LSq_G2);
diF_G2dt = 377*iSq_G2*((RS_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (LSq_G2*omega_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - 377*iSd_G2*((RS_G2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (LSq_G2*omega_G2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2)) - (377*vR_G2*(Lad_G2^2 - LRD_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*vTLLq_TL_1_2*cos(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*vTLLd_TL_1_2*sin(delta_G2)*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RF_G2*iF_G2*(Lad_G2^2 - LRD_G2*LSd_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) - (377*RR_G2*iRd_G2*(LSd_G2*Ldf_G2 - Lad_G2*Laf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2) + (377*Laq_G2*iRq_G2*omega_G2*(LRD_G2*Laf_G2 - Lad_G2*Ldf_G2))/(LF_G2*Lad_G2^2 + LRD_G2*Laf_G2^2 + LSd_G2*Ldf_G2^2 - LF_G2*LRD_G2*LSd_G2 - 2*Lad_G2*Laf_G2*Ldf_G2);
ddelta_G2dt = 377*omega_G2 - 377;
domega_G2dt = -(B_G2*omega_G2 - Tm_G2 + iSd_G2*vTLLd_TL_1_2 + iSq_G2*vTLLq_TL_1_2)/(2*H_G2);
diSd_G3dt = 377*vTLLd_TL_1_2*(cos(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) - (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - 377*iRq_G3*((Laq_G3*RR_G3*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) - (Laq_G3*omega_G3*sin(delta_G3)*(Ldf_G3^2 - LF_G3*LRD_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - 377*iSq_G3*(omega_G3 - dphidt + omega_G3*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) - (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + omega_G3*cos(2*delta_G3)*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - RS_G3*sin(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3))) + 377*iSd_G3*(RS_G3*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) - (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + omega_G3*sin(2*delta_G3)*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + RS_G3*cos(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3))) - 377*iF_G3*((RF_G3*sin(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (LRQ_G3*Laf_G3*omega_G3*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) - 377*iRd_G3*((RR_G3*sin(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (LRQ_G3*Lad_G3*omega_G3*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) + 377*vTLLq_TL_1_2*sin(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - (377*vR_G3*sin(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3);
diSq_G3dt = 377*iSd_G3*(omega_G3 - dphidt + omega_G3*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) - (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - omega_G3*cos(2*delta_G3)*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + RS_G3*sin(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3))) - 377*iRq_G3*((Laq_G3*RR_G3*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) + (Laq_G3*omega_G3*cos(delta_G3)*(Ldf_G3^2 - LF_G3*LRD_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - 377*vTLLq_TL_1_2*(cos(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - 377*iSq_G3*(omega_G3*sin(2*delta_G3)*((LRQ_G3*LSd_G3)/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (LSq_G3*(Ldf_G3^2 - LF_G3*LRD_G3))/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) - RS_G3*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) - (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + RS_G3*cos(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3))) + 377*iF_G3*((RF_G3*cos(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (LRQ_G3*Laf_G3*omega_G3*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) + 377*iRd_G3*((RR_G3*cos(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (LRQ_G3*Lad_G3*omega_G3*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) + 377*vTLLd_TL_1_2*sin(2*delta_G3)*(LRQ_G3/(2*Laq_G3^2 - 2*LRQ_G3*LSq_G3) + (Ldf_G3^2 - LF_G3*LRD_G3)/(2*LF_G3*Lad_G3^2 + 2*LRD_G3*Laf_G3^2 + 2*LSd_G3*Ldf_G3^2 - 2*LF_G3*LRD_G3*LSd_G3 - 4*Lad_G3*Laf_G3*Ldf_G3)) + (377*vR_G3*cos(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3);
diRd_G3dt = 377*iSq_G3*((RS_G3*cos(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (LSq_G3*omega_G3*sin(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - 377*iSd_G3*((RS_G3*sin(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (LSq_G3*omega_G3*cos(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - (377*vR_G3*(LSd_G3*Ldf_G3 - Lad_G3*Laf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (377*vTLLq_TL_1_2*cos(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*vTLLd_TL_1_2*sin(delta_G3)*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*RR_G3*iRd_G3*(Laf_G3^2 - LF_G3*LSd_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*RF_G3*iF_G3*(LSd_G3*Ldf_G3 - Lad_G3*Laf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (377*Laq_G3*iRq_G3*omega_G3*(LF_G3*Lad_G3 - Laf_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3);
diRq_G3dt = (377*LSq_G3*RR_G3*iRq_G3)/(Laq_G3^2 - LRQ_G3*LSq_G3) - 377*iSq_G3*((Laq_G3*RS_G3*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) - (LSd_G3*Laq_G3*omega_G3*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) - (377*Laq_G3*vTLLd_TL_1_2*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) - (377*Laq_G3*vTLLq_TL_1_2*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) - 377*iSd_G3*((Laq_G3*RS_G3*cos(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3) + (LSd_G3*Laq_G3*omega_G3*sin(delta_G3))/(Laq_G3^2 - LRQ_G3*LSq_G3)) - (377*Laf_G3*Laq_G3*iF_G3*omega_G3)/(Laq_G3^2 - LRQ_G3*LSq_G3) - (377*Lad_G3*Laq_G3*iRd_G3*omega_G3)/(Laq_G3^2 - LRQ_G3*LSq_G3);
diF_G3dt = 377*iSq_G3*((RS_G3*cos(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (LSq_G3*omega_G3*sin(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - 377*iSd_G3*((RS_G3*sin(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (LSq_G3*omega_G3*cos(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3)) - (377*vR_G3*(Lad_G3^2 - LRD_G3*LSd_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (377*vTLLq_TL_1_2*cos(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*vTLLd_TL_1_2*sin(delta_G3)*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*RF_G3*iF_G3*(Lad_G3^2 - LRD_G3*LSd_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) - (377*RR_G3*iRd_G3*(LSd_G3*Ldf_G3 - Lad_G3*Laf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3) + (377*Laq_G3*iRq_G3*omega_G3*(LRD_G3*Laf_G3 - Lad_G3*Ldf_G3))/(LF_G3*Lad_G3^2 + LRD_G3*Laf_G3^2 + LSd_G3*Ldf_G3^2 - LF_G3*LRD_G3*LSd_G3 - 2*Lad_G3*Laf_G3*Ldf_G3);
ddelta_G3dt = 377*omega_G3 - 377;
domega_G3dt = -(B_G3*omega_G3 - Tm_G3 + iSd_G3*vTLLd_TL_1_2 + iSq_G3*vTLLq_TL_1_2)/(2*H_G3);
diSd_G4dt = 377*vTLLd_TL_1_2*(cos(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) - (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - 377*iRq_G4*((Laq_G4*RR_G4*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) - (Laq_G4*omega_G4*sin(delta_G4)*(Ldf_G4^2 - LF_G4*LRD_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - 377*iSq_G4*(omega_G4 - dphidt + omega_G4*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) - (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + omega_G4*cos(2*delta_G4)*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - RS_G4*sin(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4))) + 377*iSd_G4*(RS_G4*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) - (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + omega_G4*sin(2*delta_G4)*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + RS_G4*cos(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4))) - 377*iF_G4*((RF_G4*sin(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (LRQ_G4*Laf_G4*omega_G4*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) - 377*iRd_G4*((RR_G4*sin(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (LRQ_G4*Lad_G4*omega_G4*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) + 377*vTLLq_TL_1_2*sin(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - (377*vR_G4*sin(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4);
diSq_G4dt = 377*iSd_G4*(omega_G4 - dphidt + omega_G4*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) - (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - omega_G4*cos(2*delta_G4)*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + RS_G4*sin(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4))) - 377*iRq_G4*((Laq_G4*RR_G4*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) + (Laq_G4*omega_G4*cos(delta_G4)*(Ldf_G4^2 - LF_G4*LRD_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - 377*vTLLq_TL_1_2*(cos(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - 377*iSq_G4*(omega_G4*sin(2*delta_G4)*((LRQ_G4*LSd_G4)/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (LSq_G4*(Ldf_G4^2 - LF_G4*LRD_G4))/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) - RS_G4*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) - (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + RS_G4*cos(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4))) + 377*iF_G4*((RF_G4*cos(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (LRQ_G4*Laf_G4*omega_G4*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) + 377*iRd_G4*((RR_G4*cos(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (LRQ_G4*Lad_G4*omega_G4*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) + 377*vTLLd_TL_1_2*sin(2*delta_G4)*(LRQ_G4/(2*Laq_G4^2 - 2*LRQ_G4*LSq_G4) + (Ldf_G4^2 - LF_G4*LRD_G4)/(2*LF_G4*Lad_G4^2 + 2*LRD_G4*Laf_G4^2 + 2*LSd_G4*Ldf_G4^2 - 2*LF_G4*LRD_G4*LSd_G4 - 4*Lad_G4*Laf_G4*Ldf_G4)) + (377*vR_G4*cos(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4);
diRd_G4dt = 377*iSq_G4*((RS_G4*cos(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (LSq_G4*omega_G4*sin(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - 377*iSd_G4*((RS_G4*sin(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (LSq_G4*omega_G4*cos(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - (377*vR_G4*(LSd_G4*Ldf_G4 - Lad_G4*Laf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (377*vTLLq_TL_1_2*cos(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*vTLLd_TL_1_2*sin(delta_G4)*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*RR_G4*iRd_G4*(Laf_G4^2 - LF_G4*LSd_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*RF_G4*iF_G4*(LSd_G4*Ldf_G4 - Lad_G4*Laf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (377*Laq_G4*iRq_G4*omega_G4*(LF_G4*Lad_G4 - Laf_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4);
diRq_G4dt = (377*LSq_G4*RR_G4*iRq_G4)/(Laq_G4^2 - LRQ_G4*LSq_G4) - 377*iSq_G4*((Laq_G4*RS_G4*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) - (LSd_G4*Laq_G4*omega_G4*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) - (377*Laq_G4*vTLLd_TL_1_2*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) - (377*Laq_G4*vTLLq_TL_1_2*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) - 377*iSd_G4*((Laq_G4*RS_G4*cos(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4) + (LSd_G4*Laq_G4*omega_G4*sin(delta_G4))/(Laq_G4^2 - LRQ_G4*LSq_G4)) - (377*Laf_G4*Laq_G4*iF_G4*omega_G4)/(Laq_G4^2 - LRQ_G4*LSq_G4) - (377*Lad_G4*Laq_G4*iRd_G4*omega_G4)/(Laq_G4^2 - LRQ_G4*LSq_G4);
diF_G4dt = 377*iSq_G4*((RS_G4*cos(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (LSq_G4*omega_G4*sin(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - 377*iSd_G4*((RS_G4*sin(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (LSq_G4*omega_G4*cos(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4)) - (377*vR_G4*(Lad_G4^2 - LRD_G4*LSd_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (377*vTLLq_TL_1_2*cos(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*vTLLd_TL_1_2*sin(delta_G4)*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*RF_G4*iF_G4*(Lad_G4^2 - LRD_G4*LSd_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) - (377*RR_G4*iRd_G4*(LSd_G4*Ldf_G4 - Lad_G4*Laf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4) + (377*Laq_G4*iRq_G4*omega_G4*(LRD_G4*Laf_G4 - Lad_G4*Ldf_G4))/(LF_G4*Lad_G4^2 + LRD_G4*Laf_G4^2 + LSd_G4*Ldf_G4^2 - LF_G4*LRD_G4*LSd_G4 - 2*Lad_G4*Laf_G4*Ldf_G4);
ddelta_G4dt = 377*omega_G4 - 377;
domega_G4dt = -(B_G4*omega_G4 - Tm_G4 + iSd_G4*vTLLd_TL_1_2 + iSq_G4*vTLLq_TL_1_2)/(2*H_G4);
diSd_G5dt = 377*vTLLd_TL_1_2*(cos(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) - (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - 377*iRq_G5*((Laq_G5*RR_G5*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) - (Laq_G5*omega_G5*sin(delta_G5)*(Ldf_G5^2 - LF_G5*LRD_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - 377*iSq_G5*(omega_G5 - dphidt + omega_G5*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) - (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + omega_G5*cos(2*delta_G5)*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - RS_G5*sin(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5))) + 377*iSd_G5*(RS_G5*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) - (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + omega_G5*sin(2*delta_G5)*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + RS_G5*cos(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5))) - 377*iF_G5*((RF_G5*sin(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (LRQ_G5*Laf_G5*omega_G5*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) - 377*iRd_G5*((RR_G5*sin(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (LRQ_G5*Lad_G5*omega_G5*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) + 377*vTLLq_TL_1_2*sin(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - (377*vR_G5*sin(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5);
diSq_G5dt = 377*iSd_G5*(omega_G5 - dphidt + omega_G5*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) - (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - omega_G5*cos(2*delta_G5)*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + RS_G5*sin(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5))) - 377*iRq_G5*((Laq_G5*RR_G5*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) + (Laq_G5*omega_G5*cos(delta_G5)*(Ldf_G5^2 - LF_G5*LRD_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - 377*vTLLq_TL_1_2*(cos(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - 377*iSq_G5*(omega_G5*sin(2*delta_G5)*((LRQ_G5*LSd_G5)/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (LSq_G5*(Ldf_G5^2 - LF_G5*LRD_G5))/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) - RS_G5*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) - (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + RS_G5*cos(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5))) + 377*iF_G5*((RF_G5*cos(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (LRQ_G5*Laf_G5*omega_G5*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) + 377*iRd_G5*((RR_G5*cos(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (LRQ_G5*Lad_G5*omega_G5*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) + 377*vTLLd_TL_1_2*sin(2*delta_G5)*(LRQ_G5/(2*Laq_G5^2 - 2*LRQ_G5*LSq_G5) + (Ldf_G5^2 - LF_G5*LRD_G5)/(2*LF_G5*Lad_G5^2 + 2*LRD_G5*Laf_G5^2 + 2*LSd_G5*Ldf_G5^2 - 2*LF_G5*LRD_G5*LSd_G5 - 4*Lad_G5*Laf_G5*Ldf_G5)) + (377*vR_G5*cos(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5);
diRd_G5dt = 377*iSq_G5*((RS_G5*cos(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (LSq_G5*omega_G5*sin(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - 377*iSd_G5*((RS_G5*sin(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (LSq_G5*omega_G5*cos(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - (377*vR_G5*(LSd_G5*Ldf_G5 - Lad_G5*Laf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (377*vTLLq_TL_1_2*cos(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*vTLLd_TL_1_2*sin(delta_G5)*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*RR_G5*iRd_G5*(Laf_G5^2 - LF_G5*LSd_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*RF_G5*iF_G5*(LSd_G5*Ldf_G5 - Lad_G5*Laf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (377*Laq_G5*iRq_G5*omega_G5*(LF_G5*Lad_G5 - Laf_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5);
diRq_G5dt = (377*LSq_G5*RR_G5*iRq_G5)/(Laq_G5^2 - LRQ_G5*LSq_G5) - 377*iSq_G5*((Laq_G5*RS_G5*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) - (LSd_G5*Laq_G5*omega_G5*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) - (377*Laq_G5*vTLLd_TL_1_2*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) - (377*Laq_G5*vTLLq_TL_1_2*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) - 377*iSd_G5*((Laq_G5*RS_G5*cos(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5) + (LSd_G5*Laq_G5*omega_G5*sin(delta_G5))/(Laq_G5^2 - LRQ_G5*LSq_G5)) - (377*Laf_G5*Laq_G5*iF_G5*omega_G5)/(Laq_G5^2 - LRQ_G5*LSq_G5) - (377*Lad_G5*Laq_G5*iRd_G5*omega_G5)/(Laq_G5^2 - LRQ_G5*LSq_G5);
diF_G5dt = 377*iSq_G5*((RS_G5*cos(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (LSq_G5*omega_G5*sin(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - 377*iSd_G5*((RS_G5*sin(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (LSq_G5*omega_G5*cos(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5)) - (377*vR_G5*(Lad_G5^2 - LRD_G5*LSd_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (377*vTLLq_TL_1_2*cos(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*vTLLd_TL_1_2*sin(delta_G5)*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*RF_G5*iF_G5*(Lad_G5^2 - LRD_G5*LSd_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) - (377*RR_G5*iRd_G5*(LSd_G5*Ldf_G5 - Lad_G5*Laf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5) + (377*Laq_G5*iRq_G5*omega_G5*(LRD_G5*Laf_G5 - Lad_G5*Ldf_G5))/(LF_G5*Lad_G5^2 + LRD_G5*Laf_G5^2 + LSd_G5*Ldf_G5^2 - LF_G5*LRD_G5*LSd_G5 - 2*Lad_G5*Laf_G5*Ldf_G5);
ddelta_G5dt = 377*omega_G5 - 377;
domega_G5dt = -(B_G5*omega_G5 - Tm_G5 + iSd_G5*vTLLd_TL_1_2 + iSq_G5*vTLLq_TL_1_2)/(2*H_G5);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLRd_TL_1_2 - RL_L1*iLd_L1))/LL_L1;
diLq_L1dt = (377*(vTLRq_TL_1_2 - RL_L1*iLq_L1))/LL_L1 - 377*dphidt*iLd_L1;
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_2 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L3dt = 377*dphidt*iLq_L3 + (377*(vTLRd_TL_1_2 - RL_L3*iLd_L3))/LL_L3;
diLq_L3dt = (377*(vTLRq_TL_1_2 - RL_L3*iLq_L3))/LL_L3 - 377*dphidt*iLd_L3;
diLd_L4dt = 377*dphidt*iLq_L4 + (377*(vTLRd_TL_1_2 - RL_L4*iLd_L4))/LL_L4;
diLq_L4dt = (377*(vTLRq_TL_1_2 - RL_L4*iLq_L4))/LL_L4 - 377*dphidt*iLd_L4;
diLd_L5dt = 377*dphidt*iLq_L5 + (377*(vTLRd_TL_1_2 - RL_L5*iLd_L5))/LL_L5;
diLq_L5dt = (377*(vTLRq_TL_1_2 - RL_L5*iLq_L5))/LL_L5 - 377*dphidt*iLd_L5;
dvTLLd_TL_1_2dt = (377*(iSd_G1 + iSd_G2 + iSd_G3 + iSd_G4 + iSd_G5 - iTLMd_TL_1_2))/CTL_TL_1_2 + 377*dphidt*vTLLq_TL_1_2;
dvTLLq_TL_1_2dt = (377*(iSq_G1 + iSq_G2 + iSq_G3 + iSq_G4 + iSq_G5 - iTLMq_TL_1_2))/CTL_TL_1_2 - 377*dphidt*vTLLd_TL_1_2;
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_2 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_2 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = 377*dphidt*vTLRq_TL_1_2 - (377*(iLd_L1 + iLd_L2 + iLd_L3 + iLd_L4 + iLd_L5 - iTLMd_TL_1_2))/CTL_TL_1_2;
dvTLRq_TL_1_2dt = - (377*(iLq_L1 + iLq_L2 + iLq_L3 + iLq_L4 + iLq_L5 - iTLMq_TL_1_2))/CTL_TL_1_2 - 377*dphidt*vTLRd_TL_1_2;
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
diSd_G3dt
diSq_G3dt
diRd_G3dt
diRq_G3dt
diF_G3dt
ddelta_G3dt
domega_G3dt
diSd_G4dt
diSq_G4dt
diRd_G4dt
diRq_G4dt
diF_G4dt
ddelta_G4dt
domega_G4dt
diSd_G5dt
diSq_G5dt
diRd_G5dt
diRq_G5dt
diF_G5dt
ddelta_G5dt
domega_G5dt
diLd_L1dt
diLq_L1dt
diLd_L2dt
diLq_L2dt
diLd_L3dt
diLq_L3dt
diLd_L4dt
diLq_L4dt
diLd_L5dt
diLq_L5dt
dvTLLd_TL_1_2dt
dvTLLq_TL_1_2dt
diTLMd_TL_1_2dt
diTLMq_TL_1_2dt
dvTLRd_TL_1_2dt
dvTLRq_TL_1_2dt
];
end
iSd_G1 = x(:,1);
iSq_G1 = x(:,2);
iRd_G1 = x(:,3);
iRq_G1 = x(:,4);
iF_G1 = x(:,5);
delta_G1 = x(:,6);
omega_G1 = x(:,7);
iSd_G2 = x(:,8);
iSq_G2 = x(:,9);
iRd_G2 = x(:,10);
iRq_G2 = x(:,11);
iF_G2 = x(:,12);
delta_G2 = x(:,13);
omega_G2 = x(:,14);
iSd_G3 = x(:,15);
iSq_G3 = x(:,16);
iRd_G3 = x(:,17);
iRq_G3 = x(:,18);
iF_G3 = x(:,19);
delta_G3 = x(:,20);
omega_G3 = x(:,21);
iSd_G4 = x(:,22);
iSq_G4 = x(:,23);
iRd_G4 = x(:,24);
iRq_G4 = x(:,25);
iF_G4 = x(:,26);
delta_G4 = x(:,27);
omega_G4 = x(:,28);
iSd_G5 = x(:,29);
iSq_G5 = x(:,30);
iRd_G5 = x(:,31);
iRq_G5 = x(:,32);
iF_G5 = x(:,33);
delta_G5 = x(:,34);
omega_G5 = x(:,35);
iLd_L1 = x(:,36);
iLq_L1 = x(:,37);
iLd_L2 = x(:,38);
iLq_L2 = x(:,39);
iLd_L3 = x(:,40);
iLq_L3 = x(:,41);
iLd_L4 = x(:,42);
iLq_L4 = x(:,43);
iLd_L5 = x(:,44);
iLq_L5 = x(:,45);
vTLLd_TL_1_2 = x(:,46);
vTLLq_TL_1_2 = x(:,47);
iTLMd_TL_1_2 = x(:,48);
iTLMq_TL_1_2 = x(:,49);
vTLRd_TL_1_2 = x(:,50);
vTLRq_TL_1_2 = x(:,51);

save('Data5SMTL5Load.mat')
figure(1);
subplot(2,1,1)
plot(t,iSd_G1,'b',t,iSq_G1,'r');
title('Stator Currents of G1');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G1,'b',t,iRq_G1,'r',t,iF_G1,'k');
title('Rotor Currents of G1');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(2);
plot(t,delta_G1,t,omega_G1)
title('Rotor Mechanical states of G1')
xlabel('Time (in seconds)');
legend('Rotor Relative angle','Rotor angular frequency');

figure(3);
plot(t,vTLRd_TL_1_2,'b',t,vTLRq_TL_1_2,'r',t,vTLRd_TL_1_2,'b--',t,vTLRq_TL_1_2,'r--');
title('Voltages ');
legend('V1d','V1q','V2d','V2q');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(4);
plot(t,iLd_L2,'b',t,iLq_L2,'r');
title('Currents of L2');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

end