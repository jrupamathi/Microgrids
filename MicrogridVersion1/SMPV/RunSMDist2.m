function RunSMDist2
%works the best compared to others
clear all
close all

set(0,'defaultlinelinewidth',1.5)


addpath('../Parameters')
            
load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')
load('L2.mat', 'RL_L2', 'LL_L2');
load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
CTL = 0.01;
RTL = 0.0099;
LTL = 0.01;% + 0.004;

LTL_TL_2_23=LTL;
CTL_TL_2_23=1*CTL;
RTL_TL_2_23=RTL;
% RL_L3 = 100;
% LL_L3 = 0.100;
x0 = [0.3399    0.1524    0.0000   -0.0000   -0.7727    0.6846    1.0000    0.3541    0.1153];
% x0 = ones(9,1);

tic  
%for i = 1:numel(tauL_IM2Array)
    tspan = [0,0.024];
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
vTLRd_TL_2_23 = x(8);
vTLRq_TL_2_23 = x(9);

omega0 = omega_G23;

dphidt = omega_G23; 

k1=[1*0.6007   16.3410    0.1923   -0.0921   -0.3622   -0.2019    0.2416
    1*0.2005    7.7139    0.9844    0.4462   -1.1200   -1.9481    0.2620];
reqd1=[ -0.8637, 1.0, -0.5833, -0.1333, 1.2e-15, -1.04, -9.785e-17]';

%LQR Control for machine
Tm_G23=-(k1(1,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd1))+(-0.8618);%1.00;
vR_G23 = -(k1(2,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd1))+0.004491;%0.003729;

diSd_G23dt = 377*vTLRd_TL_2_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_2_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_2_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_2_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_2_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_2_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_2_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_2_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_2_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_2_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377*omega0;
domega_G23dt = -(- Tm_G23 + iSd_G23*vTLRd_TL_2_23 + iSq_G23*vTLRq_TL_2_23)/(2*H_G23);

Vd = vTLRd_TL_2_23; Vq = vTLRq_TL_2_23;
Vm = sqrt(Vd^2 + Vq^2); Vang = acot(Vq/Vd);
Id = iSd_G23; Iq = iSq_G23;
I_SM = sqrt(Id^2 + Iq^2); I_SMang = acot(Iq/Id);

vc = Vm*sin(omega0*t + Vang);
I = I_SM*sin(omega0*t + I_SMang);
dvcdt = omega0*Vm*cos(omega0*t + Vang);

l = 0.000; m = 0.000; n = 0.1379;
P = l*t*t + m*t + n;
dPdt = 2*l*t + m;

C = CTL_TL_2_23;
i_dis = P/vc;
di_disdt = (vc*dPdt - P*dvcdt)/(vc^2);

I_disM = i_dis^2 + (di_disdt/omega0)^2;
phi = acot(-di_disdt/(omega0*i_dis) - omega0*t);


iRd = I_disM*sin(omega0*t + phi);
iRq = I_disM*cos(omega0*t + phi);

dVddt = (377*(iSd_G23 - iRd))/CTL_TL_2_23 + 377*dphidt*Vq;
dVqdt = (377*(iSq_G23 - iRq))/CTL_TL_2_23 - 377*dphidt*Vd;

dx = [diSd_G23dt
diSq_G23dt
diRd_G23dt
diRq_G23dt
diF_G23dt
ddelta_G23dt
domega_G23dt
dVddt
dVqdt
];
end
iSd_G23 = x(:,1);
iSq_G23 = x(:,2);
iRd_G23 = x(:,3);
iRq_G23 = x(:,4);
iF_G23 = x(:,5);
delta_G23 = x(:,6);
omega_G23 = x(:,7);
vTLRd_TL_2_23 = x(:,8);
vTLRq_TL_2_23 = x(:,9);
% iLd_L3 = x(:,16);
% iLq_L3 = x(:,17);

save('DataSMDist.mat')
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
plot(t,vTLRd_TL_2_23,'b',t,vTLRq_TL_2_23,'r',t,vTLRd_TL_2_23,'b--',t,vTLRq_TL_2_23,'r--');
title('Voltages ');
legend('V1d','V1q','V2d','V2q');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

% figure(4);
% plot(t,iLd_L2,'b',t,iLq_L2,'r');
% title('Currents of L2');
% legend('Id','Iq');
% xlabel('Time in seconds');
% ylabel('Currents (in p.u)');

end