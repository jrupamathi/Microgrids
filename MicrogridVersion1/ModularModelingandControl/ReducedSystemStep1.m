clear classes

syms phi dphidt real

% Generators
G23 = SM7State1({'_G23'},phi,dphidt);

% Transmission Lines
% Bus 2
TL_2_23 = TransmissionLine({'_TL_2_23'},phi,dphidt);
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_1_5 = TransmissionLine({'_TL_1_5'},phi,dphidt);
TL_5_16 = TransmissionLine({'_TL_5_16'},phi,dphidt);

% Loads
L2 = Load({'_L2'},phi,dphidt);
L0 = Load({'_L0'},phi,dphidt);
L16 = Load({'_L16'},phi,dphidt);
%IM2 = InductionMachine({'_IM2'},phi,dphidt);

% Modules
Modules = {G23,...
    L2,L0,L16,...
    TL_2_23,TL_1_2,TL_1_5,TL_5_16},%...
    %IM2};
    
% Buses
Bus23 = {{G23}, {TL_2_23, 'R'}};
Bus2 = {{TL_2_23, 'L'}, {L2},{TL_1_2,'R'}};
Bus1 = {{TL_1_2, 'L'},{TL_1_5, 'L'},{L0}};
Bus5={{TL_1_5, 'R'},{TL_5_16, 'L'}};
Bus16 = {{TL_5_16, 'R'},{L16}};
Buses = {Bus1, Bus2, Bus5, Bus16, Bus23};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/Step1.txt')
