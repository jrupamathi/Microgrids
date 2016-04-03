RL_PV21 = -0.1;
LL_PV21 = 0.01;
% RR_PV21= 0.4;
% LR_PV21=0.1;
% Pref_PV21 = 3/4;
% Vref_PV21 = 1.15;
% k1_PV21 = LR_PV21*0.1; k2_PV21 = LR_PV21*0.1;
% c1_PV21= 0.01; c2_PV21 = 0.01;
% Kp1_PV21 = 0.02; Ki1_PV21 = 0.2;
% Kp2_PV21 = 0.4; Ki2_PV21 = 0.25;
% save('PV21.mat', 'RR_PV21','LR_PV21','Pref_PV21', 'Vref_PV21','Kp1_PV21','Ki1_PV21','Kp2_PV21','Ki2_PV21','c1_PV21','c2_PV21','k1_PV21','k2_PV21');
save('PV21.mat', 'RL_PV21','LL_PV21');

PL_B20= 0;
QL_B20=0;
RL_B20 = 3*PL_B20/(PL_B20^2 + QL_B20^2);
LL_B20 = 3*QL_B20/(PL_B20^2 + QL_B20^2);
save('B20.mat', 'RL_B20', 'LL_B20');

PL_L2= 1.186/4;
QL_L2=0.6148/4;
RL_L2 = 3*PL_L2/(PL_L2^2 + QL_L2^2);
LL_L2 = 3*QL_L2/(PL_L2^2 + QL_L2^2);
save('L2.mat', 'RL_L2', 'LL_L2');

PL_L11= 0.22/4;
QL_L11=0.01/4;
RL_L11 = 3*PL_L11/(PL_L11^2 + QL_L11^2);
LL_L11 = 3*QL_L11/(PL_L11^2 + QL_L11^2);
save('L11.mat', 'RL_L11', 'LL_L11');

PL_L12= 0.14/4;
QL_L12=0.09/4;
RL_L12 = 3*PL_L12/(PL_L12^2 + QL_L12^2);
LL_L12 = 3*QL_L12/(PL_L12^2 + QL_L12^2);
save('L12.mat', 'RL_L12', 'LL_L12');

PL_L13= 0.16/4;
QL_L13=0.09/4;
RL_L13 = 3*PL_L13/(PL_L13^2 + QL_L13^2);
LL_L13 = 3*QL_L13/(PL_L13^2 + QL_L13^2);
save('L13.mat', 'RL_L13', 'LL_L13');

PL_L14= 0.706/4;
QL_L14=0.639/4;
RL_L14 = 3*PL_L14/(PL_L14^2 + QL_L14^2);
LL_L14 = 3*QL_L14/(PL_L14^2 + QL_L14^2);
save('L14.mat', 'RL_L14', 'LL_L14');

PL_L15= 2.5/4;
QL_L15=1.2/4;
RL_L15 = 3*PL_L15/(PL_L15^2 + QL_L15^2);
LL_L15 = 3*QL_L15/(PL_L15^2 + QL_L15^2);
save('L15.mat', 'RL_L15', 'LL_L15');

PL_L16= 0.09/4;
QL_L16=0.042/4;
RL_L16 = 3*PL_L16/(PL_L16^2 + QL_L16^2);
LL_L16 = 3*QL_L16/(PL_L16^2 + QL_L16^2);
save('L16.mat', 'RL_L16', 'LL_L16');

PL_L17= 0.14/4;
QL_L17=0.01/4;
RL_L17 = 3*PL_L17/(PL_L17^2 + QL_L17^2);
LL_L17 = 3*QL_L17/(PL_L17^2 + QL_L17^2);
save('L17.mat', 'RL_L17', 'LL_L17');

PL_L18= 0.28/4;
QL_L18=0.1/4;
RL_L18 = 3*PL_L18/(PL_L18^2 + QL_L18^2);
LL_L18 = 3*QL_L18/(PL_L18^2 + QL_L18^2);
save('L18.mat', 'RL_L18', 'LL_L18');

PL_L19= 0.78/4;
QL_L19=0.42/4;
RL_L19 = 3*PL_L19/(PL_L19^2 + QL_L19^2);
LL_L19 = 3*QL_L19/(PL_L19^2 + QL_L19^2);
save('L19.mat', 'RL_L19', 'LL_L19');
