%%
%Case 1:No adjustments
%Gen23 steady state
x230s = [0.1826; -0.08598;  2.184e-16; -5.97e-15;-0.556;0.2686; 1.0];
Tm230s = 0.1964; vf230s = 0.001145;

x230u = [ 0.1826; -0.08598; -2.184e-16; 5.97e-15; 0.556;-2.873; 1.0];
Tm230u = 0.1964; vf230u = -0.001145;

%Gen22 steady state
x220s = [ 0.4868; -0.6925; 3.02e-16; -6.345e-15;  -1.254;0.3596;1.0;];
Tm220s = 0.5179; vf220s=0.002583;

x220u = [0.4868;-0.6925;-3.02e-16; 6.345e-15;1.254;-2.782;1.0;];
Tm0u = 0.5179; vf0u = -0.002583;

%%
%Loads steady state
addpath('../Parameters/')
load('L1.mat', 'RL_L1', 'LL_L1');
load('L21.mat', 'RL_L21', 'LL_L21');
load('L22.mat', 'RL_L22', 'LL_L22');
load('L23.mat', 'RL_L23', 'LL_L23');
load('PV21.mat', 'RL_PV21', 'LL_PV21');

filename = 'Case1_islndnoadjshunt14v95105_yesangles.txt';
file1 = load(filename,'variable');
Buses = [1;21;22;23];
% LL_PV21 = -0.3;

%Reduced Network Load impedances
Zsh = [RL_L1+1i*LL_L1; RL_L21+1i*LL_L21; RL_L22+1i*LL_L22; RL_L23+1i*LL_L23];
Vmag = file1(Buses,3);
Vang = file1(Buses,4).*pi/180;
Vdref = Vmag.*cos(Vang);
Vqref = Vmag.*sin(Vang);

vd = Vdref;vq=Vqref; % From Load flow
I=(Vdref + 1i*Vqref)./(Zsh);

Is0 = zeros(8,1);
Is0(1:2:end) = [real(I)];
Is0(2:2:end) = [imag(I)];
iPV = (Vdref(2) + 1i*Vqref(2))/(RL_PV21 + 1i*LL_PV21);
Is0 = [Is0; real(iPV); imag(iPV)];
%%

% generator parameters

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','Rkq_G23','RF_G23','H_G23','B_G23',...
    'K11_G23','K12_G23','K26_G23');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','Rkq_G22','RF_G22','H_G22','B_G22',...
    'K11_G22','K12_G22','K26_G22');

load('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
load('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
load('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

dphidt = 1;

I1_21 = (Vdref(1)+Vqref(1)-Vdref(2)-Vqref(2))/(RTL_TL_1_21 + 1i*LTL_TL_1_21);
I1_22 = (Vdref(1)+Vqref(1)-Vdref(3)-Vqref(3))/(RTL_TL_1_22 + 1i*LTL_TL_1_22);
I1_23 = (Vdref(1)+Vqref(1)-Vdref(4)-Vqref(4))/(RTL_TL_1_23 + 1i*LTL_TL_1_23);

x0 = [x220s; x230s
    Is0(1:end-2);
    Vdref(1); Vqref(1); real(I1_21); imag(I1_21); Vdref(2); Vqref(2); 
    real(I1_22); imag(I1_22); Vdref(3); Vqref(3);
    real(I1_23); imag(I1_23); Vdref(4); Vqref(4);
    Is0(end-1:end);
    ];

syms delta_G22 omega_G22 iSd_G22 iSq_G22 iRd_G22 iF_G22 iRq_G22...
delta_G23 omega_G23 iSd_G23 iSq_G23 iRd_G23 iF_G23 iRq_G23 ...
iLd_L1 iLq_L1 iLd_L21 iLq_L21 iLd_L22  iLq_L22  iLd_L23 iLq_L23...
vTLLd_TL_1_21 vTLLq_TL_1_21 iTLMd_TL_1_21 iTLMq_TL_1_21 vTLRd_TL_1_21 vTLRq_TL_1_21 ...
iTLMd_TL_1_22 iTLMq_TL_1_22 vTLRd_TL_1_22  vTLRq_TL_1_22 iTLMd_TL_1_23 iTLMq_TL_1_23 ...
vTLRd_TL_1_23 vTLRq_TL_1_23 iLd_PV21 iLq_PV21 iLdInt iLqInt real 

x = [iSd_G22; iSq_G22; iRd_G22; iRq_G22 ;iF_G22 ;delta_G22 ;omega_G22 ;
iSd_G23 ;iSq_G23 ;iRd_G23 ;iRq_G23 ;iF_G23 ;delta_G23 ;omega_G23;
iLd_L1; iLq_L1 ;iLd_L21 ;iLq_L21 ;iLd_L22  ;iLq_L22  ;iLd_L23 ;iLq_L23;
vTLLd_TL_1_21; vTLLq_TL_1_21 ;iTLMd_TL_1_21 ;iTLMq_TL_1_21 ;vTLRd_TL_1_21 ;vTLRq_TL_1_21 ;
iTLMd_TL_1_22; iTLMq_TL_1_22; vTLRd_TL_1_22;  vTLRq_TL_1_22 ;iTLMd_TL_1_23 ;iTLMq_TL_1_23 ;
vTLRd_TL_1_23 ;vTLRq_TL_1_23;iLd_PV21 ;iLq_PV21 ];% tauL_G23; vR_G23; tauL_G22; vR_G22];
% u = [tauL_G23; vR_G23; tauL_G22; vR_G22];
% uref = [tauL_G23_ref; vR_G23_ref; tauL_G22_ref; vR_G22_ref];
tauL_G22 = Tm220s - K11_G22*(delta_G22 - x220s(end-1)) - K12_G22*(omega_G22 - x220s(end));
vR_G22 = vf220s - K26_G22*(iF_G22 - x220s(end-2));% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
% vR_G22 = vR_G22_ref - K26_G22*(sqrt(vTLRd_TL_1_22^2+vTLRq_TL_1_22^2) - 0.95*1.2);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
tauL_G23 = Tm230s - K11_G23*(delta_G23 - x230s(end-1)) - K12_G23*(omega_G23 - x230s(end));
vR_G23 = vf230s - K26_G23*(iF_G23 - x230s(end-2));% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
% vR_G23 = vR_G23_ref - K26_G23*(sqrt(vTLRd_TL_1_23^2+vTLRq_TL_1_23^2) - 0.95*1.1);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
diSd_G22dt = 377*vTLRd_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_1_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_1_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLRd_TL_1_22 + iSq_G22*vTLRq_TL_1_22)/(2*H_G22);
diSd_G23dt = 377*vTLRd_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((Rkd_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iSq_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRq_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRq_G23*((Laq_G23*Rkq_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*vTLRq_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + 377*iRd_G23*((Rkd_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iSd_G23*(omega_G23 + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 1) + 377*vTLRd_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*Rkq_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*Rkd_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLRd_TL_1_23 + iSq_G23*vTLRq_TL_1_23)/(2*H_G23);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLLd_TL_1_21 - RL_L1*iLd_L1))/LL_L1;
diLq_L1dt = (377*(vTLLq_TL_1_21 - RL_L1*iLq_L1))/LL_L1 - 377*dphidt*iLd_L1;
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLRd_TL_1_21 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLRq_TL_1_21 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
diLd_L22dt = 377*dphidt*iLq_L22 + (377*(vTLRd_TL_1_22 - RL_L22*iLd_L22))/LL_L22;
diLq_L22dt = (377*(vTLRq_TL_1_22 - RL_L22*iLq_L22))/LL_L22 - 377*dphidt*iLd_L22;
diLd_L23dt = 377*dphidt*iLq_L23 + (377*(vTLRd_TL_1_23 - RL_L23*iLd_L23))/LL_L23;
diLq_L23dt = (377*(vTLRq_TL_1_23 - RL_L23*iLq_L23))/LL_L23 - 377*dphidt*iLd_L23;
dvTLLd_TL_1_21dt = -(377*(iLd_L1 + iTLMd_TL_1_21 + iTLMd_TL_1_22 + iTLMd_TL_1_23 - CTL_TL_1_21*dphidt*vTLLq_TL_1_21 - CTL_TL_1_22*dphidt*vTLLq_TL_1_21 - CTL_TL_1_23*dphidt*vTLLq_TL_1_21))/(CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
dvTLLq_TL_1_21dt = -(377*(iLq_L1 + iTLMq_TL_1_21 + iTLMq_TL_1_22 + iTLMq_TL_1_23 + CTL_TL_1_21*dphidt*vTLLd_TL_1_21 + CTL_TL_1_22*dphidt*vTLLd_TL_1_21 + CTL_TL_1_23*dphidt*vTLLd_TL_1_21))/(CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
diTLMd_TL_1_21dt = 377*dphidt*iTLMq_TL_1_21 - (377*(vTLRd_TL_1_21 - vTLLd_TL_1_21 + RTL_TL_1_21*iTLMd_TL_1_21))/LTL_TL_1_21;
diTLMq_TL_1_21dt = - 377*dphidt*iTLMd_TL_1_21 - (377*(vTLRq_TL_1_21 - vTLLq_TL_1_21 + RTL_TL_1_21*iTLMq_TL_1_21))/LTL_TL_1_21;
dvTLRd_TL_1_21dt = 377*dphidt*vTLRq_TL_1_21 - (377*(iLd_L21 + iLd_PV21 - iTLMd_TL_1_21))/CTL_TL_1_21;
dvTLRq_TL_1_21dt = - 377*dphidt*vTLRd_TL_1_21 - (377*(iLq_L21 + iLq_PV21 - iTLMq_TL_1_21))/CTL_TL_1_21;
diTLMd_TL_1_22dt = 377*dphidt*iTLMq_TL_1_22 - (377*(vTLRd_TL_1_22 - vTLLd_TL_1_21 + RTL_TL_1_22*iTLMd_TL_1_22))/LTL_TL_1_22;
diTLMq_TL_1_22dt = - 377*dphidt*iTLMd_TL_1_22 - (377*(vTLRq_TL_1_22 - vTLLq_TL_1_21 + RTL_TL_1_22*iTLMq_TL_1_22))/LTL_TL_1_22;
dvTLRd_TL_1_22dt = 377*dphidt*vTLRq_TL_1_22 + (377*(iSd_G22 - iLd_L22 + iTLMd_TL_1_22))/CTL_TL_1_22;
dvTLRq_TL_1_22dt = (377*(iSq_G22 - iLq_L22 + iTLMq_TL_1_22))/CTL_TL_1_22 - 377*dphidt*vTLRd_TL_1_22;
diTLMd_TL_1_23dt = 377*dphidt*iTLMq_TL_1_23 - (377*(vTLRd_TL_1_23 - vTLLd_TL_1_21 + RTL_TL_1_23*iTLMd_TL_1_23))/LTL_TL_1_23;
diTLMq_TL_1_23dt = - 377*dphidt*iTLMd_TL_1_23 - (377*(vTLRq_TL_1_23 - vTLLq_TL_1_21 + RTL_TL_1_23*iTLMq_TL_1_23))/LTL_TL_1_23;
dvTLRd_TL_1_23dt = 377*dphidt*vTLRq_TL_1_23 + (377*(iSd_G23 - iLd_L23 + iTLMd_TL_1_23))/CTL_TL_1_23;
dvTLRq_TL_1_23dt = (377*(iSq_G23 - iLq_L23 + iTLMq_TL_1_23))/CTL_TL_1_23 - 377*dphidt*vTLRd_TL_1_23;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_1_21 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLRq_TL_1_21 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;
% diLd_PV21dt = -(iLd_PV21 - idref)-0.1*iLdInt;%377*dphidt*iLq_PV21 + (377*(vTLRd_TL_1_21 - RL_PV21*iLd_PV21))/LL_PV21;
% diLq_PV21dt = -(iLq_PV21 - iqref)-0.1*iLqInt;%(377*(vTLRq_TL_1_21 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;
% diLdIntdt = (iLd_PV21 - idref);
% diLqIntdt = (iLq_PV21 - iqref);

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
diLd_L21dt
diLq_L21dt
diLd_L22dt
diLq_L22dt
diLd_L23dt
diLq_L23dt
dvTLLd_TL_1_21dt
dvTLLq_TL_1_21dt
diTLMd_TL_1_21dt
diTLMq_TL_1_21dt
dvTLRd_TL_1_21dt
dvTLRq_TL_1_21dt
diTLMd_TL_1_22dt
diTLMq_TL_1_22dt
dvTLRd_TL_1_22dt
dvTLRq_TL_1_22dt
diTLMd_TL_1_23dt
diTLMq_TL_1_23dt
dvTLRd_TL_1_23dt
dvTLRq_TL_1_23dt
diLd_PV21dt
diLq_PV21dt
];


A = jacobian(dx,x);
A1 = vpa(subs(A,x,x0),4);
eig(A1)