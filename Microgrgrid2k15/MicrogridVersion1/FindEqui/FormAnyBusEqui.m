function FormAnyBusEqui(status,solver, PVbus,file2)
addpath('../Parameters/')
% switch solver 
%     case 'NETSS'
%         switch status
%             case 'inter'
%                 filename1 = 'RedBookBranchDataFile/Micro15_CONNgen.txt';
%                 filename2 = 'RedBookBranchDataFile/Microgrid15_CONNvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%             case 'iso'
%                 filename1 = 'RedBookBranchDataFile/Micro15_islandgen.txt';
%                 filename2 = 'RedBookBranchDataFile/Microgrid15_islandvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%         end
%     case 'MATPOWER'
%         switch status
%             case 'inter'
%                 filename1 = 'RedBookBranchDataFile/MATMicro15_CONNgen.txt';
%                 filename2 = 'RedBookBranchDataFile/MATMicrogrid15_CONNvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%             case 'iso'
%                 filename1 = 'RedBookBranchDataFile/MATMicro15_islandgen.txt';
%                 filename2 = 'RedBookBranchDataFile/MATMicrogrid15_islandvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%         end
% end

V = file2(:,2);
if strcmp(PVbus,'slack')
    V = file2(:,4);
end
     
mpc = caseMicroUpdated;
mpc.branch(:,4) = mpc.branch(:,4)/1;
filenameShed = '';

%In case of loadshedding
if(~isempty(filenameShed))
    file3 = load(filenameShed,'variable');
    %There has to be load shedding
    Load_change = file3(:,1);
    newRealP = file3(:,4)*mpc.baseMVA;
    newReacQ = file3(:,6)*mpc.baseMVA;

    newP = newRealP; newQ = newReacQ;
    for i=1:length(Load_change)
        indx = find(mpc.bus(:,1) == Load_change(i));
        mpc.bus(indx,3) = newP(i); mpc.bus(indx,4) = newQ(i);
    end
end

%If any shunt Cap
%For shunt capacitance
shuntCapNodes = [];
Csh = [0.1042];
% Csh = [0.1385];
for i = 1:length(shuntCapNodes)
    indx = find(mpc.bus(:,1) == shuntCapNodes(i));
    mpc.bus(indx,4) = mpc.bus(indx,4) - V(shuntCapNodes(i))^2*Csh(i);
end
%%

%Extracting powers and initialization
a = mpc;
ybus_sparse = makeYbus(a.baseMVA,a.bus,a.branch);
ybus = full(ybus_sparse);
P = mpc.bus(:,3)/mpc.baseMVA; Q = mpc.bus(:,4)/mpc.baseMVA;
S = (P + 1i* Q);

%%
for i = 1:length(S)
    if(i==21)
        continue;
    else
        Yload(i) = conj(S(i))/(V(i))^2;
    end
end

%%
%Adding load impedances
for i =1:length(S)
    ybus(i,i) = ybus(i,i) + Yload(i);
end

%Kron's reduction
Nodes_stay = [1 21 22 23]; 
Nodes =  setdiff(1:23,Nodes_stay);

Yred=Kron(ybus,Nodes);

Yshunt = sum(Yred,1)
%%
Imp = zeros(length(Yred),length(Yred));
R = zeros(length(Yred),length(Yred));
L = zeros(length(Yred),length(Yred));
for i = 1:length(Yred)
    for j = 1:length(Yred)
        if(Yred(i,j)==0)
            continue;
        else
            Imp(i,j) = -1./Yred(i,j);
            R(i,j) = real(Imp(i,j));
            L(i,j) = imag(Imp(i,j));
        end        
    end
end

%In order to have TL capacitances intact
Yc = 0.001*ones(3,1);
Yshunt = Yshunt - 1i*[0.003 0.001 0.001 0.001];
[a,b] = find(imag(Yshunt)>0);
Yc(b) = imag(Yshunt(b)) + 0.01;
Yshunt(b) = real(Yshunt(b))-1i*0.01;
Zsh = 1./Yshunt;
Rsh = real(Zsh); Lsh = imag(Zsh);
%%
% %Loads
SL1 = V(1)^2/conj(Zsh(1));
SL21 = V(21)^2/conj(Zsh(2));
SL22 = V(22)^2/conj(Zsh(3));
SL23 = V(23)^2/conj(Zsh(4));

%Line MAx transfer
% S1_21 = V(1)*V(21)/abs(Imp(1,2))
% S1_22 = V(1)*V(22)/abs(Imp(1,3))
% S1_23 = V(1)*V(23)/abs(Imp(1,4))
%%s
%For the case of voltage with shunts
RL_PV21 = P(21)*V(21)^2/(P(21)^2+Q(21)^2);
LL_PV21 =(Q(21))*V(21)^2/(P(21)^2+Q(21)^2);
save('PV21.mat', 'RL_PV21', 'LL_PV21');

RTL_TL_1_21 = R(1,2);
LTL_TL_1_21 = L(1,2);
CTL_TL_1_21 = Yc(1);

RTL_TL_1_22 = R(1,3);
LTL_TL_1_22 = L(1,3);
CTL_TL_1_22 = Yc(2);

RTL_TL_1_23 = R(1,4);
LTL_TL_1_23 = L(1,4);
CTL_TL_1_23 = Yc(3);

save('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
save('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
save('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

RL_L21 = real(Zsh(2));
LL_L21 = imag(Zsh(2));
save('L21.mat', 'RL_L21', 'LL_L21');

RL_L22 = real(Zsh(3));
LL_L22 = imag(Zsh(3));
save('L22.mat', 'RL_L22', 'LL_L22');

RL_L23 = real(Zsh(4));
LL_L23 = imag(Zsh(4));
save('L23.mat', 'RL_L23', 'LL_L23');

RL_L1 = real(Zsh(1));
LL_L1 = imag(Zsh(1));
save('L1.mat', 'RL_L1', 'LL_L1');
