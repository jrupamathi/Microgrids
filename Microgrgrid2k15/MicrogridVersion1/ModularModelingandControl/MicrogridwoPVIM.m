clear classes

syms phi dphidt real

% Generators
G23 = SM7StateControl({'_G23'},phi,dphidt);
G22 = SM7StateControl({'_G22'},phi,dphidt);

% Transmission Lines
% Bus 2
%TL_2_23 = TransmissionLine({'_TL_2_23'},phi,dphidt);
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_1_5 = TransmissionLine({'_TL_1_5'},phi,dphidt);
TL_1_14 = TransmissionLine({'_TL_1_14'},phi,dphidt);
TL_1_15 = TransmissionLine({'_TL_1_15'},phi,dphidt);
TL_1_12 = TransmissionLine({'_TL_1_12'},phi,dphidt);
TL_1_13 = TransmissionLine({'_TL_1_13'},phi,dphidt);
TL_1_11 = TransmissionLine({'_TL_1_11'},phi,dphidt);
TL_5_16 = TransmissionLine({'_TL_5_16'},phi,dphidt);
TL_5_17 = TransmissionLine({'_TL_5_17'},phi,dphidt);
TL_5_18 = TransmissionLine({'_TL_5_18'},phi,dphidt);
TL_5_19 = TransmissionLine({'_TL_5_19'},phi,dphidt);

% PQLoads
L2 = PQLoad({'_L2'},phi,dphidt);
L16 = PQLoad({'_L16'},phi,dphidt);
L17 = PQLoad({'_L17'},phi,dphidt);
L18 = PQLoad({'_L18'},phi,dphidt);
L19 = PQLoad({'_L19'},phi,dphidt);
L14 = PQLoad({'_L14'},phi,dphidt);
L15 = PQLoad({'_L15'},phi,dphidt);
L13 = PQLoad({'_L13'},phi,dphidt);
L12 = PQLoad({'_L12'},phi,dphidt);
L11 = PQLoad({'_L11'},phi,dphidt);

% Modules
Modules = {G23,G22,...
    L2,L16,L17,L18,L19,L14,L15,L12,L13,L11,...
    TL_5_16,TL_5_17,TL_5_18,TL_5_19,...
    TL_1_5,TL_1_14,TL_1_15,TL_1_2,TL_1_12,TL_1_13,TL_1_11};
    
% Buses
%Bus23 = {{G23}, {TL_2_23, 'R'}};
Bus2 = {{G23},{L2},{TL_1_2, 'R'}};
Bus1 = {{TL_1_2, 'L'},{TL_1_5, 'L'},{G22},{TL_1_14, 'L'},{TL_1_15,'L'},{TL_1_12,'L'},{TL_1_13,'L'},...
    {TL_1_11,'L'}};
Bus5={{TL_1_5, 'R'},{TL_5_16, 'L'},{TL_5_17, 'L'},{TL_5_18, 'L'},{TL_5_19, 'L'}};
Bus16 = {{TL_5_16, 'R'},{L16}};
Bus17 = {{TL_5_17, 'R'},{L17}};
Bus18 ={{TL_5_18, 'R'},{L18}};
Bus19 = {{TL_5_19, 'R'},{L19}};
Bus14 = {{L14},{TL_1_14, 'R'}};
Bus15 = {{TL_1_15,'R'},{L15}};
Bus13 = {{TL_1_13,'R'},{L13}};
Bus12 = {{TL_1_12,'R'},{L12}};
Bus11 = {{TL_1_11,'R'},{L11}};

Buses = {Bus1, Bus2, Bus5, Bus16, Bus17, Bus18, Bus19,Bus14, Bus15, Bus13, Bus12,...
    Bus11};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/MicdrogridwoPVIMModified.txt')