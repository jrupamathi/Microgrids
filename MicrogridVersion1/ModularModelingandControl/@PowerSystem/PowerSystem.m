classdef PowerSystem < handle
    properties
        Modules;
        G;
        StateVariableDerivatives;
        StateSpace;
        DesiredStateVariableDerivatives;
        DesiredStateSpace;
        ControllableInputs
        ControlInputEquations;
        SetPointOutputs;
        SetPointOutputEquations;
        StateVariables;
        DesiredStateVariables;
    end
    methods
        function this = PowerSystem(G,Modules)
            % class constructor
            if(nargin > 0)
                this.Modules = Modules;
                this.G  = G;
                [this.StateVariableDerivatives, this.StateSpace,...
                 this.DesiredStateVariableDerivatives, this.DesiredStateSpace,...
                 this.ControllableInputs, this.ControlInputEquations,...
                 this.SetPointOutputs, this.SetPointOutputEquations,...
                 this.StateVariables, this.DesiredStateVariables] = PowerSystem.ProduceStateSpace(G,Modules);
            end
        end
    end
    methods(Static)
        function PrintStateSpace(PS,FileName)
            fileID = fopen(FileName,'w');
            for i=1:numel(PS.SetPointOutputs)
                fprintf(fileID,[char(PS.SetPointOutputs(i)),' = ' ,char(PS.SetPointOutputEquations(i)),';','\n']);
            end
            for i=1:numel(PS.ControllableInputs)
                fprintf(fileID,[char(PS.ControllableInputs(i)),' = ' ,char(PS.ControlInputEquations(i)),';','\n']);
            end
            for i=1:numel(PS.StateVariableDerivatives)
                fprintf(fileID,[char(PS.StateVariableDerivatives(i)),' = ' ,char(PS.StateSpace(i)),';','\n']);
            end
            for i=1:numel(PS.DesiredStateVariableDerivatives)
                fprintf(fileID,[char(PS.DesiredStateVariableDerivatives(i)),' = ' ,char(PS.DesiredStateSpace(i)),';','\n']);
            end
            fclose(fileID);
        end
        function PrintMFileWithStateSpace(PS,FileName)
            fileID = fopen(FileName,'w');
            %Split x vector
            for i=1:numel(PS.StateVariables)
                fprintf(fileID,[char(PS.StateVariables(i)), ' = x(', num2str(i), ');','\n']);
            end
            for i=1:numel(PS.DesiredStateVariables)
                fprintf(fileID,[char(PS.DesiredStateVariables(i)), ' = x(', num2str(i+numel(PS.StateVariables)), ');','\n']);
            end
            %Print state space
            for i=1:numel(PS.SetPointOutputs)
                fprintf(fileID,[char(PS.SetPointOutputs(i)),' = ' ,char(PS.SetPointOutputEquations(i)),';','\n']);
            end
            for i=1:numel(PS.ControllableInputs)
                fprintf(fileID,[char(PS.ControllableInputs(i)),' = ' ,char(PS.ControlInputEquations(i)),';','\n']);
            end
            for i=1:numel(PS.StateVariableDerivatives)
                fprintf(fileID,[char(PS.StateVariableDerivatives(i)),' = ' ,char(PS.StateSpace(i)),';','\n']);
            end
            for i=1:numel(PS.DesiredStateVariableDerivatives)
                fprintf(fileID,[char(PS.DesiredStateVariableDerivatives(i)),' = ' ,char(PS.DesiredStateSpace(i)),';','\n']);
            end
            %Return dx vector
            fprintf(fileID,'dx = [');
            for i=1:numel(PS.StateVariableDerivatives)
                fprintf(fileID,[char(PS.StateVariableDerivatives(i)),'\n']);
            end
            for i=1:numel(PS.DesiredStateVariableDerivatives)
                fprintf(fileID,[char(PS.DesiredStateVariableDerivatives(i)),'\n']);
            end
            fprintf(fileID,'];');
            fclose(fileID);
        end
            
        function [StateVariableDerivatives,StateSpace,DesiredStateVariableDerivatives,DesiredStateSpace,...
                 ControllableInputs, ControlInputEquations, SetPointOutputs, SetPointOutputEquations,...
                 StateVariables,DesiredStateVariables] = ProduceStateSpace(G,Modules)
            %Cobmine the state space models from all modules
            StateVariableDerivatives = [];
            StateSpace = [];
            DesiredStateVariableDerivatives = [];
            DesiredStateSpace = [];
            ControllableInputs = [];
            ControlInputEquations = [];
            SetPointOutputs = [];
            SetPointOutputEquations = [];
            StateVariables = [];
            DesiredStateVariables = [];
          
            for i = 1:numel(Modules)
                StateVariableDerivatives = [StateVariableDerivatives ; Modules{i}.StateVariableDerivatives'];
                StateSpace = [StateSpace ; Modules{i}.StateSpace];
                DesiredStateVariableDerivatives = [DesiredStateVariableDerivatives ; Modules{i}.DesiredStateVariableDerivatives'];
                DesiredStateSpace = [DesiredStateSpace ; Modules{i}.DesiredStateSpace];
                ControllableInputs = [ControllableInputs ; Modules{i}.ControllableInputs'];
                ControlInputEquations = [ControlInputEquations ; Modules{i}.ControlInputEquations];
                SetPointOutputs = [SetPointOutputs ; Modules{i}.SetPointOutputs];
                SetPointOutputEquations = [SetPointOutputEquations ; Modules{i}.SetPointOutputEquations];
                StateVariables = [StateVariables ; Modules{i}.StateVariables'];
                DesiredStateVariables = [DesiredStateVariables ; Modules{i}.DesiredStateVariables'];
            end
            
            %Form the matrices of all port voltages/currents/input/states
            I = [];
            V = [];
            PortInputs = [];
            PortStates = [];
            PortStates_Time = [];
            PortStateDerivatives = [];
            PortStateTypes = [];
            for i = 1:numel(Modules)
                %Form matrices of all port currents/voltages/states
                I = [I ; Modules{i}.PortCurrents'];
                V = [V ; Modules{i}.PortVoltages'];
                PortInputs = [PortInputs  Modules{i}.PortInputs];
                PortStates = [PortStates  Modules{i}.PortStates];
                PortStates_Time = [PortStates_Time  Modules{i}.PortStates_Time];
                PortStateDerivatives = [PortStateDerivatives  Modules{i}.PortStateDerivatives];
                PortStateTypes = [PortStateTypes  Modules{i}.PortStateTypes];
            end
            
            if ~isempty(G)
                disp('The KCL constraints between modules are')
                disp(G*I==0)
            end
            
            syms t
            PortStates_TimeDerivatives = diff(PortStates_Time,t);
            
            %For each junction, express the port inputs to one module in terms of the
            %port states of the connecting module(s)
            for row=1:size(G,1)
                RowTemp = G(row,:);
                %Find the ports at this KCL junction
                PortsAtJunction = find(RowTemp~=0);
                
                %Check for an all-capacitor loop at the junction
                AllCapacitorLoop = 0;  %if AllCapacitorLoop = 1, then all-capacitor loop
                FirstChargePortStateFound = 0;
                StateVariableIndeces = [];  %index of port state charges at the junction
                PortsToRemove = [];
                InputVariablesToSolveFor = [];  %port input charges
                for k = 1:numel(PortsAtJunction)
                    if isequal(PortStateTypes{PortsAtJunction(k)},'Charge')
                        if FirstChargePortStateFound == 0
                            StateVariableIndeces = [StateVariableIndeces ; find(StateVariableDerivatives==PortStateDerivatives(PortsAtJunction(k)))];
                            StateVariableDerivativeToSolveFor = PortStateDerivatives(PortsAtJunction(k));
                            InputVariablesToSolveFor = [InputVariablesToSolveFor ; PortInputs(PortsAtJunction(k))];
                            FirstVoltage = V(PortsAtJunction(k));
                            FirstChargePortStateFound = 1;
                            %if there's a second "charge" port at the junction, then there
                            %is at least one all-capacitor loop at the jucnction
                        else
                            AllCapacitorLoop = 1;
                            StateVariableIndeces = [StateVariableIndeces ; find(StateVariableDerivatives==PortStateDerivatives(PortsAtJunction(k)))];
                            InputVariablesToSolveFor = [InputVariablesToSolveFor ; PortInputs(PortsAtJunction(k))];
                            PortsToRemove = [PortsToRemove ; PortsAtJunction(k)];
                            SecondVoltage = V(PortsAtJunction(k));
                            VoltageEquation = FirstVoltage-SecondVoltage;
                            ChargeExpression = solve(VoltageEquation==0,PortStates(PortsAtJunction(k)));
                            
                            %Substitute PortStates(t) for PortStates before differentiating
                            Temp = subs(ChargeExpression,PortStates,PortStates_Time);
                            Temp2 = diff(Temp,t);
                            ChargeDerivativeExpression = subs(Temp2,PortStates_TimeDerivatives,PortStateDerivatives);
                            %disp(['All-Capacitor Loop: Replaced ', char(PortStates(PortsAtJunction(k))), ' with ',char(ChargeExpression),...
                            %    ' and ',char(PortStateDerivatives(PortsAtJunction(k))),' with ',char(ChargeDerivativeExpression)])
                            StateSpace = subs(StateSpace,PortStates(PortsAtJunction(k)),ChargeExpression);
                            StateVariableDerivatives = subs(StateVariableDerivatives,PortStateDerivatives(PortsAtJunction(k)),ChargeDerivativeExpression);
                        end
                    end
                end
                
                %if there is not an all-capacitor loop
                if AllCapacitorLoop == 0
                    %Find the inputs at this junction
                    InputsAtJunction = PortInputs(PortsAtJunction);
                    %Find the voltage port equations at this junction
                    VoltageEquations = [];
                    FirstVoltage = V(PortsAtJunction(1));
                    for i = 2:numel(PortsAtJunction)
                        SecondVoltage = V(PortsAtJunction(i));
                        VoltageEquations = [VoltageEquations ; FirstVoltage-SecondVoltage];
                    end
                    %Solve the KCL equation and the voltage equations at that junction for
                    %the input variables
                    EquationsAtJunction = [RowTemp*I ; VoltageEquations];
                    InputsAtJunctionCell = num2cell(InputsAtJunction);
                    InputsSolution = solve(EquationsAtJunction == 0, InputsAtJunctionCell{:});
                    StateSpace = subs(StateSpace,fieldnames(InputsSolution),struct2cell(InputsSolution));
                    %Also substitute in the port inputs in the controller equations
                    DesiredStateSpace = subs(DesiredStateSpace,fieldnames(InputsSolution),struct2cell(InputsSolution));
                    ControlInputEquations = subs(ControlInputEquations,fieldnames(InputsSolution),struct2cell(InputsSolution));
                    
                    
                    
                    %if there is an all-capacitor loop
                else
                    %We must solve a system of equations (consisting of the KCL equation
                    %and the state equations for the charges) and unknowns (consisting
                    %of the current inputs and the charge derivative which is not
                    %replaced)
                    Equations = [RowTemp*I ; StateVariableDerivatives(StateVariableIndeces)-StateSpace(StateVariableIndeces)];
                    VariablesToSolveFor = [StateVariableDerivativeToSolveFor ; InputVariablesToSolveFor];
                    VariablesToSolveForCell = num2cell(VariablesToSolveFor);
                    Solution = solve(Equations == 0, VariablesToSolveForCell{:});
                    %Put the solution for the charge derivative in the state space model
                    NewStateSpaceEquation = getfield(Solution,char(StateVariableDerivativeToSolveFor));
                    StateSpace(StateVariableIndeces(1)) = NewStateSpaceEquation;
                    %Remove the other charge derivatives equations from the state space model.
                    %(They are dependent so hence aren't states)
                    StateVariables = removerows(StateVariables,StateVariableIndeces(2:end));
                    StateSpace = removerows(StateSpace,StateVariableIndeces(2:end));
                    StateVariableDerivatives = removerows(StateVariableDerivatives,StateVariableIndeces(2:end));
                    
                    %Find the voltage equations at this junction in order to solve for
                    %the voltage inputs at the junction (don't find in terms of the
                    %charges which have already been substituted for)
                    VoltageEquations = [];
                    ValidPorts = setdiff(PortsAtJunction,PortsToRemove);
                    FirstVoltage = V(ValidPorts(1));
                    for i = 2:numel(ValidPorts)
                        SecondVoltage = V(ValidPorts(i));
                        VoltageEquations = [VoltageEquations ; FirstVoltage-SecondVoltage];
                    end
                    V_InputsAtJunction = [];
                    for i = 1:numel(ValidPorts)
                        if isequal(PortStateTypes{ValidPorts(i)},'Current')
                            V_InputsAtJunction = [V_InputsAtJunction ; PortInputs(ValidPorts(i))];
                        end
                    end
                    if ~isempty(V_InputsAtJunction)
                        V_InputsAtJunctionCell = num2cell(V_InputsAtJunction);
                        V_InputsSolution = solve(VoltageEquations == 0, V_InputsAtJunctionCell{:});
                        if ~isempty(fieldnames(V_InputsSolution))
                            StateSpace = subs(StateSpace,fieldnames(V_InputsSolution),struct2cell(V_InputsSolution));
                            DesiredStateSpace = subs(DesiredStateSpace,fieldnames(V_InputsSolution),struct2cell(V_InputsSolution));
                            ControlInputEquations = subs(ControlInputEquations,fieldnames(V_InputsSolution),struct2cell(V_InputsSolution));
                        else
                            StateSpace = subs(StateSpace,char(V_InputsAtJunction),V_InputsSolution);
                            DesiredStateSpace = subs(DesiredStateSpace,char(V_InputsAtJunction),V_InputsSolution);
                            ControlInputEquations = subs(ControlInputEquations,char(V_InputsAtJunction),V_InputsSolution);
                        end
                    end
                    
                end
            end
        end
    end
end