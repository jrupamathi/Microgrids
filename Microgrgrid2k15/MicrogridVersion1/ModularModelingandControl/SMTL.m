clear classes

syms phi dphidt real

% Generators
G23 = SM7StateControl({'_G23'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_1_23 = TransmissionLine({'_TL_1_23'},phi,dphidt);

% Loads
L1 = Load({'_L1'},phi,dphidt);
% Modules
Modules = {
    G23,...
    L1,...
    TL_1_23 };
    
% Buses
Bus23 = {{G23}, {TL_1_23, 'R'}};
Bus2 = {{TL_1_23, 'L'}, {L1}};

Buses = {Bus2, Bus23};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/SMTL.txt')
