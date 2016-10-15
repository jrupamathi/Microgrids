%%
%9/23/16
%Gen22 steady state
x220s = [
      0.055
     -0.065
  5.813e-17
 -7.109e-16
     -0.4951
 0.08653
        1.0
 ];
Tm220s = 0.06423; vf220s = 0.00102;

%Gen23 steady state
x230s = [
     0.2415
     0.1226
 -9.849e-15
 -4.425e-15
 -0.4431
 0.5041
        1.0];
Tm230s = 0.2632; vf230s=0.00144;

%%
%Loads steady state
addpath('../Parameters/')
load('L1.mat', 'RL_L1', 'LL_L1');
load('L20.mat', 'RL_L20', 'LL_L20');
load('L21.mat', 'RL_L21', 'LL_L21');
load('L22.mat', 'RL_L22', 'LL_L22');
load('L23.mat', 'RL_L23', 'LL_L23');
load('PV21.mat', 'RL_PV21', 'LL_PV21');

filename = 'Case2_WithBatHighPV.txt';
file1 = load(filename,'variable');
Buses = [1;20;21;22;23];
% LL_PV21 = -0.7;
% RL_PV21 = -4.635; LL_PV21 = -1.9776;

%Reduced Network Load impedances
Zsh = [RL_L1+1i*LL_L1; RL_L20+1i*LL_L20;RL_L21+1i*LL_L21; RL_L22+1i*LL_L22; RL_L23+1i*LL_L23];
Vmag = [1.003;1.015;1.012;1;1.02];
Vang = [0.191;4.683;5.963;0;1.927].*pi/180;
Vdref = Vmag.*cos(Vang);
Vqref = Vmag.*sin(Vang);

vd = Vdref;vq=Vqref; % From Load flow
IL=(Vdref + 1i*Vqref)./(Zsh);

Is0 = zeros(10,1);
Is0(1:2:end) = [real(IL)];
Is0(2:2:end) = [imag(IL)];
iPV = (Vdref(3) + 1i*Vqref(3))/(RL_PV21 + 1i*LL_PV21);
iBat = iPV/2;
Is0 = [Is0;real(iBat);-imag(iBat); real(iPV); imag(iPV)];
%%

% generator parameters

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

load('TL_1_20.mat', 'LTL_TL_1_20', 'RTL_TL_1_20','CTL_TL_1_20');
load('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
load('TL_20_21.mat', 'LTL_TL_20_21', 'RTL_TL_20_21','CTL_TL_20_21');
load('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
load('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

dphidt = 1;

I1_20 = (Vdref(1)+Vqref(1)-Vdref(2)-Vqref(2))/(RTL_TL_1_20 + 1i*LTL_TL_1_20);
I1_21 = (Vdref(1)+Vqref(1)-Vdref(3)-Vqref(3))/(RTL_TL_1_21 + 1i*LTL_TL_1_21);
I1_22 = (Vdref(1)+Vqref(1)-Vdref(4)-Vqref(4))/(RTL_TL_1_22 + 1i*LTL_TL_1_22);
I1_23 = (Vdref(1)+Vqref(1)-Vdref(5)-Vqref(5))/(RTL_TL_1_23 + 1i*LTL_TL_1_23);
I20_21 = (Vdref(2)+Vqref(2)-Vdref(3)-Vqref(3))/(RTL_TL_20_21 + 1i*LTL_TL_20_21);

x0 = [Is0(end-3:end);x220s; x230s;
    Is0(1:end-4);
    Vdref(1); Vqref(1); real(I1_20); imag(I1_20); Vdref(2); Vqref(2); 
    real(I1_21); imag(I1_21); Vdref(3); Vqref(3);
    real(I20_21); imag(I20_21); 
    real(I1_22); imag(I1_22); Vdref(4); Vqref(4);
    real(I1_23); imag(I1_23); Vdref(5); Vqref(5);
    8038;1.43
    ];
x0(1) 
ueq = [Tm220s; vf220s; Tm230s; vf230s ];
syms delta_G22 omega_G22 iSd_G22 iSq_G22 iRd_G22 iF_G22 iRq_G22...
delta_G23 omega_G23 iSd_G23 iSq_G23 iRd_G23 iF_G23 iRq_G23 ...
iLd_L1 iLq_L1 iLd_L21 iLq_L21 iLd_L22  iLq_L22  iLd_L23 iLq_L23...
vTLLd_TL_1_21 vTLLq_TL_1_21 iTLMd_TL_1_21 iTLMq_TL_1_21 vTLRd_TL_1_21 vTLRq_TL_1_21 ...
iTLMd_TL_1_22 iTLMq_TL_1_22 vTLRd_TL_1_22  vTLRq_TL_1_22 iTLMd_TL_1_23 iTLMq_TL_1_23 ...
vTLRd_TL_1_23 vTLRq_TL_1_23 iPVd_PV21 iPVq_PV21 iLdInt iLqInt real 

syms iPVd_B20 iPVq_B20 iLd_L20 iLq_L20 vTLLd_TL_1_20 vTLLq_TL_1_20...
    iTLMd_TL_1_20 iTLMq_TL_1_20 vTLRd_TL_1_20 vTLRq_TL_1_20 ...
    iTLMd_TL_20_21 iTLMq_TL_20_21 Vs Vs_Bat real
syms tauL_G22 vR_G22 tauL_G23 vR_G23 real
x = [iPVd_B20; iPVq_B20; iPVd_PV21; iPVq_PV21; iSd_G22; iSq_G22;...
iRd_G22; iRq_G22; iF_G22; delta_G22; omega_G22; iSd_G23; iSq_G23; ...
iRd_G23; iRq_G23; iF_G23;delta_G23;omega_G23;iLd_L1;iLq_L1;...
iLd_L20;iLq_L20;iLd_L21;iLq_L21;iLd_L22;iLq_L22;iLd_L23;iLq_L23;...
vTLLd_TL_1_20;vTLLq_TL_1_20 ;iTLMd_TL_1_20;iTLMq_TL_1_20 ;...
vTLRd_TL_1_20 ;vTLRq_TL_1_20;iTLMd_TL_1_21 ;iTLMq_TL_1_21;...
vTLRd_TL_1_21 ;vTLRq_TL_1_21 ;iTLMd_TL_20_21;iTLMq_TL_20_21 ;
iTLMd_TL_1_22;iTLMq_TL_1_22;vTLRd_TL_1_22;vTLRq_TL_1_22 ;...
iTLMd_TL_1_23 ;iTLMq_TL_1_23 ;vTLRd_TL_1_23 ;vTLRq_TL_1_23 ; ...
Vs; Vs_Bat];
u = [tauL_G23; vR_G23; tauL_G22; vR_G22];

RL_B20 = 2*RL_PV21; LL_B20 = -2*LL_PV21;
Rkd_G22 = RR_G22; Rkq_G22 = RR_G22; Rkd_G23 = RR_G23; Rkq_G23 = RR_G23;
% vR_G23 = vR_G23_ref - K26_G23*(sqrt(vTLRd_TL_1_23^2+vTLRq_TL_1_23^2) - 0.95*1.1);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
iDC = 0.9773;
Zbase = 2.4^2/4;

RPV = 0.01/Zbase;
LPV = 3.6e-3*377/Zbase;
CPV = (1/(377*0.02))/Zbase;
P = 0.875; Q = 0.7;

vd = vTLRd_TL_1_21; vq = vTLRq_TL_1_21;
id_star = (P*vd + Q*vq)/(vd^2 + vq^2);
iq_star = (P*vq - Q*vd)/(vd^2 + vq^2);
id = iPVd_PV21;
iq = iPVq_PV21;

            ud = ((-RPV*id_star +vd) + dphidt*LPV*iq_star)/Vs;
            uq = ((-RPV*iq_star +vq)  - dphidt*LPV*id_star)/Vs;
% id = iPVd_PV21; iq = iPVq_PV21;
% id_star = 0.67; iq_star = -0.62;
%PV Dynamics
            diPVd_PV21dt = -377*RPV/LPV*(id-id_star);%377*(dphidt*iq - (RPV*id - vd + (Vs*ud))/LPV);
            diPVq_PV21dt = -377*RPV/LPV*(iq-iq_star);%377*(-dphidt*id - (RPV*iq -vq + (Vs*uq))/LPV);
            dVsdt = 377*( -(id*ud + iq*uq)/(1*CPV) + iDC/CPV - Vs/(100*RPV));
V0 = 1.4434; ESR =0.0208; 
iDC = (V0-Vs_Bat)/(ESR);
Zbase = 2.4^2/4;

RBat = 0.01/Zbase;
LBat = 3.6e-3*377/Zbase;
CBat = (1/(377*0.02))/Zbase;
% syms PBat QBat real
% P = PBat; Q = QBat;
P = 1.75/4; Q = 1.4/4;

vd = vTLRd_TL_1_20; vq = vTLRq_TL_1_20;
id_star = (P*vd + Q*vq)/(vd^2 + vq^2);
iq_star = (P*vq - Q*vd)/(vd^2 + vq^2);
id = iPVd_B20;
iq = iPVq_B20;

            ud = ((-RBat*id_star +vd) + dphidt*LBat*iq_star)/Vs_Bat;
            uq = ((-RBat*iq_star +vq)  - dphidt*LBat*id_star)/Vs_Bat;
% id = iPVd_PV21; iq = iPVq_PV21;
% id_star = 0.67; iq_star = -0.62;

%PV Dynamics
            diPVd_B20dt = -377*RPV/LPV*(id-id_star);%377*(dphidt*iq - (RPV*id - vd + (Vs*ud))/LPV);
            diPVq_B20dt = -377*RPV/LPV*(iq-iq_star);%377*(-dphidt*id - (RPV*iq -vq + (Vs*uq))/LPV);
            dVs_Batdt = 377*( -(id*ud + iq*uq)/(1*CPV) + iDC/CPV - Vs/(100*RBat));

% tauL_G22 = Tm220s;% - K1_G22*(delta_G22 - x220s(end-1)) - K2_G22*(omega_G22 - x220s(end));
% vR_G22 = vf220s - 0.2*K3_G22*(iF_G22 - x220s(end-2));% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
% % vR_G22 = vR_G22_ref - K26_G22*(sqrt(vTLRd_TL_1_22^2+vTLRq_TL_1_22^2) - 0.95*1.2);% - K25_G22*(iRd_G22 - iRd_G22_ref) - K27_G22*(iRq_G22 - iRq_G22_ref) - K23_G22*(iSd_G22 - iSd_G22_ref) - K24_G22*(iSq_G22 - iSq_G22_ref) - K22_G22*(omega_G22 - omega_G22_ref);
% tauL_G23 = Tm230s;% - K1_G23*(delta_G23 - x230s(end-1)) - K2_G23*(omega_G23 - x230s(end));
% vR_G23 = vf230s - 0.3*K3_G23*(iF_G23 - x230s(end-2));% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);

            diSd_G22dt = 377*vTLRd_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*RR_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((RR_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLRq_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iSd_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iRq_G22*((Laq_G22*RR_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*vTLRq_TL_1_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iRd_G22*((RR_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLRd_TL_1_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*RR_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_1_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_1_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_1_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_1_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - tauL_G22 + iSd_G22*vTLRd_TL_1_22 + iSq_G22*vTLRq_TL_1_22)/(2*H_G22);
diSd_G23dt = 377*vTLRd_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_1_23*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_1_23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - tauL_G23 + iSd_G23*vTLRd_TL_1_23 + iSq_G23*vTLRq_TL_1_23)/(2*H_G23);
diLd_L1dt = 377*dphidt*iLq_L1 + (377*(vTLLd_TL_1_20 - RL_L1*iLd_L1))/LL_L1;
diLq_L1dt = (377*(vTLLq_TL_1_20 - RL_L1*iLq_L1))/LL_L1 - 377*dphidt*iLd_L1;
diLd_L20dt = 377*dphidt*iLq_L20 + (377*(vTLRd_TL_1_20 - RL_L20*iLd_L20))/LL_L20;
diLq_L20dt = (377*(vTLRq_TL_1_20 - RL_L20*iLq_L20))/LL_L20 - 377*dphidt*iLd_L20;
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLRd_TL_1_21 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLRq_TL_1_21 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
diLd_L22dt = 377*dphidt*iLq_L22 + (377*(vTLRd_TL_1_22 - RL_L22*iLd_L22))/LL_L22;
diLq_L22dt = (377*(vTLRq_TL_1_22 - RL_L22*iLq_L22))/LL_L22 - 377*dphidt*iLd_L22;
diLd_L23dt = 377*dphidt*iLq_L23 + (377*(vTLRd_TL_1_23 - RL_L23*iLd_L23))/LL_L23;
diLq_L23dt = (377*(vTLRq_TL_1_23 - RL_L23*iLq_L23))/LL_L23 - 377*dphidt*iLd_L23;
dvTLLd_TL_1_20dt = -(377*(iLd_L1 + iTLMd_TL_1_20 + iTLMd_TL_1_21 + iTLMd_TL_1_22 + iTLMd_TL_1_23 - CTL_TL_1_20*dphidt*vTLLq_TL_1_20 - CTL_TL_1_21*dphidt*vTLLq_TL_1_20 - CTL_TL_1_22*dphidt*vTLLq_TL_1_20 - CTL_TL_1_23*dphidt*vTLLq_TL_1_20))/(CTL_TL_1_20 + CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
dvTLLq_TL_1_20dt = -(377*(iLq_L1 + iTLMq_TL_1_20 + iTLMq_TL_1_21 + iTLMq_TL_1_22 + iTLMq_TL_1_23 + CTL_TL_1_20*dphidt*vTLLd_TL_1_20 + CTL_TL_1_21*dphidt*vTLLd_TL_1_20 + CTL_TL_1_22*dphidt*vTLLd_TL_1_20 + CTL_TL_1_23*dphidt*vTLLd_TL_1_20))/(CTL_TL_1_20 + CTL_TL_1_21 + CTL_TL_1_22 + CTL_TL_1_23);
diTLMd_TL_1_20dt = 377*dphidt*iTLMq_TL_1_20 - (377*(vTLRd_TL_1_20 - vTLLd_TL_1_20 + RTL_TL_1_20*iTLMd_TL_1_20))/LTL_TL_1_20;
diTLMq_TL_1_20dt = - 377*dphidt*iTLMd_TL_1_20 - (377*(vTLRq_TL_1_20 - vTLLq_TL_1_20 + RTL_TL_1_20*iTLMq_TL_1_20))/LTL_TL_1_20;
dvTLRd_TL_1_20dt = -(377*(iLd_L20 - iPVd_B20 - iTLMd_TL_1_20 + iTLMd_TL_20_21 - CTL_TL_1_20*dphidt*vTLRq_TL_1_20 - CTL_TL_20_21*dphidt*vTLRq_TL_1_20))/(CTL_TL_1_20 + CTL_TL_20_21);
dvTLRq_TL_1_20dt = -(377*(iLq_L20 - iPVq_B20 - iTLMq_TL_1_20 + iTLMq_TL_20_21 + CTL_TL_1_20*dphidt*vTLRd_TL_1_20 + CTL_TL_20_21*dphidt*vTLRd_TL_1_20))/(CTL_TL_1_20 + CTL_TL_20_21);
diTLMd_TL_1_21dt = 377*dphidt*iTLMq_TL_1_21 - (377*(vTLRd_TL_1_21 - vTLLd_TL_1_20 + RTL_TL_1_21*iTLMd_TL_1_21))/LTL_TL_1_21;
diTLMq_TL_1_21dt = - 377*dphidt*iTLMd_TL_1_21 - (377*(vTLRq_TL_1_21 - vTLLq_TL_1_20 + RTL_TL_1_21*iTLMq_TL_1_21))/LTL_TL_1_21;
dvTLRd_TL_1_21dt = (377*(iTLMd_TL_1_21 + iPVd_PV21 - iLd_L21 + iTLMd_TL_20_21 + CTL_TL_1_21*dphidt*vTLRq_TL_1_21 + CTL_TL_20_21*dphidt*vTLRq_TL_1_21))/(CTL_TL_1_21 + CTL_TL_20_21);
dvTLRq_TL_1_21dt = -(377*(iLq_L21 - iPVq_PV21 - iTLMq_TL_1_21 - iTLMq_TL_20_21 + CTL_TL_1_21*dphidt*vTLRd_TL_1_21 + CTL_TL_20_21*dphidt*vTLRd_TL_1_21))/(CTL_TL_1_21 + CTL_TL_20_21);
diTLMd_TL_20_21dt = 377*dphidt*iTLMq_TL_20_21 - (377*(vTLRd_TL_1_21 - vTLRd_TL_1_20 + RTL_TL_20_21*iTLMd_TL_20_21))/LTL_TL_20_21;
diTLMq_TL_20_21dt = - 377*dphidt*iTLMd_TL_20_21 - (377*(vTLRq_TL_1_21 - vTLRq_TL_1_20 + RTL_TL_20_21*iTLMq_TL_20_21))/LTL_TL_20_21;
diTLMd_TL_1_22dt = 377*dphidt*iTLMq_TL_1_22 - (377*(vTLRd_TL_1_22 - vTLLd_TL_1_20 + RTL_TL_1_22*iTLMd_TL_1_22))/LTL_TL_1_22;
diTLMq_TL_1_22dt = - 377*dphidt*iTLMd_TL_1_22 - (377*(vTLRq_TL_1_22 - vTLLq_TL_1_20 + RTL_TL_1_22*iTLMq_TL_1_22))/LTL_TL_1_22;
dvTLRd_TL_1_22dt = 377*dphidt*vTLRq_TL_1_22 + (377*(iSd_G22 - iLd_L22 + iTLMd_TL_1_22))/CTL_TL_1_22;
dvTLRq_TL_1_22dt = (377*(iSq_G22 - iLq_L22 + iTLMq_TL_1_22))/CTL_TL_1_22 - 377*dphidt*vTLRd_TL_1_22;
diTLMd_TL_1_23dt = 377*dphidt*iTLMq_TL_1_23 - (377*(vTLRd_TL_1_23 - vTLLd_TL_1_20 + RTL_TL_1_23*iTLMd_TL_1_23))/LTL_TL_1_23;
diTLMq_TL_1_23dt = - 377*dphidt*iTLMd_TL_1_23 - (377*(vTLRq_TL_1_23 - vTLLq_TL_1_20 + RTL_TL_1_23*iTLMq_TL_1_23))/LTL_TL_1_23;
dvTLRd_TL_1_23dt = 377*dphidt*vTLRq_TL_1_23 + (377*(iSd_G23 - iLd_L23 + iTLMd_TL_1_23))/CTL_TL_1_23;
dvTLRq_TL_1_23dt = (377*(iSq_G23 - iLq_L23 + iTLMq_TL_1_23))/CTL_TL_1_23 - 377*dphidt*vTLRd_TL_1_23;
dx = [diPVd_B20dt
diPVq_B20dt
diPVd_PV21dt
diPVq_PV21dt
diSd_G22dt
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
diLd_L20dt
diLq_L20dt
diLd_L21dt
diLq_L21dt
diLd_L22dt
diLq_L22dt
diLd_L23dt
diLq_L23dt
dvTLLd_TL_1_20dt
dvTLLq_TL_1_20dt
diTLMd_TL_1_20dt
diTLMq_TL_1_20dt
dvTLRd_TL_1_20dt
dvTLRq_TL_1_20dt
diTLMd_TL_1_21dt
diTLMq_TL_1_21dt
dvTLRd_TL_1_21dt
dvTLRq_TL_1_21dt
diTLMd_TL_20_21dt
diTLMq_TL_20_21dt
diTLMd_TL_1_22dt
diTLMq_TL_1_22dt
dvTLRd_TL_1_22dt
dvTLRq_TL_1_22dt
diTLMd_TL_1_23dt
diTLMq_TL_1_23dt
dvTLRd_TL_1_23dt
dvTLRq_TL_1_23dt
dVsdt
dVs_Batdt
];
%%
A = jacobian(dx,x);
A2 = vpa(subs(A,[x;u],[x0;ueq]),4);
A1 = double(A2);
lam1 = eig(A1);
max(real(lam1))
% 
B = jacobian(dx,u);
B1 = double(vpa(subs(B,[x;u],[x0;ueq]),4));

val= 1; val1 = 1;
Q = 1*eye(numel(x));
Q(5,5) = val;
Q(6,6) = val;
Q(7,7) = val;
Q(12,12) = val1;
Q(13,13) = val;
Q(14,14) = val1;

R = 1*eye(4);
R(2,2) = 1; R(4,4) = 1;
k = lqr(A1,B1, Q,R,0);
K = zeros(4,numel(x));
K(1,13) = k(1,13);
K(1,14) = k(1,14);
K(2,12) = k(2,12);
K(3,6) = k(3,6);
K(3,7) = k(3,7);
K(4,5) = k(4,5);

lam2 = eig(A1-B1*K);
max(real(lam2))