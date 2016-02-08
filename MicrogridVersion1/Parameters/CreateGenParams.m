clear all

% G_22 = 4 MVA generator
% G_23 = 1 MVA generator

%Normalized parameters

%Calculate SI parameters

%Generators

% G_22

Rs_G22 = 0.008979;
Ll_G22 = 0.05;
Lmd_G22 = 2.35;
Lmq_G22 = 1.72;
Rf_G22 = 0.00206;
Lfd_G22 = 0.511;
Rkd_G22 = 0.2826;
Llkd_G22 = 3.738;
Rkq_G22 = 0.02545;
Lkq_G22 = 0.2392;
H_G22 = 0.3468;
F_G22 = 0.009238;

J_G22 = 2*H_G22;
B_G22 = F_G22;

% Derive G22 expressions
Lmr_G22 = (Lmd_G22 + Lmq_G22)/2;
Lms_G22 = Lmr_G22;

LR_G22 = Lfd_G22 + Lmr_G22;
LS_G22 = Ll_G22 + Lmd_G22;
LSS_G22 = Lms_G22 / 2;
M_G22 = Lms_G22;
RR_G22 = Rf_G22;
RS_G22 = Rs_G22;
% Parameters to tune
Tg_G22 = 1*10^-3;
Tu_G22 = 0.0009;
Kt_G22 = 10e-4;
r_G22 = 200;
omega_G22_ref = 1;
Kp_G22 = 2.5;
Ki_G22 = 10;
Ke_G22 = 2;
vTerminal_G22_ref = 1;

% G_23

Rs_G23 = 0.01524;
Ll_G23 = 0.08;
Lmd_G23 = 2.81;
Lmq_G23 = 1.64;
Rf_G23 = 0.004319;
Lfd_G23 = 0.531;
Rkd_G23 = 0.2343;
Llkd_G23 = 2.655;
Rkq_G23 = 0.03365;
Lkq_G23 = 0.2408;
H_G23 = 0.3222;
F_G23 = 0.01322;

J_G23 = 2*H_G23;
B_G23 = F_G23;

% Derive G22 expressions
Lmr_G23 = (Lmd_G23 + Lmq_G23)/2;
Lms_G23 = Lmr_G23;

LR_G23 = Lfd_G23 + Lmr_G23;
LS_G23 = Ll_G23 + Lmd_G23;
LSS_G23 = Lms_G23 / 2;
M_G23 = Lms_G23;
RR_G23 = Rf_G23;
RS_G23 = Rs_G23;
% Parameters to tune
Tg_G23 = 1*10^-3;
Tu_G23 = 0.0009;
Kt_G23 = 10e-4;
r_G23 = 200;
omega_G23_ref = 1;
Kp_G23 = 2.5;
Ki_G23 = 10;
Ke_G23 = 2;
vTerminal_G23_ref = 1;

save('G22.mat','J_G22','B_G22','LR_G22','LS_G22','LSS_G22','M_G22','RR_G22','RS_G22',...
     'Tg_G22','Tu_G22','Kt_G22','r_G22','omega_G22_ref','Kp_G22','Ki_G22','Ke_G22','vTerminal_G22_ref')
 
save('G23.mat','J_G23','B_G23','LR_G23','LS_G23','LSS_G23','M_G23','RR_G23','RS_G23',...
     'Tg_G23','Tu_G23','Kt_G23','r_G23','omega_G23_ref','Kp_G23','Ki_G23','Ke_G23','vTerminal_G23_ref')