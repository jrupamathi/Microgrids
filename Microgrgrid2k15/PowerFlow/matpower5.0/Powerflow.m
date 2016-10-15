run 'ieeecase30.m';
% Bus
numBus = length(busdata); % number of buses
Bus.Type = busdata(:,2); % 2: PV, 0: PQ, 1: slack
Bus.Vmag = busdata(:,3); % voltage magnitude at buses
Bus.theta = busdata(:,4)*pi/180; % voltage angle at buses

% Loads
numLoad=0;

Load.P=[];
Load.Q=[];
Load.BusRef=[];
numGen=0;
Gen.P=[];
Gen.Q=[];
Gen.BusRef=[];
Gen.Lower=[];
Gen.Upper=[];
for i=1:numBus
    if(busdata(i,5)~=0||busdata(i,6)~=0)
    numLoad = numLoad+1; % number of loads
    Load.P = [Load.P;busdata(i,5) ]; % active power consumption by loads
    Load.Q = [Load.Q;busdata(i,6) ]; % reactive power consumption by loads
    Load.BusRef = [Load.BusRef;busdata(i,1)]; % buses to which loads are connected
    end

    if(busdata(i,2)==2)
    numGen=numGen+1;
    Gen.P = [Gen.P;busdata(i,7) ]; % active power consumption by loads
    Gen.Q = [Gen.Q;busdata(i,8) ]; % reactive power consumption by loads
    Gen.BusRef = [Gen.BusRef;busdata(i,1)]; % buses to which loads are connected
    Gen.Lower = [Gen.Lower;busdata(i,9)]; % buses to which loads are connected    
    Gen.Upper = [Gen.Upper;busdata(i,10)]; % buses to which loads are connected    
    end
end

% Lines
numLines = length(linedata); % number of lines
Line.From = linedata(:,1); % starting bus of lines
Line.To = linedata(:,2); % ending bus of lines
Line.R = linedata(:,3); % line resistance
Line.X = linedata(:,4); % line reactance
Line.B = linedata(:,5); % line susceptance

% Calculate Admittance Matrix
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

x = fsolve(@(x)solpowerflow(x, numBus, Bus, numLoad, Load, numGen, Gen, Y0),[ones(numBus,1);zeros(numBus,1)]) ;
