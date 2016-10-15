function Y0 = GeneralYbus(mpc)
%% Calculate Admittance Matrix
% Lines
[numBus,~]=size(mpc.bus);
[numLines,~] = size(mpc.branch); % number of lines
Line.From = mpc.branch(:,1); % starting bus of lines
Line.To = mpc.branch(:,2);% ending bus of lines
Line.R = mpc.branch(:,3); % line resistance
Line.X = mpc.branch(:,4); % line reactance
Line.B = mpc.branch(:,5); % line susceptance

%Ybus formation
Y0 = zeros(numBus);
for k = 1:numBus
    checkTo = find(Line.From == k)';
    checkFrom = find(Line.To == k)';
    for m = checkTo
        Y0(k,Line.To(m)) = Y0(k, Line.To(m))- 1/(Line.R(m)+i*Line.X(m));
        Y0(k,k) = Y0(k,k) + 1/(Line.R(m)+i*Line.X(m)) + i*Line.B(m)/2;
    end
    for m = checkFrom
        Y0(k,Line.From(m)) = Y0(k,Line.From(m))-1/(Line.R(m)+i*Line.X(m));
        Y0(k,k) = Y0(k,k) + 1/(Line.R(m)+i*Line.X(m)) + i*Line.B(m)/2;
    end
end
end