classdef PVRLLoad < Module
    methods
        function this = PVRLLoad(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'RL','LL'};
            StateVariableNames = {'iPVd','iPVq'};
            PortInputNames = {'vPVd','vPVq'};
            PortStateNames = {'iPVd','iPVq'};
            ControllableInputNames = {};
            
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(strcat(ParameterNames,IndexName)); assume(this.Parameters,'real');
            this.StateVariables = sym(strcat(StateVariableNames,IndexName)); assume(this.StateVariables,'real');
            this.ControllableInputs = sym(strcat(ControllableInputNames,IndexName));assume(this.ControllableInputs,'real');
            this.PortInputs = sym(strcat(PortInputNames,IndexName)); assume(this.PortInputs,'real');
            this.PortStates = sym(strcat(PortStateNames,IndexName)); assume(this.PortStates,'real');
            this.PortVoltages = this.PortInputs;
            this.PortCurrents = this.PortStates;
            this.StateVariableDerivatives = sym(strcat('d',StateVariableNames,IndexName,'dt')); assume(this.StateVariableDerivatives,'real');
            this.PortStateDerivatives = sym(strcat('d',PortStateNames,IndexName,'dt')); assume(this.PortStateDerivatives,'real')
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)'))); 
            this.PortStateTypes = {'Current','Current'};
            this.StateSpace = PVRLLoad.PVRLLoadDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                     this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function StateSpace = PVRLLoadDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            
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
            
            RL = Parameters(1);
            LL = Parameters(2);
            
            %PVRLLoad Dynamics
            diLddt = dphidt*iLq + (vLd - RL*iLd)/LL;
            diLqdt = (vLq - RL*iLq)/LL - dphidt*iLd;
            
            StateSpace = 377*[ diLddt ; diLqdt];
        end
    end
end