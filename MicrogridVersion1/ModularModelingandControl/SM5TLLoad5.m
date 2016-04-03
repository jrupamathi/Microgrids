clear classes

syms phi dphidt real

% Generators
G1 = SM7State({'_G1'},phi,dphidt);
G2 = SM7State({'_G2'},phi,dphidt);
G3 = SM7State({'_G3'},phi,dphidt);
G4 = SM7State({'_G4'},phi,dphidt);
G5 = SM7State({'_G5'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);

% Loads
L1 = Load({'_L1'},phi,dphidt);
L2 = Load({'_L2'},phi,dphidt);
L3 = Load({'_L3'},phi,dphidt);
L4 = Load({'_L4'},phi,dphidt);
L5 = Load({'_L5'},phi,dphidt);
%IM2 = InductionMachine({'_IM2'},phi,dphidt);

% Modules
Modules = {G1,G2,G3,G4,G5,...
    L1,L2,L3,L4,L5...
    TL_1_2};%...
    %IM2};
    
% Buses
Bus1 = {{G1},{G2},{G3},{G4},{G5}, {TL_1_2, 'L'}};
Bus2 = {{TL_1_2, 'R'}, {L1}, {L2}, {L3}, {L4}, {L5}};
Buses = {Bus1, Bus2};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/SM5TLLoad5.txt')
