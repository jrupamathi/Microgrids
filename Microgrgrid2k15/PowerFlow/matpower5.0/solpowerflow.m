function f=solpowerflow(x, numBus, Bus, numLoad, Load, numGen, Gen, Y0)
mags = x(1:numBus);
% Convert given angles to radians
angles = x(numBus+1:2*numBus);
V0 = mags.*exp(1i*angles); % voltages in imaginary form
Ibus = Y0*V0; % bus currents
Sbus = V0.*conj(Ibus); % power injections at buses
c=[];
% set up power flow equations
for m = 1:numBus
    % active power balance in PV and PQ nodes
    if (Bus.Type(m) == 2 || Bus.Type(m) == 0)
        % given active power injections of generators
        PGen = 0;
        for p = 1:numGen
            if Gen.BusRef(p) == m
                PGen = PGen + Gen.P(p);
            end
        end
        % given active power consumptions of loads
        PLoad = 0;
        for p = 1:numLoad
            if Load.BusRef(p) == m
                PLoad = PLoad + Load.P(p);
            end
        end
        % active power balance
        c = [c; real(Sbus(m)) - PGen + PLoad];
    end
    % reactive power balance in PQ nodes
    if (Bus.Type(m) == 0)
        QGen = 0;
        for q = 1 : numGen
            if(Gen.BusRef(q) == m)
                QGen = QGen + Gen.Q(q);
            end
        end
        QLoad = 0;
        for q = 1 : numLoad
            if (Load.BusRef(q) == m)
                QLoad = QLoad + Load.Q(q);
            end
        end
        % reactive power balance
        c = [c; imag(Sbus(m)) - QGen + QLoad];
    end
    
    % voltage magnitudes in PV and slack nodes
    if (Bus.Type(m) == 1 || Bus.Type(m) == 2)
        c = [c; x(m) - Bus.Vmag(m)];
        % voltage angle in slack node
        if (Bus.Type(m) == 1)
            c = [c; x(m+numBus)-Bus.theta(m)];
        end
    end
end
f = c;
