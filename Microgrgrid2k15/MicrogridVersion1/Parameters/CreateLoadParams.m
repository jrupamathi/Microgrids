clear all

%Induction machines
horsepower2watts = 745.7;

% IM2
Rs_IM2 = 0.0256294 / (4/1.87);
Lls_IM2 = 0.0998644 / (4/1.87);
Rr_IM2 = 0.0100649 / (4/1.87);
Llr_IM2 = 0.0998644 / (4/1.87);
Lm_IM2 = 3.47857 / (4/1.87);
H_IM2 = 0.03* (4/1.87);
F_IM2 = 0.005479* (4/1.87);
tauL_IM2 = 250 * horsepower2watts/(4e3);
J_IM2 = 2*H_IM2;
B_IM2 = F_IM2;

% Derive IM2 expressions
Lmr_IM2 = Lm_IM2;
Lms_IM2 = Lm_IM2;

LR_IM2 = Llr_IM2 + Lmr_IM2;
LS_IM2 = Lls_IM2 + Lms_IM2;
LSS_IM2 = 3*Lms_IM2 / 2;
LRR_IM2 = 3*Lmr_IM2 / 2;
M_IM2 = Lm_IM2;
RR_IM2 = Rr_IM2;
RS_IM2 = Rs_IM2;

% IM14
Rs_IM14 = 0.0256294 / (4/1.87);
Lls_IM14 = 0.0998644 / (4/1.87);
Rr_IM14 = 0.0100649 / (4/1.87);
Llr_IM14 = 0.0998644 / (4/1.87);
Lm_IM14 = 3.47857 / (4/1.87);
H_IM14 = 0.03* (4/1.87);
F_IM14 = 0.005479* (4/1.87);
tauL_IM14 = 250 * horsepower2watts/(4e3);
J_IM14 = 2*H_IM2;
B_IM14 = F_IM2;

% Derive G22 expressions
Lmr_IM14 = Lm_IM14;
Lms_IM14 = Lm_IM14;

LR_IM14 = Llr_IM14 + Lmr_IM14;
LS_IM14 = Lls_IM14 + Lms_IM14;
LSS_IM14 = 3*Lms_IM14 / 2;
LRR_IM14 = 3*Lmr_IM14 / 2;
M_IM14 = Lm_IM14;
RR_IM14 = Rr_IM14;
RS_IM14 = Rs_IM14;

save('IM2.mat','LR_IM2','LRR_IM2','LS_IM2','LSS_IM2','M_IM2','RR_IM2','RS_IM2','J_IM2','tauL_IM2','B_IM2');
save('IM14.mat','LR_IM14','LRR_IM14','LS_IM14','LSS_IM14','M_IM14','RR_IM14','RS_IM14','J_IM14','tauL_IM14','B_IM14');

PL_PV21= -0.1875;
QL_PV21=-0.01;
save('PV21.mat', 'PL_PV21', 'QL_PV21');

% PL_B20= 0;
% QL_B20=0;
% save('B20.mat', 'PL_B20', 'QL_B20');

PL_L2= 1.186/4;
QL_L2=0.6148/4;
save('L2.mat', 'PL_L2', 'QL_L2');

PL_L11= 0.22/4;
QL_L11=0.01;
save('L11.mat', 'PL_L11', 'QL_L11');

PL_L12= 0.14/4;
QL_L12=0.09/4;
save('L12.mat', 'PL_L12', 'QL_L12');

PL_L13= 0.16/4;
QL_L13=0.09/4;
save('L13.mat', 'PL_L13', 'QL_L13');

PL_L14= 0.706/4;
QL_L14=0.639/4;
save('L14.mat', 'PL_L14', 'QL_L14');

PL_L15= 2.5/4;
QL_L15=1.2/4;
save('L15.mat', 'PL_L15', 'QL_L15');

PL_L16= 0.09/4;
QL_L16=0.042/4;
save('L16.mat', 'PL_L16', 'QL_L16');

PL_L17= 0.14/4;
QL_L17=0.01/4;
save('L17.mat', 'PL_L17', 'QL_L17');

PL_L18= 0.28/4;
QL_L18=0.1/4;
save('L18.mat', 'PL_L18', 'QL_L18');

PL_L19= 0.78/4;
QL_L19=0.42/4;
save('L19.mat', 'PL_L19', 'QL_L19');
