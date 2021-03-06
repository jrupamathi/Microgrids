Ll1 = 0.08;
Lmd1 = 2.81;
Lmq1 = 1.64;
Llfd1 = 0.531;
Llkd1 = 2.655;
Llkq1 = 0.2408;

H_G23 = 0.3222;
B_G23 = 0.0132;
RS_G23 = 0.01524;
RR_G23 = 0.22;
Rkd_G23 = 0.2343;
Rkq_G23 = 0.03365;
RF_G23 = 0.004319;

LSd_G23 = Ll1+ Lmd1;
LRD_G23 = Llkd1 + Lmd1;
LF_G23 = Llfd1 + Lmd1;
LSq_G23 = Ll1 + Lmq1;
LRQ_G23 = Llkq1 + Lmq1;

Lad_G23 =  2.81;
Laf_G23 =  2.81;
Ldf_G23 =  2.81;
Laq_G23 =  1.64;

k=[5.8125   35.5171   -1.1682   -2.5449    1.3147    1.3279   -2.3964
   -3.5568   -9.1728   -3.9072    8.0164   -8.7656   -9.8039    1.4338];
reqd=[0.8426, -0.5012, 1.19e-13, -1.484, 9.292e-14, 0.6192, 1.0 ]';
K11_G23=k(1,1); K21_G23=k(2,1);
K12_G23=k(1,2); K22_G23=k(2,2);
K13_G23=k(1,3); K23_G23=k(2,3); 
K14_G23=k(1,4); K24_G23=k(2,4);
K15_G23=k(1,5); K25_G23=k(2,5);
K16_G23=k(1,6); K26_G23=k(2,6);
K17_G23=k(1,7); K27_G23=k(2,7);

iSd_G23_ref = reqd(1);
iSq_G23_ref = reqd(2);
iRd_G23_ref = reqd(3);
iRq_G23_ref = reqd(5);
iF_G23_ref = reqd(4);
delta_G23_ref = reqd(6);
omega_G23_ref = reqd(7);

tauL_G23_ref = 1;
vR_G23_ref = 0.000641;

Tmeq_G23 = tauL_G23_ref;
vfeq_G23 = vR_G23_ref;

save('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23',...
    'K11_G23','K12_G23','K13_G23','K14_G23','K15_G23','K16_G23','K17_G23',...
    'K21_G23','K22_G23','K23_G23','K24_G23','K25_G23','K26_G23','K27_G23',...
    'delta_G23_ref','omega_G23_ref','iSd_G23_ref','iSq_G23_ref','iRd_G23_ref','iRq_G23_ref','iF_G23_ref',...
    'Tmeq_G23','vfeq_G23');
% save('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','Rkq_G23','RF_G23','H_G23','B_G23',...
%     'K11_G23','K12_G23','K13_G23','K14_G23','K15_G23','K16_G23','K17_G23',...
%     'K21_G23','K22_G23','K23_G23','K24_G23','K25_G23','K26_G23','K27_G23',...
%     'delta_G23_ref','omega_G23_ref','iSd_G23_ref','iSq_G23_ref','iRd_G23_ref','iRq_G23_ref','iF_G23_ref',...
%     'tauL_G23_ref','vR_G23_ref');

%%
Ll2 = 0.05;
Lmd2 = 2.35;
Lmq2 = 1.72;
Llfd2 = 0.511;
Llkd2 = 3.7378;
Llkq2 = 0.2392;

H_G22 = 0.3468;
B_G22 = 0.009238;
F_G22 = 0.009238;
RS_G22 = 0.008979;
RR_G22 = 0.2825;
Rkd_G22 = 0.2343;
Rkq_G22 = 0.0337;
RF_G22 = 0.00206;

LSd_G22 = Ll2+ Lmd2;
LRD_G22 = Llkd2 + Lmd2;
LF_G22 = Llfd2 + Lmd2;
LSq_G22 = Ll2 + Lmq2;
LRQ_G22 = Llkq2 + Lmq2;

Lad_G22 =  2.35;
Laf_G22 =  2.35;
Ldf_G22 =  2.35;
Laq_G22 =  1.72;
reqd = [ 0.7241, 1.0, 0.8426, -0.5012, 2.558e-16, -1.81, -5.773e-16]';
k  =[2.3522   33.1838    0.3140   -0.2362    0.5317    0.3897    0.2586
   -1.0142  -10.7170   -0.5415    0.9354   -1.0996   -1.9404    0.0550];
K11_G22=k(1,1); K21_G22=k(2,1);
K12_G22=k(1,2); K22_G22=k(2,2);
K13_G22=k(1,3); K23_G22=k(2,3); 
K14_G22=k(1,4); K24_G22=k(2,4);
K15_G22=k(1,5); K25_G22=k(2,5);
K16_G22=k(1,6); K26_G22=k(2,6);
K17_G22=k(1,7); K27_G22=k(2,7);

iSd_G22_ref = reqd(1);
iSq_G22_ref = reqd(2);
iRd_G22_ref = reqd(3);
iRq_G22_ref = reqd(5);
iF_G22_ref = reqd(4);
delta_G22_ref = reqd(6);
omega_G22_ref = reqd(7);

tauL_G22_ref = 1;
vR_G22_ref = 0.003729;

Tmeq_G22 = tauL_G22_ref;
vfeq_G22 = vR_G22_ref;

save('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22',...
    'K11_G22','K12_G22','K13_G22','K14_G22','K15_G22','K16_G22','K17_G22',...
    'K21_G22','K22_G22','K23_G22','K24_G22','K25_G22','K26_G22','K27_G22',...
    'delta_G22_ref','omega_G22_ref','iSd_G22_ref','iSq_G22_ref','iRd_G22_ref','iRq_G22_ref','iF_G22_ref',...
    'Tmeq_G22','vfeq_G22');
% save('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','Rkq_G22','RF_G22','H_G22','B_G22',...
%     'K11_G22','K12_G22','K13_G22','K14_G22','K15_G22','K16_G22','K17_G22',...
%     'K21_G22','K22_G22','K23_G22','K24_G22','K25_G22','K26_G22','K27_G22',...
%     'delta_G22_ref','omega_G22_ref','iSd_G22_ref','iSq_G22_ref','iRd_G22_ref','iRq_G22_ref','iF_G22_ref',...
%     'tauL_G22_ref','vR_G22_ref');
