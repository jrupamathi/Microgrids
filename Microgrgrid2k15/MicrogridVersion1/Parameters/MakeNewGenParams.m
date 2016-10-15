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


K1_G23 = 7.1102; K2_G23 = 56.2904;
K3_G23 = -4.6571;

iF_G23_ref = -0.5539;
delta_G23_ref = 0.2698;
omega_G23_ref = 1;

tauL_G23_ref = 0.2047;
vR_G23_ref =0.00116;

save('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','RF_G23','H_G23','B_G23','Rkq_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');

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

K1_G22 = 2.16; K2_G22 = 30.73;
K3_G22 = -5.2418;

iF_G22_ref = -0.5633;
delta_G22_ref = 0.2653;
omega_G22_ref = 1;

tauL_G22_ref = 0.1964;
vR_G22_ref = 0.001141;

save('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','RF_G22','H_G22','B_G22','Rkq_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');
