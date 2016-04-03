clear classes

syms phi dphidt real

% Generators
G1 = SM7State({'_G1'},phi,dphidt);
G2 = SM7State({'_G2'},phi,dphidt);
G3 = SM7State({'_G3'},phi,dphidt);
G4 = SM7State({'_G4'},phi,dphidt);
G5 = SM7State({'_G5'},phi,dphidt);
G6 = SM7State({'_G6'},phi,dphidt);
G7 = SM7State({'_G7'},phi,dphidt);
G8 = SM7State({'_G8'},phi,dphidt);
G9 = SM7State({'_G9'},phi,dphidt);
G10 = SM7State({'_G10'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_2_3 = TransmissionLine({'_TL_2_3'},phi,dphidt);
TL_3_4 = TransmissionLine({'_TL_3_4'},phi,dphidt);
TL_4_1 = TransmissionLine({'_TL_4_1'},phi,dphidt);

% Loads
L1 = Load({'_L1'},phi,dphidt);
L2 = Load({'_L2'},phi,dphidt);
L3 = Load({'_L3'},phi,dphidt);
L4 = Load({'_L4'},phi,dphidt);
L5 = Load({'_L5'},phi,dphidt);

%IM2 = InductionMachine({'_IM2'},phi,dphidt);

% Modules
Modules = {G1,G2,G3,G4,G5,G6,G7,G8,G9,G10,...
    L1,L2,L3,L4,L5,...
    TL_1_2,TL_2_3,TL_3_4,TL_4_1};%...
    %IM2};
    
% Buses
Bus1 = {{G1},{G2},{G3},{TL_1_2, 'L'},{TL_4_1, 'R'},{L1}};
Bus2 = {{G4},{G5},{TL_1_2, 'R'},{TL_2_3, 'L'}, {L2}};
Bus3 = {{G6},{G7},{G10},{TL_2_3, 'R'},{TL_3_4, 'L'},{L3}};
Bus4 = {{G8},{G9},{TL_3_4, 'R'},{TL_4_1, 'L'},{L4},{L5}};
Buses = {Bus1, Bus2,Bus3,Bus4};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/Objects23.txt')
