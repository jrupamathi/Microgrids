clear classes

syms phi dphidt real

% Generators
G23 = SM7State({'_G23'},phi,dphidt);
G22 = SM7State({'_G22'},phi,dphidt);

% Transmission Lines
% Bus 1
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_1_3 = TransmissionLine({'_TL_1_3'},phi,dphidt);
TL_1_4 = TransmissionLine({'_TL_1_4'},phi,dphidt);
% Bus 2
TL_2_23 = TransmissionLine({'_TL_2_23'},phi,dphidt);
% Bus 3
TL_3_5 = TransmissionLine({'_TL_3_5'},phi,dphidt);
TL_3_11 = TransmissionLine({'_TL_3_11'},phi,dphidt);
% Bus 4
TL_4_12 = TransmissionLine({'_TL_4_12'},phi,dphidt);
TL_4_6 = TransmissionLine({'_TL_4_6'},phi,dphidt);
TL_4_7 = TransmissionLine({'_TL_4_7'},phi,dphidt);
% Bus 5
TL_5_8 = TransmissionLine({'_TL_5_8'},phi,dphidt);
TL_5_9 = TransmissionLine({'_TL_5_9'},phi,dphidt);
% Bus 6
TL_6_13 = TransmissionLine({'_TL_6_13'},phi,dphidt);
TL_6_14 = TransmissionLine({'_TL_6_14'},phi,dphidt);
% Bus 7
TL_7_22 = TransmissionLine({'_TL_7_22'},phi,dphidt);
TL_7_15 = TransmissionLine({'_TL_7_15'},phi,dphidt);
% Bus 8
TL_8_21 = TransmissionLine({'_TL_8_21'},phi,dphidt);
TL_8_16 = TransmissionLine({'_TL_8_16'},phi,dphidt);
TL_8_17 = TransmissionLine({'_TL_8_17'},phi,dphidt);
% Bus 9
TL_9_18 = TransmissionLine({'_TL_9_18'},phi,dphidt);
TL_9_10 = TransmissionLine({'_TL_9_10'},phi,dphidt);
% Bus 10
TL_10_19 = TransmissionLine({'_TL_10_19'},phi,dphidt);
TL_10_20 = TransmissionLine({'_TL_10_20'},phi,dphidt);

% Machines
IM2 = InductionMachine({'_IM2'},phi,dphidt);
% Bus 14
IM14 = InductionMachine({'_IM14'},phi,dphidt);

% Loads
L2 = Load({'_L2'},phi,dphidt);
L11 = Load({'_L11'},phi,dphidt);
L12 = Load({'_L12'},phi,dphidt);
L13 = Load({'_L13'},phi,dphidt);
L14 = Load({'_L14'},phi,dphidt);
L15 = Load({'_L15'},phi,dphidt);
L16 = Load({'_L16'},phi,dphidt);
L17 = Load({'_L17'},phi,dphidt);
L18 = Load({'_L18'},phi,dphidt);
L19 = Load({'_L19'},phi,dphidt);
PV21 = Load({'_PV21'},phi,dphidt);
B20 = Load({'_B20'},phi,dphidt);

% Modules
Modules = {
    G22, G23, ...
    IM2, IM14, ...
    PV21, ...
    B20, ...
    L2, L11, L12, L13, L14, L15, L16, L17, L18, L19, ...
    TL_1_2, ...
    TL_1_3, ...
    TL_1_4, ...
    TL_2_23, ...
    TL_3_5, ... 
    TL_3_11, ...
    TL_4_6, ...
    TL_4_7, ...
    TL_4_12, ...
    TL_5_8, ...
    TL_5_9, ...
    TL_6_13 , ...
    TL_6_14 , ...
    TL_7_22 , ...
    TL_7_15 , ...
    TL_8_21 , ...
    TL_8_16 , ...
    TL_8_17 , ...
    TL_9_18 , ...
    TL_9_10 , ...
    TL_10_19, ...
    TL_10_20 };
    
% Buses
Bus1 = {{G23}, {TL_1_3, 'L'},{TL_1_2, 'L'},{TL_1_4, 'L'}};
Bus2 = {{TL_2_23, 'L'}, {IM2}, {L2}, {TL_1_2, 'R'}};
Bus3 = {{TL_1_3, 'R'}, {TL_3_5, 'L'}, {TL_3_11, 'L'}};
Bus4 = {{TL_1_4, 'R'}, {TL_4_6, 'L'}, {TL_4_7, 'L'},{TL_4_12, 'L'},};
Bus5 = {{TL_5_8, 'L'}, {TL_3_5, 'R'}, {TL_5_9, 'L'}};
Bus6 = {{TL_4_6, 'R'},  {TL_6_13, 'L'}, {TL_6_14, 'L'}};
Bus7 = {{TL_7_22, 'L'}, {TL_4_7, 'R'}, {TL_7_15, 'L'}};
Bus8 = {{TL_8_21, 'L'}, {TL_8_16, 'L'}, {TL_8_17, 'L'}, {TL_5_8, 'R'}};
Bus9 = {{TL_5_9, 'R'}, {TL_9_18, 'L'}, {TL_9_10, 'L'}};
Bus10 = {{TL_9_10, 'R'}, {TL_10_19,'L'}, {TL_10_20,'L'}};
Bus11 = {{TL_3_11, 'R'}, {L11}};
Bus12 = {{TL_4_12, 'R'}, {L12}};
Bus13 = {{TL_6_13, 'R'}, {L13}};
Bus14 = {{TL_6_14, 'R'}, {L14}, {IM14}};
Bus15 = {{TL_7_15, 'R'}, {L15}};
Bus16 = {{TL_8_16, 'R'}, {L16}};
Bus17 = {{TL_8_17, 'R'}, {L17}};
Bus18 = {{TL_9_18, 'R'}, {L18}};
Bus19 = {{TL_10_19, 'R'}, {L19}};
Bus20 = {{TL_10_20, 'R'}, {B20}};
Bus21 = {{TL_8_21, 'R'}, {PV21}};
Bus22 = {{TL_7_22, 'R'}, {G22}};
Bus23 = {{TL_2_23, 'R'}, {G23}};

Buses = {Bus1, Bus2, Bus3, Bus4, Bus5, Bus6, Bus7, Bus8, Bus9, Bus10, ...
Bus11, Bus12, Bus13, Bus14, Bus15, Bus16, Bus17, Bus18, Bus19, Bus20, ...
Bus21, Bus22, Bus23};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/MicrogridInterconnection.txt')
