classdef PQLoad < Module
    methods
        function this = PQLoad(IndexName,RefFrameAngle,RefFrameSpeed,BaseSpeed)
            ParameterNames={'PL','QL'};
            StateVariableNames = {'iLd','iLq'};
            PortInputNames = {'vLd','vLq'};
            PortStateNames = {'iLd','iLq'};
            ControllableInputNames = {};
            
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = this.PortInputs;
            this.PortCurrents = this.PortStates;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
            this.StateSpace = PQLoad.PQLoadDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                     this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function StateSpace = PQLoadDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            
            %Inputs____________________________________________
            %Parameters: RL, LL
            %StateVariables: iLd,iLq
            %PortInputs: vLd,vLq
            %ControllabeInputs: none
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %_________________________________________________
            
            %Outputs_________________________________________
            %StateSpace = [ diLddt ; diLqdt];
            %_________________________________________________
            
            iLd = StateVariables(1);
            iLq = StateVariables(2);
            
            vLd = PortInputs(1);
            vLq = PortInputs(2);
            
            PL = Parameters(1);
            QL = Parameters(2);
            
            Zeq = (abs(vLd + 1i*vLq)^2)/(PL - 1i*QL);
            RL=real(Zeq); LL = imag(Zeq);
            %Transmission Line Dynamics
            diLddt = dphidt*iLq + (vLd - RL*iLd)/LL;
            diLqdt = (vLq - RL*iLq)/LL - dphidt*iLd;
            
            StateSpace =377*[ diLddt ; diLqdt];
        end
    end
end