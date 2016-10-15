classdef FlywheelSM < Module
    methods
        function this = FlywheelSM(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'LR','LS','LSS','M','RR','RS','J','tauL','B','vR'};
            ControllerGainNames = {'Kp','Ki'};
            StateVariableNames = {'iSd','iSq','iR','omega','theta','omegaInt'};
            PortInputNames = {'vSd','vSq'};
            PortStateNames = {'iSd','iSq'};
            ControllableInputNames = {};

            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.ControllerGains = sym(sym(strcat(ControllerGainNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = this.PortInputs;
            this.PortCurrents = this.PortStates;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
            
            this.DesiredStateVariables = sym(sym(strcat(StateVariableNames(1),IndexName,'_D')),'real');
            this.DesiredStateVariableDerivatives = sym(sym(strcat('d',StateVariableNames(1),IndexName,'_D_dt')),'real');
            this.SetPoints =  sym(sym(strcat({'iR', 'omega'},IndexName,'_star')),'real');
            this.SetPointOutputs = sym(sym(strcat({'vSd','vSq'},IndexName,'_star')),'real');
            
            this.StateSpace = FlywheelSM.FlywheelSMDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                             this.PortInputs,this.SetPoints,this.RefFrameAngle,this.RefFrameSpeed);
                                                     
            [this.DesiredStateSpace, this.SetPointOutputEquations] = FlywheelSM.FlywheelSMController(this.Parameters,this.StateVariables,...
                            this.ControllerGains,this.DesiredStateVariables,this.PortInputs,this.SetPoints,this.RefFrameAngle,this.RefFrameSpeed);
                                           
        end
    end
    methods(Static)
        function [DesiredStateSpace, SetPointOutputEquations] = FlywheelSMController(Parameters,StateVariables,ControllerGains,...
                                                                 DesiredStateVariables,PortInputs,SetPoints,phi,dphidt)
            %Inputs____________________________________________
            %StateVariables: iSd,iSq,iR,omega,theta,omegaInt,iSq_D
            %PortInputs: vSd,vSq
            %Parameters: LR,LS,LSS,M,RR,RS,J,tauL,B,vR
            %SetPoints: iR_star, omega_star
            %phi: angle of rotating starerence frame
            %dphidt: speed of rotating starerence frame
            %__________________________________________________
            
            %Outputs_________________________________________
            %DesiredStateSpace: diSq_D_dt
            %SetPointOutputEquations: vSd_star ; vSq_star (goes to power electronics controller)
            %_________________________________________________
            
            iSd = StateVariables(1);
            iSq = StateVariables(2);
            iR  = StateVariables(3);
            omega = StateVariables(4);
            theta = StateVariables(5);
            omegaInt = StateVariables(6);
            
            iSd_D = DesiredStateVariables(1);

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
            
            iR_star = SetPoints(1);
            omega_star = SetPoints(2);
            
            Kp = ControllerGains(1);
            Ki = ControllerGains(2);
            
            syms t
            Te_star = Kp*(omega_star-omega)+Ki*omegaInt;
            
            vSd_star = - (6^(1/2)*(2*LS*RR*iR_star - 2*LSS*vR - 2*LS*vR + 2*LSS*RR*iR_star - 6^(1/2)*M*RS*iSd + 6^(1/2)*LS*M*iSq*omega + 6^(1/2)*LSS*M*iSq*omega))/(6*M) - (6^(1/2)*(3*M^2*RR*iR - 3*M^2*RR*iR_star))/(6*LR*M);
            vSq_star = omega*(LS*iSd_D + LSS*iSd_D + (6^(1/2)*M*iR)/2) + (2^(1/2)*3^(1/2)*RS*Te_star)/(3*M*iR_star);
            diSd_D_dt = ((6^(1/2)*LS*Te_star*omega)/3 - (6^(1/2)*LSS*RR*iR_star^2)/3 - (6^(1/2)*LS*RR*iR_star^2)/3 + (6^(1/2)*LSS*Te_star*omega)/3 + (6^(1/2)*LS*iR_star*vR)/3 + (6^(1/2)*LSS*iR_star*vR)/3)/(M*iR_star*(LS + LSS)) - (RS*iR_star*iSd_D - RS*iR_star*iSd + LS*iR_star*iSq*omega + LSS*iR_star*iSq*omega)/(iR_star*(LS + LSS));

            DesiredStateSpace = [diSd_D_dt];
            
            SetPointOutputEquations = [vSd_star ; vSq_star]; 
        end
        
        function StateSpace = FlywheelSMDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,SetPoints,phi,dphidt)
            %Inputs____________________________________________
            %StateVariables: iSd,iSq,iR,omega,theta,omegaInt
            %InputVariables: vSd,vSq
            %Parameters: LR,LS,LSS,M,RR,RS,J,tauL,B
            %ControllableInputs: vR
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %__________________________________________________
            
            %Outputs_________________________________________
            %StateSpace: [diSddt ; diSqdt ; diRdt ; domegadt ; dthetadt ; domegaIntdt]
            %_________________________________________________
            
            iSd = StateVariables(1);
            iSq = StateVariables(2);
            iR  = StateVariables(3);
            omega = StateVariables(4);
            theta = StateVariables(5);
            omegaInt = StateVariables(6);
            
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
            
            omega_star = SetPoints(2);
            
            diSddt = (8*LR*LSS^2*vSd - 4*LR*LS^2*vSd + 3*LS*M^2*vSd - 6*LSS*M^2*vSd + 4*LR*LS^2*RS*iSd - 8*LR*LSS^2*RS*iSd - 3*LS*M^2*RS*iSd + 6*LSS*M^2*RS*iSd - 4*LR*LS^3*dphidt*iSq + 8*LR*LSS^3*dphidt*iSq - 3*LS*M^2*vSd*cos(2*phi - 2*theta) + 6*LSS*M^2*vSd*cos(2*phi - 2*theta) + 3*LS*M^2*vSq*sin(2*phi - 2*theta) - 6*LSS*M^2*vSq*sin(2*phi - 2*theta) + 6*LS^2*M^2*dphidt*iSq - 12*LSS^2*M^2*dphidt*iSq - 3*LS^2*M^2*iSq*omega + 6*LSS^2*M^2*iSq*omega + 4*LR*LS*LSS*vSd - 4*LR*LS*LSS*RS*iSd - 3*LS^2*M^2*iSd*omega*sin(2*phi - 2*theta) + 6*LSS^2*M^2*iSd*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS^2*M*vR*cos(phi - theta) - 4*6^(1/2)*LSS^2*M*vR*cos(phi - theta) + 12*LR*LS*LSS^2*dphidt*iSq - 6*LS*LSS*M^2*dphidt*iSq + 3*LS*M^2*RS*iSd*cos(2*phi - 2*theta) - 6*LSS*M^2*RS*iSd*cos(2*phi - 2*theta) + 3*LS*LSS*M^2*iSq*omega - 3*LS*M^2*RS*iSq*sin(2*phi - 2*theta) + 6*LSS*M^2*RS*iSq*sin(2*phi - 2*theta) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta) + 2*LSS^2*M^2*dphidt*iSq*cos(2*theta) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*dphidt*iSq*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*dphidt*iSq*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*dphidt*iSq*cos(2*theta - (8*pi)/3) - 3*LS^2*M^2*iSq*omega*cos(2*phi - 2*theta) + 6*LSS^2*M^2*iSq*omega*cos(2*phi - 2*theta) - 2*6^(1/2)*LS*LSS*M*vR*cos(phi - theta) - 2*6^(1/2)*LS^2*M*RR*iR*cos(phi - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*cos(phi - theta) - 3*6^(1/2)*LS*M^3*iR*omega*sin(phi - theta) + 6*6^(1/2)*LSS*M^3*iR*omega*sin(phi - theta) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*dphidt*iSq*cos(2*theta - (4*pi)/3) + 3*LS*LSS*M^2*iSq*omega*cos(2*phi - 2*theta) + 3*LS*LSS*M^2*iSd*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*cos(phi - theta) + 2*6^(1/2)*LR*LS^2*M*iR*omega*sin(phi - theta) - 4*6^(1/2)*LR*LSS^2*M*iR*omega*sin(phi - theta) - 2*6^(1/2)*LR*LS*LSS*M*iR*omega*sin(phi - theta))/(8*LR*LSS^3 - 4*LR*LS^3 + 6*LS^2*M^2 - 12*LSS^2*M^2 + 12*LR*LS*LSS^2 - 6*LS*LSS*M^2 + 2*LS^2*M^2*cos(2*theta) + 2*LSS^2*M^2*cos(2*theta) + 2*LS^2*M^2*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LS*LSS*M^2*cos(2*theta) + 4*LS*LSS*M^2*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*cos(2*theta - (4*pi)/3));
            diSqdt = -(4*LR*LS^2*vSq - 8*LR*LSS^2*vSq - 4*LR*LS^2*RS*iSq + 8*LR*LSS^2*RS*iSq - 4*LR*LS^3*dphidt*iSd + 8*LR*LSS^3*dphidt*iSd - 6*LS*M^2*vSq*cos(phi - theta)^2 + 12*LSS*M^2*vSq*cos(phi - theta)^2 - 3*LS*M^2*vSd*sin(2*phi - 2*theta) + 6*LSS*M^2*vSd*sin(2*phi - 2*theta) - 18*LSS^2*M^2*dphidt*iSd - 6*LS^2*M^2*iSd*omega + 12*LSS^2*M^2*iSd*omega - 4*LR*LS*LSS*vSq + 4*LR*LS*LSS*RS*iSq - 3*LS^2*M^2*iSq*omega*sin(2*phi - 2*theta) + 6*LSS^2*M^2*iSq*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS^2*M*vR*sin(phi - theta) - 4*6^(1/2)*LSS^2*M*vR*sin(phi - theta) + 12*LR*LS*LSS^2*dphidt*iSd - 18*LS*LSS*M^2*dphidt*iSd + 6*LS*M^2*RS*iSq*cos(phi - theta)^2 - 12*LSS*M^2*RS*iSq*cos(phi - theta)^2 + 6*LS*LSS*M^2*iSd*omega + 3*LS*M^2*RS*iSd*sin(2*phi - 2*theta) - 6*LSS*M^2*RS*iSd*sin(2*phi - 2*theta) - 3*6^(1/2)*LS*M^3*iR*omega + 6*6^(1/2)*LSS*M^3*iR*omega + 4*LS^2*M^2*dphidt*iSd*cos(theta)^2 + 4*LSS^2*M^2*dphidt*iSd*cos(theta)^2 + 4*LS^2*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*dphidt*iSd*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*dphidt*iSd*cos(theta - pi/3)^2 + 4*LSS^2*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*dphidt*iSd*cos(theta - (4*pi)/3)^2 + 6*LS^2*M^2*iSd*omega*cos(phi - theta)^2 - 12*LSS^2*M^2*iSd*omega*cos(phi - theta)^2 - 2*6^(1/2)*LS*LSS*M*vR*sin(phi - theta) + 6*6^(1/2)*LS*M^3*iR*omega*cos(phi/2 - theta/2)^2 - 12*6^(1/2)*LSS*M^3*iR*omega*cos(phi/2 - theta/2)^2 - 2*6^(1/2)*LS^2*M*RR*iR*sin(phi - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*sin(phi - theta) + 8*LS*LSS*M^2*dphidt*iSd*cos(theta)^2 + 8*LS*LSS*M^2*dphidt*iSd*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*dphidt*iSd*cos(theta - (2*pi)/3)^2 + 2*6^(1/2)*LR*LS^2*M*iR*omega - 4*6^(1/2)*LR*LSS^2*M*iR*omega - 6*LS*LSS*M^2*iSd*omega*cos(phi - theta)^2 + 3*LS*LSS*M^2*iSq*omega*sin(2*phi - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*sin(phi - theta) - 4*6^(1/2)*LR*LS^2*M*iR*omega*cos(phi/2 - theta/2)^2 + 8*6^(1/2)*LR*LSS^2*M*iR*omega*cos(phi/2 - theta/2)^2 - 2*6^(1/2)*LR*LS*LSS*M*iR*omega + 4*6^(1/2)*LR*LS*LSS*M*iR*omega*cos(phi/2 - theta/2)^2)/(8*LR*LSS^3 - 4*LR*LS^3 - 18*LSS^2*M^2 + 12*LR*LS*LSS^2 - 18*LS*LSS*M^2 + 4*LS^2*M^2*cos(theta)^2 + 4*LSS^2*M^2*cos(theta)^2 + 4*LS^2*M^2*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*cos(theta - pi/3)^2 + 4*LSS^2*M^2*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LS*LSS*M^2*cos(theta)^2 + 8*LS*LSS*M^2*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*cos(theta - (2*pi)/3)^2);
            diRdt = -(2*LS^2*vR - 4*LSS^2*vR - 2*LS*LSS*vR - 2*LS^2*RR*iR + 4*LSS^2*RR*iR + 2*LS*LSS*RR*iR - 6^(1/2)*LS*M*vSd*cos(phi - theta) + 2*6^(1/2)*LSS*M*vSd*cos(phi - theta) + 6^(1/2)*LS*M*vSq*sin(phi - theta) - 2*6^(1/2)*LSS*M*vSq*sin(phi - theta) + 6^(1/2)*LS*M*RS*iSd*cos(phi - theta) - 2*6^(1/2)*LSS*M*RS*iSd*cos(phi - theta) - 6^(1/2)*LS*M*RS*iSq*sin(phi - theta) + 2*6^(1/2)*LSS*M*RS*iSq*sin(phi - theta) - 6^(1/2)*LS^2*M*iSq*omega*cos(phi - theta) + 2*6^(1/2)*LSS^2*M*iSq*omega*cos(phi - theta) - 6^(1/2)*LS^2*M*iSd*omega*sin(phi - theta) + 2*6^(1/2)*LSS^2*M*iSd*omega*sin(phi - theta) + 6^(1/2)*LS*LSS*M*iSq*omega*cos(phi - theta) + 6^(1/2)*LS*LSS*M*iSd*omega*sin(phi - theta))/(4*LR*LSS^2 - 2*LR*LS^2 + 3*LS*M^2 - 6*LSS*M^2 + 2*LR*LS*LSS + LS*M^2*cos(2*theta) + LSS*M^2*cos(2*theta) + LS*M^2*cos(2*theta - (4*pi)/3) + LS*M^2*cos(2*theta - (8*pi)/3) + 2*LSS*M^2*cos(2*theta - (2*pi)/3) + LSS*M^2*cos(2*theta - (4*pi)/3) - LSS*M^2*cos(2*theta - (8*pi)/3));
            domegadt = -(tauL + B*omega - (6^(1/2)*M*iR*iSq*cos(phi - theta))/2 - (6^(1/2)*M*iR*iSd*sin(phi - theta))/2)/J;
            dthetadt = omega;
            domegaIntdt = omega_star-omega;
            
            StateSpace = [diSddt ; diSqdt ; diRdt ; domegadt ; dthetadt ; domegaIntdt];
        end
    end
end