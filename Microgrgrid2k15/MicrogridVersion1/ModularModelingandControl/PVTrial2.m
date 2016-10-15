clear classes

syms phi dphidt real

% Generators
%G23 = SM7State({'_G23'},phi,dphidt);

% Transmission Lines
% Bus 2
% TL_2_23 = TransmissionLine({'_TL_2_23'},phi,dphidt);
% TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
% TL_1_5 = TransmissionLine({'_TL_1_5'},phi,dphidt);
% TL_5_16 = TransmissionLine({'_TL_5_16'},phi,dphidt);
TL_5_21 = TransmissionLine({'_TL_5_21'},phi,dphidt);

% Loads
L2 = Load({'_L2'},phi,dphidt);
%L16 = Load({'_L16'},phi,dphidt);
PV21 = PV({'_PV21'},phi,dphidt);

% Modules
Modules = {L2,TL_5_21,...,%...
    PV21};
    
% Buses
Bus5={{L2},{TL_5_21,'L'}};
Bus21 = {{TL_5_21, 'R'},{PV21}};
Buses = {Bus5, Bus21};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/PVTrial2.txt')
