function G  = ProduceGMatrix(Modules,Buses)

%Forms the G-matrix for the system given
    %Modules: ordered list of all modules in system
    %Buses: a cell array containing each individual Bus with unordered list
    %of modules at the Bus

G = [];
for i = 1:numel(Buses)
    Bus = Buses{i};
    GTemp = [];
    %Iterate through the Modules
    for j = 1:numel(Modules)
        Side = [];
        %Find if Module has two ports per phase, ie TL
        if isa(Modules{j},'TransmissionLine')
            TwoPortModule = 1;
        else
            TwoPortModule = 0;
        end
        %Find if Module is in Bus
        Member = 0;
        for k = 1:numel(Bus)
            if isequal(Modules{j},Bus{k}{1})
                Member = 1;
                if TwoPortModule == 1
                    Side = Bus{k}{2};
                end
            end
        end
        switch Member
            case 1  %if Module is in Bus
                switch TwoPortModule
                    case 1 %if Module has two ports
                        switch Side
                            case 'L'
                                Modules{j}.GTemp = [1 0 0 0 ; 0 1 0 0];
                            case 'R'
                                Modules{j}.GTemp = [0 0 1 0 ; 0 0 0 1];
                            otherwise
                                disp('Invalid Port Reference')
                        end
                    case 0 %if Module has only one port
                        Modules{j}.GTemp = [1 0 ; 0 1];
                end
            case 0  %if Module is not in Bus
                switch TwoPortModule
                    case 1 %if Module has two ports
                        Modules{j}.GTemp = [0 0 0 0 ; 0 0 0 0];
                    case 0 %if Module has
                        Modules{j}.GTemp = [0 0 ; 0 0];
                end
        end
        GTemp = [GTemp, Modules{j}.GTemp];
    end
G = [G ; GTemp];
end