clear classes

syms phi dphidt real

% Generators
G23 = SM7State({'_G23'},phi,dphidt);
G22 = SM7State({'_G22'},phi,dphidt);

% Transmission Lines
% Bus 2
%TL_2_23 = TransmissionLine({'_TL_2_23'},phi,dphidt);
TL_1_2 = TransmissionLine({'_TL_1_2'},phi,dphidt);
TL_1_5 = TransmissionLine({'_TL_1_5'},phi,dphidt);
TL_1_14 = TransmissionLine({'_TL_1_14'},phi,dphidt);
TL_5_16 = TransmissionLine({'_TL_5_16'},phi,dphidt);
TL_5_17 = TransmissionLine({'_TL_5_17'},phi,dphidt);
TL_5_18 = TransmissionLine({'_TL_5_18'},phi,dphidt);
TL_5_19 = TransmissionLine({'_TL_5_19'},phi,dphidt);

% Loads
L2 = Load({'_L2'},phi,dphidt);
L0 = Load({'_L0'},phi,dphidt);
L16 = Load({'_L16'},phi,dphidt);
L17 = Load({'_L17'},phi,dphidt);
L18 = Load({'_L18'},phi,dphidt);
L19 = Load({'_L19'},phi,dphidt);
L14 = Load({'_L14'},phi,dphidt);

IM2 = InductionMachine({'_IM2'},phi,dphidt);
IM14 = InductionMachine({'_IM14'},phi,dphidt);

% Modules
Modules = {G23,G22,...
    L2,L16,L17,L18,L19,L14,...
    TL_5_16,TL_5_17,TL_5_18,TL_5_19,...
    IM2,IM14,L0,...
    TL_1_5,TL_1_14,TL_1_2};
    
% Buses
%Bus23 = {{G23}, {TL_2_23, 'R'}};
Bus2 = {{G23},{L2},{IM2},{TL_1_2, 'R'}};
Bus1 = {{TL_1_2, 'L'},{TL_1_5, 'L'},{L0},{G22},{TL_1_14, 'L'}};
Bus5={{TL_1_5, 'R'},{TL_5_16, 'L'},{TL_5_17, 'L'},{TL_5_18, 'L'},{TL_5_19, 'L'}};
Bus16 = {{TL_5_16, 'R'},{L16}};
Bus17 = {{TL_5_17, 'R'},{L17}};
Bus18 ={{TL_5_18, 'R'},{L18}};
Bus19 = {{TL_5_19, 'R'},{L19}};
Bus14 = {{IM14},{L14},{TL_1_14, 'R'}}
Buses = {Bus1, Bus2, Bus5, Bus16, Bus17, Bus18, Bus19,Bus14};

G = ProduceGMatrix(Modules,Buses);
 
PS = PowerSystem(G,Modules);
PS.PrintMFileWithStateSpace(PS,'Equations/Step4.txt')
