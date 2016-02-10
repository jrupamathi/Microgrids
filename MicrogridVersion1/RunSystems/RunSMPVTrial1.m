function RunSMPVTrial1

clear all
close all

set(0,'defaultlinelinewidth',1.5)

addpath('../Parameters')
            
load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')

load('L2.mat', 'RL_L2', 'LL_L2');
load('L16.mat', 'RL_L16', 'LL_L16');
load('PV21.mat', 'RR_PV21','LR_PV21','Pref_PV21', 'Vref_PV21','Kp1_PV21','Ki1_PV21','Kp2_PV21','Ki2_PV21','c1_PV21','c2_PV21','k1_PV21','k2_PV21');

load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
load('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
load('TL_1_5.mat', 'LTL_TL_1_5', 'RTL_TL_1_5','CTL_TL_1_5');
load('TL_5_16.mat', 'LTL_TL_5_16', 'RTL_TL_5_16','CTL_TL_5_16');
load('TL_5_21.mat', 'LTL_TL_5_21', 'RTL_TL_5_21','CTL_TL_5_21');


x0=rand(37,1);
% base frequency
wb = 377;
omega0 = 1;


tic

Options =  odeset('RelTol',1e-4,'AbsTol',1e-3');

t = [];
x = [];
%for i = 1:numel(tArray)-1
    tspan = [6,6.1];%tArray(i+1)];
    %tauL_IM2 = tauL_IM2Array(1);
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%,Options,tauL_IM2);
   % t = [t tStep'];
   % x = [x xStep'];
   % x0 = x(:,end);
%end
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
iLd_L2 = x(8);
iLq_L2 = x(9);
iLd_L16 = x(10);
iLq_L16 = x(11);
vTLLd_TL_2_23 = x(12);
vTLLq_TL_2_23 = x(13);
iTLMd_TL_2_23 = x(14);
iTLMq_TL_2_23 = x(15);
vTLRd_TL_2_23 = x(16);
vTLRq_TL_2_23 = x(17);
vTLLd_TL_1_2 = x(18);
vTLLq_TL_1_2 = x(19);
iTLMd_TL_1_2 = x(20);
iTLMq_TL_1_2 = x(21);
iTLMd_TL_1_5 = x(22);
iTLMq_TL_1_5 = x(23);
vTLRd_TL_1_5 = x(24);
vTLRq_TL_1_5 = x(25);
iTLMd_TL_5_16 = x(26);
iTLMq_TL_5_16 = x(27);
vTLRd_TL_5_16 = x(28);
vTLRq_TL_5_16 = x(29);
iTLMd_TL_5_21 = x(30);
iTLMq_TL_5_21 = x(31);
vTLRd_TL_5_21 = x(32);
vTLRq_TL_5_21 = x(33);
iLd_PV21 = x(34);
iLq_PV21 = x(35);
PInt_PV21 = x(36);
QInt_PV21 = x(37);

dphidt = 1; 
k=[5.8125   35.5171   -1.1682   -2.5449    1.3147    1.3279   -2.3964
   -3.5568   -9.1728   -3.9072    8.0164   -8.7656   -9.8039    1.4338];
reqd=[0.6192, 1.0, 0.8426, -0.5012, 1.19e-13, -1.484, 9.292e-14]';
Tm_G23=-(k(1,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+1.00;
    vR_G23=-(k(2,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+0.000641;
diSd_G23dt = 377*vTLRd_TL_2_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_2_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_2_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_2_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_2_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_2_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_2_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_2_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_2_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_2_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - Tm_G23 + iSd_G23*vTLRd_TL_2_23 + iSq_G23*vTLRq_TL_2_23)/(2*H_G23);
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLLd_TL_2_23 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLLq_TL_2_23 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - RL_L16*iLd_L16))/LL_L16;
diLq_L16dt = (377*(vTLRq_TL_5_16 - RL_L16*iLq_L16))/LL_L16 - 377*dphidt*iLd_L16;
dvTLLd_TL_2_23dt = (377*(iTLMd_TL_1_2 - iLd_L2 - iTLMd_TL_2_23 + CTL_TL_1_2*dphidt*vTLLq_TL_2_23 + CTL_TL_2_23*dphidt*vTLLq_TL_2_23))/(CTL_TL_1_2 + CTL_TL_2_23);
dvTLLq_TL_2_23dt = -(377*(iLq_L2 - iTLMq_TL_1_2 + iTLMq_TL_2_23 + CTL_TL_1_2*dphidt*vTLLd_TL_2_23 + CTL_TL_2_23*dphidt*vTLLd_TL_2_23))/(CTL_TL_1_2 + CTL_TL_2_23);
diTLMd_TL_2_23dt = 377*dphidt*iTLMq_TL_2_23 - (377*(vTLRd_TL_2_23 - vTLLd_TL_2_23 + RTL_TL_2_23*iTLMd_TL_2_23))/LTL_TL_2_23;
diTLMq_TL_2_23dt = - 377*dphidt*iTLMd_TL_2_23 - (377*(vTLRq_TL_2_23 - vTLLq_TL_2_23 + RTL_TL_2_23*iTLMq_TL_2_23))/LTL_TL_2_23;
dvTLRd_TL_2_23dt = (377*(iSd_G23 + iTLMd_TL_2_23))/CTL_TL_2_23 + 377*dphidt*vTLRq_TL_2_23;
dvTLRq_TL_2_23dt = (377*(iSq_G23 + iTLMq_TL_2_23))/CTL_TL_2_23 - 377*dphidt*vTLRd_TL_2_23;
dvTLLd_TL_1_2dt = -(377*(iTLMd_TL_1_2 + iTLMd_TL_1_5 - CTL_TL_1_2*dphidt*vTLLq_TL_1_2 - CTL_TL_1_5*dphidt*vTLLq_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_5);
dvTLLq_TL_1_2dt = -(377*(iTLMq_TL_1_2 + iTLMq_TL_1_5 + CTL_TL_1_2*dphidt*vTLLd_TL_1_2 + CTL_TL_1_5*dphidt*vTLLd_TL_1_2))/(CTL_TL_1_2 + CTL_TL_1_5);
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLLd_TL_2_23 - vTLLd_TL_1_2 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLLq_TL_2_23 - vTLLq_TL_1_2 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
diTLMd_TL_1_5dt = 377*dphidt*iTLMq_TL_1_5 - (377*(vTLRd_TL_1_5 - vTLLd_TL_1_2 + RTL_TL_1_5*iTLMd_TL_1_5))/LTL_TL_1_5;
diTLMq_TL_1_5dt = - 377*dphidt*iTLMd_TL_1_5 - (377*(vTLRq_TL_1_5 - vTLLq_TL_1_2 + RTL_TL_1_5*iTLMq_TL_1_5))/LTL_TL_1_5;
dvTLRd_TL_1_5dt = (377*(iTLMd_TL_1_5 - iTLMd_TL_5_16 - iTLMd_TL_5_21 + CTL_TL_1_5*dphidt*vTLRq_TL_1_5 + CTL_TL_5_16*dphidt*vTLRq_TL_1_5 + CTL_TL_5_21*dphidt*vTLRq_TL_1_5))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_21);
dvTLRq_TL_1_5dt = -(377*(iTLMq_TL_5_16 - iTLMq_TL_1_5 + iTLMq_TL_5_21 + CTL_TL_1_5*dphidt*vTLRd_TL_1_5 + CTL_TL_5_16*dphidt*vTLRd_TL_1_5 + CTL_TL_5_21*dphidt*vTLRd_TL_1_5))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_21);
diTLMd_TL_5_16dt = 377*dphidt*iTLMq_TL_5_16 - (377*(vTLRd_TL_5_16 - vTLRd_TL_1_5 + RTL_TL_5_16*iTLMd_TL_5_16))/LTL_TL_5_16;
diTLMq_TL_5_16dt = - 377*dphidt*iTLMd_TL_5_16 - (377*(vTLRq_TL_5_16 - vTLRq_TL_1_5 + RTL_TL_5_16*iTLMq_TL_5_16))/LTL_TL_5_16;
dvTLRd_TL_5_16dt = 377*dphidt*vTLRq_TL_5_16 - (377*(iLd_L16 - iTLMd_TL_5_16))/CTL_TL_5_16;
dvTLRq_TL_5_16dt = - 377*dphidt*vTLRd_TL_5_16 - (377*(iLq_L16 - iTLMq_TL_5_16))/CTL_TL_5_16;
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLRd_TL_1_5 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLRq_TL_1_5 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
diLd_PV21dt = 377*iLq_PV21 - (377*(vTLRd_TL_5_21 + RR_PV21*iLd_PV21 - cos(Kp1_PV21*((3*iLd_PV21*vTLRd_TL_5_21)/2 - Pref_PV21 + (3*iLq_PV21*vTLRq_TL_5_21)/2) - k1_PV21*sign(Pref_PV21 + PInt_PV21*c1_PV21 - (3*iLd_PV21*vTLRd_TL_5_21)/2 - (3*iLq_PV21*vTLRq_TL_5_21)/2) - Ki1_PV21*PInt_PV21)*((vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)*(Kp2_PV21*(Vref_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)) + Ki2_PV21*QInt_PV21 + 1) + k2_PV21*sign(Vref_PV21 + QInt_PV21*c2_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)))))/LR_PV21;
diLq_PV21dt = - 377*iLd_PV21 - (377*(vTLRq_TL_5_21 + RR_PV21*iLq_PV21 + sin(Kp1_PV21*((3*iLd_PV21*vTLRd_TL_5_21)/2 - Pref_PV21 + (3*iLq_PV21*vTLRq_TL_5_21)/2) - k1_PV21*sign(Pref_PV21 + PInt_PV21*c1_PV21 - (3*iLd_PV21*vTLRd_TL_5_21)/2 - (3*iLq_PV21*vTLRq_TL_5_21)/2) - Ki1_PV21*PInt_PV21)*((vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)*(Kp2_PV21*(Vref_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)) + Ki2_PV21*QInt_PV21 + 1) + k2_PV21*sign(Vref_PV21 + QInt_PV21*c2_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)))))/LR_PV21;
dPInt_PV21dt = 377*Pref_PV21 - (1131*iLd_PV21*vTLRd_TL_5_21)/2 - (1131*iLq_PV21*vTLRq_TL_5_21)/2;
dQInt_PV21dt = 377*Vref_PV21 - 377*(vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2);
dx = [diSd_G23dt
diSq_G23dt
diRd_G23dt
diRq_G23dt
diF_G23dt
ddelta_G23dt
domega_G23dt
diLd_L2dt
diLq_L2dt
diLd_L16dt
diLq_L16dt
dvTLLd_TL_2_23dt
dvTLLq_TL_2_23dt
diTLMd_TL_2_23dt
diTLMq_TL_2_23dt
dvTLRd_TL_2_23dt
dvTLRq_TL_2_23dt
dvTLLd_TL_1_2dt
dvTLLq_TL_1_2dt
diTLMd_TL_1_2dt
diTLMq_TL_1_2dt
diTLMd_TL_1_5dt
diTLMq_TL_1_5dt
dvTLRd_TL_1_5dt
dvTLRq_TL_1_5dt
diTLMd_TL_5_16dt
diTLMq_TL_5_16dt
dvTLRd_TL_5_16dt
dvTLRq_TL_5_16dt
diTLMd_TL_5_21dt
diTLMq_TL_5_21dt
dvTLRd_TL_5_21dt
dvTLRq_TL_5_21dt
diLd_PV21dt
diLq_PV21dt
dPInt_PV21dt
dQInt_PV21dt
];
end

iSd_G23 = x(:,1);
iSq_G23 = x(:,2);
iRd_G23 = x(:,3);
iRq_G23 = x(:,4);
iF_G23 = x(:,5);
delta_G23 = x(:,6);
omega_G23 = x(:,7);
iLd_L2 = x(:,8);
iLq_L2 = x(:,9);
iLd_L16 = x(:,10);
iLq_L16 = x(:,11);
vTLLd_TL_2_23 = x(:,12);
vTLLq_TL_2_23 = x(:,13);
iTLMd_TL_2_23 = x(:,14);
iTLMq_TL_2_23 = x(:,15);
vTLRd_TL_2_23 = x(:,16);
vTLRq_TL_2_23 = x(:,17);
vTLLd_TL_1_2 = x(:,18);
vTLLq_TL_1_2 = x(:,19);
iTLMd_TL_1_2 = x(:,20);
iTLMq_TL_1_2 = x(:,21);
iTLMd_TL_1_5 = x(:,22);
iTLMq_TL_1_5 = x(:,23);
vTLRd_TL_1_5 = x(:,24);
vTLRq_TL_1_5 = x(:,25);
iTLMd_TL_5_16 = x(:,26);
iTLMq_TL_5_16 = x(:,27);
vTLRd_TL_5_16 = x(:,28);
vTLRq_TL_5_16 = x(:,29);
iTLMd_TL_5_21 = x(:,30);
iTLMq_TL_5_21 = x(:,31);
vTLRd_TL_5_21 = x(:,32);
vTLRq_TL_5_21 = x(:,33);
iLd_PV21 = x(:,34);
iLq_PV21 = x(:,35);
PInt_PV21 = x(:,36);
QInt_PV21 = x(:,37);
save('DataPVTrial1.mat');

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

end