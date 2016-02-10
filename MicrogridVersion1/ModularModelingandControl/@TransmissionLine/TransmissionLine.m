classdef TransmissionLine < Module
    methods
        function this = TransmissionLine(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'RTL','CTL','LTL'};
            StateVariableNames = {'vTLLd','vTLLq','iTLMd','iTLMq','vTLRd','vTLRq'};
            PortInputNames = {'iInLd', 'iInLq', 'iInRd', 'iInRq'};
            PortStateNames = {'vTLLd','vTLLq','vTLRd','vTLRq'};
            ControllableInputNames = {};
                        
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = this.PortStates;
            this.PortCurrents = this.PortInputs;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Charge','Charge','Charge','Charge'};
            this.StateSpace = TransmissionLine.TransmissionLineDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                                             this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function [StateSpace] = TransmissionLineDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            
            %Inputs____________________________________________
            %StateVariables: qTLLd,qTLLq,iTLMd,iTLMq,qTLRd,qTLRq
            %InputVariables: iInLd, iInLq, iInRd, iInRq
            %Parameters: RTL, CTL, LTL
            %_________________________________________________
            
            %Outputs_________________________________________
            %StateSpace = [ dqTLLddt,dqTLLqdt,diTLMddt,diTLMqdt,dqTLRddt,dqTLRqdt];
            %_________________________________________________
            
            vTLLd = StateVariables(1);
            vTLLq = StateVariables(2);
            iTLMd = StateVariables(3);
            iTLMq = StateVariables(4);
            vTLRd = StateVariables(5);
            vTLRq = StateVariables(6);
            
            iInLd = PortInputs(1);
            iInLq = PortInputs(2);
            iInRd = PortInputs(3);
            iInRq = PortInputs(4);
            
            RTL = Parameters(1);
            CTL = Parameters(2);
            LTL = Parameters(3);
            
            %vTLLd = 1; vTLLq = 0;
            %Transmission Line Dynamics
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
            StateSpace = 377*[ dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt ; dvTLRddt ; dvTLRqdt];           
        end
    end
end