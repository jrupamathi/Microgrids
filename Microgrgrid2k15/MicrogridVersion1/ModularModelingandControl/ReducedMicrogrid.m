clear classes

syms phi dphidt real

% Generators
G22 = SM7StateControl({'_G22'},phi,dphidt);
G23 = SM7StateControl({'_G23'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_1_3 = TransmissionLine({'_TL_1_3'},phi,dphidt);
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_2_3 = TransmissionLine({'_TL_2_3'},phi,dphidt);

% Loads
L2 = Load({'_L2'},phi,dphidt);
L1 = Load({'_L1'},phi,dphidt);
L3 = Load({'_L3'},phi,dphidt);
PV3 = Load({'_PV3'},phi,dphidt);
%IM2 = InductionMachine({'_IM2'},phi,dphidt);

% Modules
Modules = {G1,G2,...
    L1,L2,L3,PV3,...
    TL_1_2,TL_1_3,TL_2_3};%...
    %IM2};
    
% Buses
Bus3 = {{L3},{PV3}, {TL_1_3, 'R'},{TL_2_3, 'R'}};
Bus2 = {{G2}, {L2},{TL_1_2,'R'},{TL_2_3, 'L'}};
Bus1 = {{G1},{TL_1_2, 'L'},{TL_1_3, 'L'},{L1}};

Buses = {Bus1, Bus2, Bus3};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/ReducedMicrogrid.txt')
