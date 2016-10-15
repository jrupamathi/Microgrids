classdef ACtoDCtoACconverter < Module
    methods
        function this = ACtoDCtoACconverter(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'R', 'C', 'L', 'RC'};
            StateVariableNames = {'id', 'iq', 'qOut'};
            PortInputNames = {'vInd', 'vInq', 'iInd', 'iInq'};
            PortStateNames = {'id','iq','qOut','qOut'};
            ControllableInputNames = {'udL','uqL','udR','uqR'};
            
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = [this.PortInputs(1),this.PortInputs(2),...
                                 this.PortStates(3)*this.ControllableInputs(3)/(2*this.Parameters(2)),...
                                 this.PortStates(3)*this.ControllableInputs(4)/(2*this.Parameters(2))];
            this.PortCurrents = [this.PortStates(1),this.PortStates(2),this.PortInputs(3),this.PortInputs(4)];
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current','Charge','Charge'};
            this.StateSpace = ACtoDCtoACconverter.ACtoDCtoACconverterDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                                             this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
                                                                         
            this.DesiredStateVariables = sym(sym(strcat(StateVariableNames(3),IndexName,'_D')),'real');
            this.DesiredStateVariableDerivatives = sym(sym(strcat('d',StateVariableNames(3),IndexName,'_D_dt')),'real');
            this.SetPoints =  sym(sym(strcat({'id', 'iq', 'vOutd', 'vOutq'},IndexName,'_star')),'real');
            [this.ControlInputEquations, this.DesiredStateSpace] = ACtoDCtoACconverter.ACtoDCtoACconverterController(this.Parameters,this.StateVariables,...
                                                    this.DesiredStateVariables,this.PortInputs,this.SetPoints,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function [ControlInputEquations, DesiredStateSpace] = ACtoDCtoACconverterController(Parameters,StateVariables,DesiredStateVariables,...
                                                                                               PortInputs,SetPoints,phi,dphidt)
            %Inputs____________________________________________
            %StateVariables: id, iq, qOut
            %DesiredStateVariables: qOut_D
            %PortInputs: vInd, vInq, iInd, iInq
            %Parameters: R, C, L, RC
            %SetPoints: id_star,iq_star,vSd_star,vSq_star
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %_________________________________________________
            
            %Outputs_________________________________________
            %ControlInputEquations: 
            %DesiredStateSpace = [ dqOut_D_dt];
            %_________________________________________________
            
            id = StateVariables(1);
            iq = StateVariables(2);
            qOut = StateVariables(3);
            
            qOut_D = DesiredStateVariables(1);
            
            vInd = PortInputs(1);
            vInq = PortInputs(2);
            iInd = PortInputs(3);
            iInq = PortInputs(4);
            
            R = Parameters(1);
            C = Parameters(2);
            L = Parameters(3);
            RL = Parameters(4);
            
            id_star = SetPoints(1);
            iq_star = SetPoints(2);
            vSd_star = SetPoints(3);
            vSq_star = SetPoints(4); 
            
            %Control Logic
            udL = (2*(C*vInd - C*R*id_star + C*L*iq_star*dphidt))/qOut_D;
            uqL = -(2*(C*R*iq_star - C*vInq + C*L*id_star*dphidt))/qOut_D;
            udR = 2*C*vSd_star/qOut;
            uqR = 2*C*vSq_star/qOut;
            
            %Desired state variable dynamics
            dqOut_D_dt = (C^2*RL*vInd*id_star*qOut - qOut*qOut_D^2 + C^2*RL*vInq*iq_star*qOut + C^2*RL*iInd*qOut_D*vSd_star + C^2*RL*iInq*qOut_D*vSq_star - C^2*R*RL*id_star^2*qOut - C^2*R*RL*iq_star^2*qOut)/(C*RL*qOut*qOut_D);
            
            ControlInputEquations = [udL ; uqL ; udR ; uqR];
            
            DesiredStateSpace = [dqOut_D_dt];
            
        end
        function [StateSpace] = ACtoDCtoACconverterDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            %Inputs____________________________________________
            %StateVariables: id, iq, qOut
            %Port Input Variables: vInd, vInq, iInd, iInq
            %Parameters: R, C, L, RL
            %Controllable Inputs: udL, uqL, udR, uqR
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %_________________________________________________
            
            %Outputs_________________________________________
            %StateSpace = [ diddt, diqdt, dqOutdt];
            %_________________________________________________
            
            id = StateVariables(1);
            iq = StateVariables(2);
            qOut = StateVariables(3);
            
            vInd = PortInputs(1);
            vInq = PortInputs(2);
            iInd = PortInputs(3);
            iInq = PortInputs(4);
            
            R = Parameters(1);
            C = Parameters(2);
            L = Parameters(3);
            RL = Parameters(4);
            
            udL = ControllableInputs(1);
            uqL = ControllableInputs(2);
            udR = ControllableInputs(3);
            uqR = ControllableInputs(4);
            
            %Transmission Line Dynamics
            diddt =  iq*dphidt - ((qOut*udL)/2 - C*vInd + C*R*id)/(C*L);
            diqdt = -id*dphidt - ((qOut*uqL)/2 - C*vInq + C*R*iq)/(C*L);
            dqOutdt = (id*udL)/2 + (iq*uqL)/2 + (iInd*udR)/2 + (iInq*uqR)/2-qOut/(C*RL);

            StateSpace = [diddt ; diqdt ; dqOutdt];  
        end
    end
end