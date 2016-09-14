%%
%Case 1: When no shunt capacitance
filename = 'Voltage_withActualshunts.csv';

mpc = caseMicroUpdated;
% mpc.branch(:,4) = mpc.branch(:,4)/377;
% mpc.branch(:,5) = mpc.branch(:,5)/10;

%There has to be load shedding
% Load_change = [18;11];
% newP = mpc.baseMVA*[0;0.0485974]; newQ = mpc.baseMVA*[0;0.0022089];
% for i=1:length(Load_change)
%     indx = find(mpc.bus(:,1) == Load_change(i));
%     mpc.bus(indx,3) = newP(i); Q(indx,4) = newQ(i);
% end
%%

%Extracting powers and initialization
ybus = GeneralYbus(mpc);
% mpc.bus(17,3) = mpc.bus(17,3) + 0.3;
% mpc.bus(17,4) = mpc.bus(17,4) + 0.1;
% mpc.bus(21,3) = -1.5;
S = (mpc.bus(:,3) + 1i* mpc.bus(:,4))/mpc.baseMVA;

len = size(mpc.bus,1);

%%
%Extracting voltages
file1 = load(filename,'variable');
V = file1(:,3);

Smag = abs(S);
for i = 1:length(S)
    if(i==21)
        continue;
    else
        Yload(i) = conj(S(i))/V(i)^2;
    end
end


%%
%Adding load impedances
for i =1:len
    ybus(i,i) = ybus(i,i) + Yload(i);
end

%Kron's reduction
Nodes_stay = [1 21 22 23]; 
Nodes =  setdiff(1:23,Nodes_stay);

Yred=Kron(ybus,Nodes);

Yshunt = sum(Yred,1);
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
% Imp
% Zsh = zeros(length(Yshunt));
% for i = 1:length(Yshunt)
%     if(Yshunt(i)== 0)
%         continue;
%     else
%         Zsh = 1./Yshunt;
%     end
% end
%In order to have TL capacitances intact
Yshunt = Yshunt - [0.03 0.01 0.01 0.01];
Zsh = 1./Yshunt;
Rsh = real(Zsh); Lsh = imag(Zsh);
%%
%Loads
SL1 = V(1)^2/conj(Zsh(1));
SL21 = V(21)^2/conj(Zsh(2));
SL22 = V(22)^2/conj(Zsh(3));
SL23 = V(23)^2/conj(Zsh(4));

%Line MAx transfer
% S1_21 = V(1)*V(21)/abs(Imp(1,2))
% S1_22 = V(1)*V(22)/abs(Imp(1,3))
% S1_23 = V(1)*V(23)/abs(Imp(1,4))