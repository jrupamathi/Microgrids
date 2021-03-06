clear classes

syms phi dphidt real

% Generators
G23 = SM7StateControl({'_G23'},phi,dphidt);
G22 = SM7StateControl({'_G22'},phi,dphidt);

% Transmission Lines


% PQLoads
L2 = Load({'_L2'},phi,dphidt);
L16 = Load({'_L16'},phi,dphidt);
L17 = Load({'_L17'},phi,dphidt);
L18 = Load({'_L18'},phi,dphidt);
L19 = Load({'_L19'},phi,dphidt);
L14 = Load({'_L14'},phi,dphidt);
L15 = Load({'_L15'},phi,dphidt);
L13 = Load({'_L13'},phi,dphidt);
L12 = Load({'_L12'},phi,dphidt);
L11 = Load({'_L11'},phi,dphidt);
PV21 = Load({'_PV21'},phi,dphidt);

TL_1_23 = TransmissionLine({'_TL_1_23'},phi,dphidt);
TL_1_3 = TransmissionLine({'_TL_1_3'},phi,dphidt);
TL_1_22 = TransmissionLine({'_TL_1_22'},phi,dphidt);
TL_3_5 = TransmissionLine({'_TL_3_5'},phi,dphidt);
TL_3_11 = TransmissionLine({'_TL_3_11'},phi,dphidt);

TL_5_16 = TransmissionLine({'_TL_5_16'},phi,dphidt);
TL_5_17 = TransmissionLine({'_TL_5_17'},phi,dphidt);
TL_5_18 = TransmissionLine({'_TL_5_18'},phi,dphidt);
TL_5_19 = TransmissionLine({'_TL_5_19'},phi,dphidt);
TL_5_21 = TransmissionLine({'_TL_5_21'},phi,dphidt);

TL_22_6 = TransmissionLine({'_TL_22_6'},phi,dphidt);
TL_22_15 = TransmissionLine({'_TL_22_15'},phi,dphidt);
TL_22_12 = TransmissionLine({'_TL_22_12'},phi,dphidt);
TL_6_13 = TransmissionLine({'_TL_6_13'},phi,dphidt);
TL_6_14 = TransmissionLine({'_TL_6_14'},phi,dphidt);

% Modules
Modules = {G23,G22,...
    L2,L16,L17,L18,L19,L14,L15,L12,L13,L11,PV21,...
    TL_1_23,TL_1_3,TL_1_22,TL_3_5,TL_3_11,...
    TL_5_16,TL_5_17,TL_5_18,TL_5_19,TL_5_21,...
    TL_22_6,TL_22_15,TL_22_12,TL_6_13,TL_6_14};
    
% Buses
Bus23 = {{G23},{L2},{TL_1_23, 'R'}};
Bus1 = {{TL_1_23, 'L'},{TL_1_3, 'L'},{TL_1_22, 'L'}};
Bus3 = {{TL_1_3, 'R'},{TL_3_5, 'L'},{TL_3_11, 'L'}};
Bus5={{TL_3_5, 'R'},{TL_5_16, 'L'},{TL_5_17, 'L'},{TL_5_18, 'L'},{TL_5_19, 'L'},{TL_5_21, 'L'}};
Bus16 = {{TL_5_16, 'R'},{L16}};
Bus17 = {{TL_5_17, 'R'},{L17}};
Bus18 ={{TL_5_18, 'R'},{L18}};
Bus19 = {{TL_5_19, 'R'},{L19}};
Bus14 = {{L14},{TL_6_14, 'R'}};
Bus15 = {{TL_22_15,'R'},{L15}};
Bus13 = {{TL_6_13,'R'},{L13}};
Bus12 = {{TL_22_12,'R'},{L12}};
Bus11 = {{TL_3_11,'R'},{L11}};
Bus21 = {{TL_5_21, 'R'}, {PV21}};
Bus22 = {{G22},{TL_22_12, 'L'},{TL_22_6, 'L'},{TL_22_15, 'L'},{TL_1_22, 'R'}};
Bus6 = {{TL_22_6, 'R'},{TL_6_13, 'L'},{TL_6_14, 'L'}};



Buses = {Bus1, Bus3, Bus5, Bus6, Bus11, Bus12, Bus13,...
    Bus14, Bus15, Bus16, Bus17,Bus18, Bus19, Bus21,...
    Bus22, Bus23};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/MicdrogridwoIMShortLinesRLLoad.txt')