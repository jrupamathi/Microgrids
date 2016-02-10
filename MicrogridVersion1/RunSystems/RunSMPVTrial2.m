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


x0=[1.01;0.1;1.001; 0.1; 1.1; 0.1;1.1; 0.3; 1.12;0.02;0.01;0.01];
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
iLd_L2 = -0.74/4;%x(1);
iLq_L2 = 0;%x(2);
vTLLd_TL_5_21 = x(3);
vTLLq_TL_5_21 = x(4);
iTLMd_TL_5_21 = x(5);
iTLMq_TL_5_21 = x(6);
vTLRd_TL_5_21 = x(7);
vTLRq_TL_5_21 = x(8);
iLd_PV21 = x(9);
iLq_PV21 = x(10);
PInt_PV21 = x(11);
QInt_PV21 = x(12);

dphidt = 1; 
diLd_L2dt = 0;%377*dphidt*iLq_L2 + (377*(vTLLd_TL_5_21 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = 0;%(377*(vTLLq_TL_5_21 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
dvTLLd_TL_5_21dt = 377*dphidt*vTLLq_TL_5_21 - (377*(iLd_L2 + iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLLq_TL_5_21dt = - (377*(iLq_L2 + iTLMq_TL_5_21))/CTL_TL_5_21 - 377*dphidt*vTLLd_TL_5_21;
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLLd_TL_5_21 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLLq_TL_5_21 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
diLd_PV21dt = 377*iLq_PV21 - (377*(vTLRd_TL_5_21 + RR_PV21*iLd_PV21 - cos(Kp1_PV21*((3*iLd_PV21*vTLRd_TL_5_21)/2 - Pref_PV21 + (3*iLq_PV21*vTLRq_TL_5_21)/2) - k1_PV21*sign(Pref_PV21 + PInt_PV21*c1_PV21 - (3*iLd_PV21*vTLRd_TL_5_21)/2 - (3*iLq_PV21*vTLRq_TL_5_21)/2) - Ki1_PV21*PInt_PV21)*((vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)*(Kp2_PV21*(Vref_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)) + Ki2_PV21*QInt_PV21 + 1) + k2_PV21*sign(Vref_PV21 + QInt_PV21*c2_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)))))/LR_PV21;
diLq_PV21dt = - 377*iLd_PV21 - (377*(vTLRq_TL_5_21 + RR_PV21*iLq_PV21 + sin(Kp1_PV21*((3*iLd_PV21*vTLRd_TL_5_21)/2 - Pref_PV21 + (3*iLq_PV21*vTLRq_TL_5_21)/2) - k1_PV21*sign(Pref_PV21 + PInt_PV21*c1_PV21 - (3*iLd_PV21*vTLRd_TL_5_21)/2 - (3*iLq_PV21*vTLRq_TL_5_21)/2) - Ki1_PV21*PInt_PV21)*((vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)*(Kp2_PV21*(Vref_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)) + Ki2_PV21*QInt_PV21 + 1) + k2_PV21*sign(Vref_PV21 + QInt_PV21*c2_PV21 - (vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2)))))/LR_PV21;
dPInt_PV21dt = 377*Pref_PV21 - (1131*iLd_PV21*vTLRd_TL_5_21)/2 - (1131*iLq_PV21*vTLRq_TL_5_21)/2;
dQInt_PV21dt = 377*Vref_PV21 - 377*(vTLRd_TL_5_21^2 + vTLRq_TL_5_21^2)^(1/2);
dx = [diLd_L2dt
diLq_L2dt
dvTLLd_TL_5_21dt
dvTLLq_TL_5_21dt
diTLMd_TL_5_21dt
diTLMq_TL_5_21dt
dvTLRd_TL_5_21dt
dvTLRq_TL_5_21dt
diLd_PV21dt
diLq_PV21dt
dPInt_PV21dt
dQInt_PV21dt
];
plot(t,x(end-1),'b*',t,x(end),'r*')
end

save('PVTrial2.mat')
end