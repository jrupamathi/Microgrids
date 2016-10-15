clear classes

syms phi dphidt real

% Generators
G22 = SM7StateControl({'_G22'},phi,dphidt);
G23 = SM7StateControl({'_G23'},phi,dphidt);
PV21 = PVPQLoad({'_PV21'},phi,dphidt);
B20 = PVPQLoad({'_B20'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_1_20 = TransmissionLine({'_TL_1_20'},phi,dphidt);
TL_1_21 = TransmissionLine({'_TL_1_21'},phi,dphidt);
TL_20_21 = TransmissionLine({'_TL_20_21'},phi,dphidt);
TL_1_22 = TransmissionLine({'_TL_1_22'},phi,dphidt);
TL_1_23 = TransmissionLine({'_TL_1_23'},phi,dphidt);

% Loads
L1 = Load({'_L1'},phi,dphidt);
L20 = Load({'_L20'},phi,dphidt);
L21 = Load({'_L21'},phi,dphidt);
L22 = Load({'_L22'},phi,dphidt);
L23 = Load({'_L23'},phi,dphidt);

% Modules
Modules = {B20,PV21,G22,G23,...
    L1,L20,L21,L22,L23,...
    TL_1_20,TL_1_21,TL_20_21,TL_1_22,TL_1_23};
    
% Buses
Bus1 = {{L1},{TL_1_20, 'L'},{TL_1_21, 'L'},{TL_1_22, 'L'},{TL_1_23, 'L'}};
Bus20 = {{B20}, {L20},{TL_1_20,'R'},{TL_20_21,'L'}};
Bus21 = {{PV21}, {L21},{TL_1_21,'R'},{TL_20_21,'R'}};
Bus22 = {{G22}, {L22},{TL_1_22,'R'}};
Bus23 = {{G23}, {L23},{TL_1_23,'R'}};

Buses = {Bus1, Bus20, Bus21, Bus22, Bus23};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/PVRLLoadBat.txt')
