%For the case of voltage with shunts
PPV = 0.875; QPV = 0.01;
RL_PV21 = -PPV*0.976^2/(PPV^2+QPV^2);
LL_PV21 = -QPV*0.976^2/(PPV^2+QPV^2);
save('PV21.mat', 'RL_PV21', 'LL_PV21');

RTL_TL_1_21 = 0.0339;
LTL_TL_1_21 = 0.4481;
CTL_TL_1_21 = 0.01;

RTL_TL_1_22 = 0.0094;
LTL_TL_1_22 = 0.0484;
CTL_TL_1_22 = 0.01;

RTL_TL_1_23 = 0.0242;
LTL_TL_1_23 = 0.3549;
CTL_TL_1_23 = 0.01;

save('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
save('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
save('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

RL_L21 = 3.5377;
LL_L21 = 1.1645;
save('L21.mat', 'RL_L21', 'LL_L21');

RL_L22 = 1.0344;
LL_L22 = 0.6551;
save('L22.mat', 'RL_L22', 'LL_L22');

RL_L23 = 3.8788;
LL_L23 = 1.8745;
save('L23.mat', 'RL_L23', 'LL_L23');

RL_L1 = 3.2449;
LL_L1 = 1.3448;
save('L1.mat', 'RL_L1', 'LL_L1');

%%
PL_PV21 =-0.75; QL_PV21 = -0.01;
save('PV21.mat', 'PL_PV21', 'QL_PV21');

PL_L21 = 0.0771;%0.2544;
QL_L21 = 0.0435;%0.0693;
save('L21.mat', 'PL_L21', 'QL_L21');

PL_L22 = 0.2647;%0.7732;
QL_L22 = 0.1705;%0.4556;
save('L22.mat', 'PL_L22', 'QL_L22');

PL_L23 = 0.0646;%0.2231;
QL_L23 = 0.0359;%0.00966;
save('L23.mat', 'PL_L23', 'QL_L23');

PL_L1 = 0.0746;%0.3106;
QL_L1 = 0.0541;%0.0988;
save('L1.mat', 'PL_L1', 'QL_L1');
