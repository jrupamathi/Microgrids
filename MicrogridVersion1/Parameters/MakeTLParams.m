% Wire inductance values
L_AWG1_0 = 259e-9;
L_AWG4_0 = 239e-9;
L_KCMIL_500 = 213e-9;

% Capacitance
C = 1e-6;

% Base values for transmission line
Base_MVA = 4;
Base_KV = 13.8;
B23_KV = 0.46;
B5_KV = 4.16;

% Transmission Lines (copied from perUnitCalcs.xlsx)
RTL_TL_1_2 = 4.55308E-05;	
LTL_TL_1_2 = 0.100043667;
CTL_TL_1_2 = 1e-2;

RTL_TL_1_3 = 2.27063E-05;
LTL_TL_1_3 = 7.6979E-05;
CTL_TL_1_3 = 1e-2;

RTL_TL_1_4 = 1.51352E-05;
LTL_TL_1_4 = 2.91115E-05;
CTL_TL_1_4 = 1e-2;

RTL_TL_2_23 = 0.001951319;
LTL_TL_2_23 = 0.001871451;
CTL_TL_2_23 = 1e-2;

RTL_TL_3_5 = 3.48411E-05;
LTL_TL_3_5 = 0.100100319;
CTL_TL_3_5 = 1e-2;

RTL_TL_3_11 = 0.002033708;
LTL_TL_3_11 = 0.101950468;
CTL_TL_3_11 = 1e-2;

RTL_TL_4_6 = 3.02705E-05;
LTL_TL_4_6 = 5.82229E-05;
CTL_TL_4_6 = 1e-2;

RTL_TL_4_7 = 2.45341E-07;
LTL_TL_4_7 = 8.31756E-07;
CTL_TL_4_7 = 1e-2;

RTL_TL_4_12 = 0.000552557;
LTL_TL_4_12 = 0.101872491;
CTL_TL_4_12 = 1e-2;

RTL_TL_5_8 = 7.13812E-06;
LTL_TL_5_8 = 9.15309E-06;
CTL_TL_5_8 = 1e-2;

RTL_TL_5_9 = 4.75875E-06;
LTL_TL_5_9 = 9.15309E-06;
CTL_TL_5_9 = 1e-2;

RTL_TL_6_13 = 0.000554179;
LTL_TL_6_13 = 0.10187561;
CTL_TL_6_13 = 1e-2;

RTL_TL_6_14 = 0.00141525;
LTL_TL_6_14 = 0.104720632;
CTL_TL_6_14 = 1e-2;

RTL_TL_7_22 = 1.2267E-06;
LTL_TL_7_22 = 4.15878E-06;
CTL_TL_7_22 = 1e-2;

RTL_TL_7_15 = 3.07903E-06;
LTL_TL_7_15 = 0.100010439;
CTL_TL_7_15 = 1e-2;

RTL_TL_8_16 = 0.000288143;
LTL_TL_8_16 = 0.100959066;
CTL_TL_8_16 = 1e-2;

RTL_TL_8_17 = 0.001362065;
LTL_TL_8_17 = 0.104599883;
CTL_TL_8_17 = 1e-2;

RTL_TL_8_21 = 0;	
LTL_TL_8_21 = 0.1;
CTL_TL_8_21 = 1e-2;

RTL_TL_9_10 = 1.21348E-05;	
LTL_TL_9_10 = 2.33404E-05;
CTL_TL_9_10 = 1e-2;

RTL_TL_9_18 = 0.001362065;	
LTL_TL_9_18 = 0.104599883;
CTL_TL_9_18 = 1e-2;

RTL_TL_10_19 = 0.00134993;	
LTL_TL_10_19 = 0.104576543;
CTL_TL_10_19 = 1e-2;

RTL_TL_10_20 = 5.71895E-05;	
LTL_TL_10_20 = 0.10011;
CTL_TL_10_20 = 1e-2;

save('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
save('TL_1_3.mat', 'LTL_TL_1_3', 'RTL_TL_1_3','CTL_TL_1_3');
save('TL_1_4.mat', 'LTL_TL_1_4', 'RTL_TL_1_4','CTL_TL_1_4');

save('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');

save('TL_3_5.mat', 'LTL_TL_3_5', 'RTL_TL_3_5','CTL_TL_3_5');
save('TL_3_11.mat', 'LTL_TL_3_11', 'RTL_TL_3_11','CTL_TL_3_11');

save('TL_4_6.mat', 'LTL_TL_4_6', 'RTL_TL_4_6','CTL_TL_4_6');
save('TL_4_7.mat', 'LTL_TL_4_7', 'RTL_TL_4_7','CTL_TL_4_7');
save('TL_4_12.mat', 'LTL_TL_4_12', 'RTL_TL_4_12','CTL_TL_4_12');

save('TL_5_8.mat', 'LTL_TL_5_8', 'RTL_TL_5_8','CTL_TL_5_8');
save('TL_5_9.mat', 'LTL_TL_5_9', 'RTL_TL_5_9','CTL_TL_5_9');

save('TL_6_13.mat', 'LTL_TL_6_13', 'RTL_TL_6_13','CTL_TL_6_13');
save('TL_6_14.mat', 'LTL_TL_6_14', 'RTL_TL_6_14','CTL_TL_6_14');

save('TL_7_22.mat', 'LTL_TL_7_22', 'RTL_TL_7_22','CTL_TL_7_22');
save('TL_7_15.mat', 'LTL_TL_7_15', 'RTL_TL_7_15','CTL_TL_7_15');

save('TL_8_16.mat', 'LTL_TL_8_16', 'RTL_TL_8_16','CTL_TL_8_16');
save('TL_8_17.mat', 'LTL_TL_8_17', 'RTL_TL_8_17','CTL_TL_8_17');
save('TL_8_21.mat', 'LTL_TL_8_21', 'RTL_TL_8_21','CTL_TL_8_21');

save('TL_9_10.mat', 'LTL_TL_9_10', 'RTL_TL_9_10','CTL_TL_9_10');
save('TL_9_18.mat', 'LTL_TL_9_18', 'RTL_TL_9_18','CTL_TL_9_18');

save('TL_10_19.mat', 'LTL_TL_10_19', 'RTL_TL_10_19','CTL_TL_10_19');
save('TL_10_20.mat', 'LTL_TL_10_20', 'RTL_TL_10_20','CTL_TL_10_20');

