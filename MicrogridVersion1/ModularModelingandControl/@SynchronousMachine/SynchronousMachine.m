classdef SynchronousMachine < Module
    methods
        function this = SynchronousMachine(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'LR','LS','LSS','M','RR','RS','J','tauL','B','vR'};
            StateVariableNames = {'iSd','iSq','iR','omega','theta'};
            PortInputNames = {'vSd','vSq'};
            PortStateNames = {'iSd','iSq'};
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
            this.StateSpace = SynchronousMachine.SynchronousMachineDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                                             this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function StateSpace = SynchronousMachineDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            %Inputs____________________________________________
            %StateVariables: iSd,iSq,iR,omega,theta
            %InputVariables: vSd,vSq
            %Parameters: LR,LS,LSS,M,RR,RS,J,tauL,B
            %ControllableInputs: vR
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %__________________________________________________
            
            %Outputs_________________________________________
            %StateSpace: [diSddt ; diSqdt ; diRdt ; domegadt ; dthetadt]
            %_________________________________________________
            
            iSd = StateVariables(1);
            iSq = StateVariables(2);
            iR  = StateVariables(3);
            omega = StateVariables(4);
            theta = StateVariables(5);

            vSd = PortInputs(1);
            vSq = PortInputs(2);
            
            LR = Parameters(1);
            LS = Parameters(2);
            LSS = Parameters(3);
            M = Parameters(4);
            RR = Parameters(5);
            RS = Parameters(6);
            J = Parameters(7);
            tauL = Parameters(8);
            B = Parameters(9);
            vR = Parameters(10);
            
            diSddt = (8*LR*LSS^2*vSd - 4*LR*LS^2*vSd + 3*LS*M^2*vSd - 6*LSS*M^2*vSd + 4*LR*LS^2*RS*iSd - 8*LR*LSS^2*RS*iSd - 3*LS*M^2*RS*iSd + 6*LSS*M^2*RS*iSd - 4*LR*LS^3*dphidt*iSq + 8*LR*LSS^3*dphidt*iSq - 3*LS*M^2*vSd*cos(2*phi - 2*theta) + 6*LSS*M^2*vSd*cos(2*phi - 2*theta) + 3*LS*M^2*vSq*sin(2*phi - 2*theta) - 6*LSS*M^2*vSq*sin(2*phi - 2*theta) + 6*LS^2*M^2*dphidt*iSq - 12*LSS^2*M^2*dphidt*iSq - 3*LS^2*M^2*iSq*omega + 6*LSS^2*M^2*iSq*omega + 4*LR*LS*LSS*vSd - 4*LR*LS*LSS*RS*iSd - 3*LS^2*M^2*iSd*omega*sin(2*phi - 2*theta) + 6*LSS^2*M^2*iSd*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS^2*M*vR*cos(phi - theta) - 4*6^(1/2)*LSS^2*M*vR*cos(phi - theta) + 12*LR*LS*LSS^2*dphidt*iSq - 6*LS*LSS*M^2*dphidt*iSq + 3*LS*M^2*RS*iSd*cos(2*phi - 2*theta) - 6*LSS*M^2*RS*iSd*cos(2*phi - 2*theta) + 3*LS*LSS*M^2*iSq*omega - 3*LS*M^2*RS*iSq*sin(2*phi - 2*theta) + 6*LSS*M^2*RS*iSq*sin(2*phi - 2*theta) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta) + 2*LSS^2*M^2*dphidt*iSq*cos(2*theta) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*dphidt*iSq*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*dphidt*iSq*cos(2*theta - (8*pi)/3) - 3*LS^2*M^2*iSq*omega*cos(2*phi - 2*theta) + 6*LSS^2*M^2*iSq*omega*cos(2*phi - 2*theta) - 2*6^(1/2)*LS*LSS*M*vR*cos(phi - theta) - 2*6^(1/2)*LS^2*M*RR*iR*cos(phi - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*cos(phi - theta) - 3*6^(1/2)*LS*M^3*iR*omega*sin(phi - theta) + 6*6^(1/2)*LSS*M^3*iR*omega*sin(phi - theta) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) + 3*LS*LSS*M^2*iSq*omega*cos(2*phi - 2*theta) + 3*LS*LSS*M^2*iSd*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*cos(phi - theta) + 2*6^(1/2)*LR*LS^2*M*iR*omega*sin(phi - theta) - 4*6^(1/2)*LR*LSS^2*M*iR*omega*sin(phi - theta) - 2*6^(1/2)*LR*LS*LSS*M*iR*omega*sin(phi - theta))/(8*LR*LSS^3 - 4*LR*LS^3 + 6*LS^2*M^2 - 12*LSS^2*M^2 + 12*LR*LS*LSS^2 - 6*LS*LSS*M^2 + 2*LS^2*M^2*cos(2*theta) + 2*LSS^2*M^2*cos(2*theta) + 2*LS^2*M^2*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LS*LSS*M^2*cos(2*theta) + 4*LS*LSS*M^2*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*cos(2*theta - (4*pi)/3));
            diSqdt = -(4*LR*LS^2*vSq - 8*LR*LSS^2*vSq - 4*LR*LS^2*RS*iSq + 8*LR*LSS^2*RS*iSq - 4*LR*LS^3*dphidt*iSd + 8*LR*LSS^3*dphidt*iSd - 6*LS*M^2*vSq*cos(phi - theta)^2 + 12*LSS*M^2*vSq*cos(phi - theta)^2 - 3*LS*M^2*vSd*sin(2*phi - 2*theta) + 6*LSS*M^2*vSd*sin(2*phi - 2*theta) - 18*LSS^2*M^2*dphidt*iSd - 6*LS^2*M^2*iSd*omega + 12*LSS^2*M^2*iSd*omega - 4*LR*LS*LSS*vSq + 4*LR*LS*LSS*RS*iSq - 3*LS^2*M^2*iSq*omega*sin(2*phi - 2*theta) + 6*LSS^2*M^2*iSq*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS^2*M*vR*sin(phi - theta) - 4*6^(1/2)*LSS^2*M*vR*sin(phi - theta) + 12*LR*LS*LSS^2*dphidt*iSd - 18*LS*LSS*M^2*dphidt*iSd + 6*LS*M^2*RS*iSq*cos(phi - theta)^2 - 12*LSS*M^2*RS*iSq*cos(phi - theta)^2 + 6*LS*LSS*M^2*iSd*omega + 3*LS*M^2*RS*iSd*sin(2*phi - 2*theta) - 6*LSS*M^2*RS*iSd*sin(2*phi - 2*theta) - 3*6^(1/2)*LS*M^3*iR*omega + 6*6^(1/2)*LSS*M^3*iR*omega + 4*LS^2*M^2*dphidt*iSd*cos(theta)^2 + 4*LSS^2*M^2*dphidt*iSd*cos(theta)^2 + 4*LS^2*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*dphidt*iSd*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*dphidt*iSd*cos(theta - pi/3)^2 + 4*LSS^2*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*dphidt*iSd*cos(theta - (4*pi)/3)^2 + 6*LS^2*M^2*iSd*omega*cos(phi - theta)^2 - 12*LSS^2*M^2*iSd*omega*cos(phi - theta)^2 - 2*6^(1/2)*LS*LSS*M*vR*sin(phi - theta) + 6*6^(1/2)*LS*M^3*iR*omega*cos(phi/2 - theta/2)^2 - 12*6^(1/2)*LSS*M^3*iR*omega*cos(phi/2 - theta/2)^2 - 2*6^(1/2)*LS^2*M*RR*iR*sin(phi - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*sin(phi - theta) + 8*LS*LSS*M^2*dphidt*iSd*cos(theta)^2 + 8*LS*LSS*M^2*dphidt*iSd*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 + 2*6^(1/2)*LR*LS^2*M*iR*omega - 4*6^(1/2)*LR*LSS^2*M*iR*omega - 6*LS*LSS*M^2*iSd*omega*cos(phi - theta)^2 + 3*LS*LSS*M^2*iSq*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*sin(phi - theta) - 4*6^(1/2)*LR*LS^2*M*iR*omega*cos(phi/2 - theta/2)^2 + 8*6^(1/2)*LR*LSS^2*M*iR*omega*cos(phi/2 - theta/2)^2 - 2*6^(1/2)*LR*LS*LSS*M*iR*omega + 4*6^(1/2)*LR*LS*LSS*M*iR*omega*cos(phi/2 - theta/2)^2)/(8*LR*LSS^3 - 4*LR*LS^3 - 18*LSS^2*M^2 + 12*LR*LS*LSS^2 - 18*LS*LSS*M^2 + 4*LS^2*M^2*cos(theta)^2 + 4*LSS^2*M^2*cos(theta)^2 + 4*LS^2*M^2*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*cos(theta - pi/3)^2 + 4*LSS^2*M^2*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LS*LSS*M^2*cos(theta)^2 + 8*LS*LSS*M^2*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*cos(theta - (2*pi)/3)^2);
            diRdt = -(2*LS^2*vR - 4*LSS^2*vR - 2*LS*LSS*vR - 2*LS^2*RR*iR + 4*LSS^2*RR*iR + 2*LS*LSS*RR*iR - 6^(1/2)*LS*M*vSd*cos(phi - theta) + 2*6^(1/2)*LSS*M*vSd*cos(phi - theta) + 6^(1/2)*LS*M*vSq*sin(phi - theta) - 2*6^(1/2)*LSS*M*vSq*sin(phi - theta) + 6^(1/2)*LS*M*RS*iSd*cos(phi - theta) - 2*6^(1/2)*LSS*M*RS*iSd*cos(phi - theta) - 6^(1/2)*LS*M*RS*iSq*sin(phi - theta) + 2*6^(1/2)*LSS*M*RS*iSq*sin(phi - theta) - 6^(1/2)*LS^2*M*iSq*omega*cos(phi - theta) + 2*6^(1/2)*LSS^2*M*iSq*omega*cos(phi - theta) - 6^(1/2)*LS^2*M*iSd*omega*sin(phi - theta) + 2*6^(1/2)*LSS^2*M*iSd*omega*sin(phi - theta) + 6^(1/2)*LS*LSS*M*iSq*omega*cos(phi - theta) + 6^(1/2)*LS*LSS*M*iSd*omega*sin(phi - theta))/(4*LR*LSS^2 - 2*LR*LS^2 + 3*LS*M^2 - 6*LSS*M^2 + 2*LR*LS*LSS + LS*M^2*cos(2*theta) + LSS*M^2*cos(2*theta) + LS*M^2*cos(2*theta - (4*pi)/3) + LS*M^2*cos(2*theta - (8*pi)/3) + 2*LSS*M^2*cos(2*theta - (2*pi)/3) + LSS*M^2*cos(2*theta - (4*pi)/3) - LSS*M^2*cos(2*theta - (8*pi)/3));
            domegadt = -(tauL + B*omega - (6^(1/2)*M*iR*iSq*cos(phi - theta))/2 - (6^(1/2)*M*iR*iSd*sin(phi - theta))/2)/J;
            dthetadt = omega;

            StateSpace = [diSddt ; diSqdt ; diRdt ; domegadt ; dthetadt];
        end
    end
end