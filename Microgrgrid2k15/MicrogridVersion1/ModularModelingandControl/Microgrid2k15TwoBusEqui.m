clear classes

syms phi dphidt real

% Generators
G22 = SM7StateControl({'_G22'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_21_22 = TransmissionLine({'_TL_21_22'},phi,dphidt);

% Loads
L21 = Load({'_L21'},phi,dphidt);
L22 = Load({'_L22'},phi,dphidt);
PV21 = Load({'_PV21'},phi,dphidt);
% Modules
Modules = {
    G22,...
    L21,...
    L22,...
    TL_21_22,...
    PV21};
    
% Buses
Bus21 = {{PV21}, {L21},{TL_21_22, 'L'}};
Bus22 = {{G22}, {L22},{TL_21_22, 'R'}};

Buses = {Bus21, Bus22};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/TwoBusEqui.txt')
