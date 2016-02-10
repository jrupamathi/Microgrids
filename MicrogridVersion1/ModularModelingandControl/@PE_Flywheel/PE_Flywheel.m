classdef PE_Flywheel < Module
    methods
        function this = PE_Flywheel(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'R', 'C', 'L', 'RC', 'LR','LS','LSS','M','RR','RS','J','tauL','B','vR','PercentMax'};
            StateVariableNames = {'id', 'iq', 'qC','iSd','iSq','iR','omega','theta','omegaInt','omega_ref'};
            ControllerGainNames = {'Kp','Ki','Ks'};
            ControllableInputNames = {'udL','uqL','udR','uqR'};
            PortInputNames = {'vInd', 'vInq'};
            PortStateNames = {'id','iq'};
            
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.ControllerGains = sym(sym(strcat(ControllerGainNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = [this.PortInputs(1),this.PortInputs(2)];
            this.PortCurrents = [this.PortStates(1),this.PortStates(2)];
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
            
            this.DesiredStateVariables = sym(sym(strcat({'qC','iSd'},IndexName,'_D')),'real');
            this.DesiredStateVariableDerivatives = sym(sym(strcat('d',{'qC','iSd'},IndexName,'_D_dt')),'real');
            this.SetPoints =  sym(sym(strcat({'id', 'iq', 'iR'},IndexName,'_ref')),'real');
            
            this.StateSpace = PE_Flywheel.PE_FlywheelDynamics(this);

            [this.ControlInputEquations, this.DesiredStateSpace] = PE_Flywheel.PE_FlywheelController(this);
        end
    end
    methods(Static)
        function [ControlInputEquations, DesiredStateSpace] = PE_FlywheelController(this)
            %Inputs____________________________________________
            %StateVariables: id, iq, qC, iSd, iSq, iR, omega, theta, omegaInt
            %DesiredStateVariables: qC_D, iSd_D
            %Port Input Variables: vInd, vInq
            %Parameters: R, C, L, RC, LR, LS, LSS, M, RR, RS, J, tauL, B
            %Controllable Inputs: udL, uqL, udR, uqR
            %SetPoints: id_ref,iq_ref,vSd_ref,vSq_ref
            %phi: angle of rotating reference frame
            %dphidt: speed of rotating reference frame
            %_________________________________________________
            
            %Outputs_________________________________________
            %ControlInputEquations: 
            %DesiredStateSpace = [ dqC_D_dt ; diSd_D_dt];
            %_________________________________________________
            
            phi1 = this.RefFrameAngle(1);
            phi2 = this.RefFrameAngle(2);
            
            dphi1dt = this.RefFrameSpeed(1);
            dphi2dt = this.RefFrameSpeed(2);
            
            R = this.Parameters(1);
            C = this.Parameters(2);
            L = this.Parameters(3);
            RC = this.Parameters(4);
            LR = this.Parameters(5);
            LS = this.Parameters(6);
            LSS = this.Parameters(7);
            M = this.Parameters(8);
            RR = this.Parameters(9);
            RS = this.Parameters(10);
            J = this.Parameters(11);
            tauL = this.Parameters(12);
            B = this.Parameters(13);            
            vR = this.Parameters(14);
            PercentMax = this.Parameters(15);
            
            id = this.StateVariables(1);
            iq = this.StateVariables(2);
            qC = this.StateVariables(3);
            iSd = this.StateVariables(4);
            iSq = this.StateVariables(5);
            iR  = this.StateVariables(6);
            omega = this.StateVariables(7);
            theta = this.StateVariables(8);
            omegaInt = this.StateVariables(9);
            omega_ref = this.StateVariables(10);
            
            qC_D = this.DesiredStateVariables(1);
            iSd_D = this.DesiredStateVariables(2);
            
            vInd = this.PortInputs(1);
            vInq = this.PortInputs(2);
            
            id_ref = this.SetPoints(1);
            iq_ref = this.SetPoints(2);
            iR_ref = this.SetPoints(3);
            
            Kp = this.ControllerGains(1);
            Ki = this.ControllerGains(2);

            
            %Control Logic
            Te_ref = Kp*(omega_ref-omega)+Ki*omegaInt;
            
            vSd_ref = - (6^(1/2)*(2*LS*RR*iR_ref - 2*LSS*vR - 2*LS*vR + 2*LSS*RR*iR_ref - 6^(1/2)*M*RS*iSd + 6^(1/2)*LS*M*iSq*omega + 6^(1/2)*LSS*M*iSq*omega))/(6*M) - (6^(1/2)*(3*M^2*RR*iR - 3*M^2*RR*iR_ref))/(6*LR*M);
            vSq_ref = omega*(LS*iSd_D + LSS*iSd_D + (6^(1/2)*M*iR)/2) + (2^(1/2)*3^(1/2)*RS*Te_ref)/(3*M*iR_ref);
            
            udL = (2*(C*vInd - C*R*id_ref + C*L*iq_ref*dphi1dt))/qC_D;
            uqL = -(2*(C*R*iq_ref - C*vInq + C*L*id_ref*dphi1dt))/qC_D;
            udR = 2*C*vSd_ref/qC;
            uqR = 2*C*vSq_ref/qC;
            
            %Desired state variable dynamics
            iInd = -iSd;
            iInq = -iSq;
            dqC_D_dt = (C^2*RC*vInd*id_ref*qC - qC*qC_D^2 + C^2*RC*vInq*iq_ref*qC + C^2*RC*iInd*qC_D*vSd_ref + C^2*RC*iInq*qC_D*vSq_ref - C^2*R*RC*id_ref^2*qC - C^2*R*RC*iq_ref^2*qC)/(C*RC*qC*qC_D);
            diSd_D_dt = ((6^(1/2)*LS*Te_ref*omega)/3 - (6^(1/2)*LSS*RR*iR_ref^2)/3 - (6^(1/2)*LS*RR*iR_ref^2)/3 + (6^(1/2)*LSS*Te_ref*omega)/3 + (6^(1/2)*LS*iR_ref*vR)/3 + (6^(1/2)*LSS*iR_ref*vR)/3)/(M*iR_ref*(LS + LSS)) - (RS*iR_ref*iSd_D - RS*iR_ref*iSd + LS*iR_ref*iSq*omega + LSS*iR_ref*iSq*omega)/(iR_ref*(LS + LSS));
          
            ControlInputEquations = [udL ; uqL ; udR ; uqR];
            
            DesiredStateSpace = [dqC_D_dt ; diSd_D_dt];
            
        end
        function [StateSpace] = PE_FlywheelDynamics(this)
            %Inputs____________________________________________
            %Parameters: R, C, L, RC, LR, LS, LSS, M, RR, RS, J, tauL, B, PercentMax
            %StateVariables: id, iq, qC, iSd, iSq, iR, omega, theta,omegaInt, omega_ref
            %Port Inputs: vInd, vInq
            %Controllable Inputs: udL, uqL, udR, uqR
            %RefFrameAngle: phi1 (angle of rotating reference frame on grid side), phi2 (angle of rotating reference frame on grid side)
            %RefFrameSpeed: dphi1dt (speed of rotating reference frame on grid side), dphi2dt (speed of rotating reference frame on grid side)
            %_________________________________________________
            
            %Outputs_________________________________________
            %StateSpace = [diddt, diqdt, dqCdt, diSddt, diSqdt, diRdt, domegadt, dthetadt ; domegaIntdt];
            %_________________________________________________
            
            phi1 = this.RefFrameAngle(1);
            phi2 = this.RefFrameAngle(2);
            
            dphi1dt = this.RefFrameSpeed(1);
            dphi2dt = this.RefFrameSpeed(2);
            
            R = this.Parameters(1);
            C = this.Parameters(2);
            L = this.Parameters(3);
            RC = this.Parameters(4);
            LR = this.Parameters(5);
            LS = this.Parameters(6);
            LSS = this.Parameters(7);
            M = this.Parameters(8);
            RR = this.Parameters(9);
            RS = this.Parameters(10);
            J = this.Parameters(11);
            tauL = this.Parameters(12);
            B = this.Parameters(13);            
            vR = this.Parameters(14);
            PercentMax = this.Parameters(15);
            
            id = this.StateVariables(1);
            iq = this.StateVariables(2);
            qC = this.StateVariables(3);
            iSd = this.StateVariables(4);
            iSq = this.StateVariables(5);
            iR  = this.StateVariables(6);
            omega = this.StateVariables(7);
            theta = this.StateVariables(8);
            omegaInt = this.StateVariables(9);
            omega_ref = this.StateVariables(10);
            
            vInd = this.PortInputs(1);
            vInq = this.PortInputs(2);
            
            udL = this.ControllableInputs(1);
            uqL = this.ControllableInputs(2);
            udR = this.ControllableInputs(3);
            uqR = this.ControllableInputs(4);
            
            id_ref = this.SetPoints(1);
            iq_ref = this.SetPoints(2);
            iR_ref = this.SetPoints(3);
            
            Ks = this.ControllerGains(3);
            
            %Power Electronics Dynamics
            diddt =  iq*dphi1dt - ((qC*udL)/2 - C*vInd + C*R*id)/(C*L);
            diqdt = -id*dphi1dt - ((qC*uqL)/2 - C*vInq + C*R*iq)/(C*L);
            dqCdt = (id*udL)/2 + (iq*uqL)/2 - (iSd*udR)/2 - (iSq*uqR)/2-qC/(C*RC);
            
            %Flywheel Dynamics
            omega_max = (3*M*vR*(-(4*(3*M^2*vR^2 + 2*B*RS*RR^2)*(RS*iSd^2 + R*id_ref^2 - vInd*id_ref + R*iq_ref^2 - vInq*iq_ref))/3)^(1/2))/(2*B^(1/2)*(3*M^2*vR^2 + 2*B*RS*RR^2));
            vSd = (qC*udR)/(2*C);
            vSq = (qC*uqR)/(2*C);
            diSddt = (8*LR*LSS^2*vSd - 4*LR*LS^2*vSd + 3*LS*M^2*vSd - 6*LSS*M^2*vSd + 4*LR*LS^2*RS*iSd - 8*LR*LSS^2*RS*iSd - 3*LS*M^2*RS*iSd + 6*LSS*M^2*RS*iSd - 4*LR*LS^3*dphi2dt*iSq + 8*LR*LSS^3*dphi2dt*iSq - 3*LS*M^2*vSd*cos(2*phi2 - 2*theta) + 6*LSS*M^2*vSd*cos(2*phi2 - 2*theta) + 3*LS*M^2*vSq*sin(2*phi2 - 2*theta) - 6*LSS*M^2*vSq*sin(2*phi2 - 2*theta) + 6*LS^2*M^2*dphi2dt*iSq - 12*LSS^2*M^2*dphi2dt*iSq - 3*LS^2*M^2*iSq*omega + 6*LSS^2*M^2*iSq*omega + 4*LR*LS*LSS*vSd - 4*LR*LS*LSS*RS*iSd - 3*LS^2*M^2*iSd*omega*sin(2*phi2 - 2*theta) + 6*LSS^2*M^2*iSd*omega*sin(2*phi2 - 2*theta) + 2*6^(1/2)*LS^2*M*vR*cos(phi2 - theta) - 4*6^(1/2)*LSS^2*M*vR*cos(phi2 - theta) + 12*LR*LS*LSS^2*dphi2dt*iSq - 6*LS*LSS*M^2*dphi2dt*iSq + 3*LS*M^2*RS*iSd*cos(2*phi2 - 2*theta) - 6*LSS*M^2*RS*iSd*cos(2*phi2 - 2*theta) + 3*LS*LSS*M^2*iSq*omega - 3*LS*M^2*RS*iSq*sin(2*phi2 - 2*theta) + 6*LSS*M^2*RS*iSq*sin(2*phi2 - 2*theta) + 2*LS^2*M^2*dphi2dt*iSq*cos(2*theta) + 2*LSS^2*M^2*dphi2dt*iSq*cos(2*theta) + 2*LS^2*M^2*dphi2dt*iSq*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*dphi2dt*iSq*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*dphi2dt*iSq*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*dphi2dt*iSq*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*dphi2dt*iSq*cos(2*theta - (8*pi)/3) - 3*LS^2*M^2*iSq*omega*cos(2*phi2 - 2*theta) + 6*LSS^2*M^2*iSq*omega*cos(2*phi2 - 2*theta) - 2*6^(1/2)*LS*LSS*M*vR*cos(phi2 - theta) - 2*6^(1/2)*LS^2*M*RR*iR*cos(phi2 - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*cos(phi2 - theta) - 3*6^(1/2)*LS*M^3*iR*omega*sin(phi2 - theta) + 6*6^(1/2)*LSS*M^3*iR*omega*sin(phi2 - theta) + 4*LS*LSS*M^2*dphi2dt*iSq*cos(2*theta) + 4*LS*LSS*M^2*dphi2dt*iSq*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*dphi2dt*iSq*cos(2*theta - (4*pi)/3) + 3*LS*LSS*M^2*iSq*omega*cos(2*phi2 - 2*theta) + 3*LS*LSS*M^2*iSd*omega*sin(2*phi2 - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*cos(phi2 - theta) + 2*6^(1/2)*LR*LS^2*M*iR*omega*sin(phi2 - theta) - 4*6^(1/2)*LR*LSS^2*M*iR*omega*sin(phi2 - theta) - 2*6^(1/2)*LR*LS*LSS*M*iR*omega*sin(phi2 - theta))/(8*LR*LSS^3 - 4*LR*LS^3 + 6*LS^2*M^2 - 12*LSS^2*M^2 + 12*LR*LS*LSS^2 - 6*LS*LSS*M^2 + 2*LS^2*M^2*cos(2*theta) + 2*LSS^2*M^2*cos(2*theta) + 2*LS^2*M^2*cos(2*theta - (4*pi)/3) + 2*LS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LSS^2*M^2*cos(2*theta - (2*pi)/3) + 2*LSS^2*M^2*cos(2*theta - (4*pi)/3) - 2*LSS^2*M^2*cos(2*theta - (8*pi)/3) + 4*LS*LSS*M^2*cos(2*theta) + 4*LS*LSS*M^2*cos(2*theta - (2*pi)/3) + 4*LS*LSS*M^2*cos(2*theta - (4*pi)/3));
            diSqdt = -(4*LR*LS^2*vSq - 8*LR*LSS^2*vSq - 4*LR*LS^2*RS*iSq + 8*LR*LSS^2*RS*iSq - 4*LR*LS^3*dphi2dt*iSd + 8*LR*LSS^3*dphi2dt*iSd - 6*LS*M^2*vSq*cos(phi2 - theta)^2 + 12*LSS*M^2*vSq*cos(phi2 - theta)^2 - 3*LS*M^2*vSd*sin(2*phi2 - 2*theta) + 6*LSS*M^2*vSd*sin(2*phi2 - 2*theta) - 18*LSS^2*M^2*dphi2dt*iSd - 6*LS^2*M^2*iSd*omega + 12*LSS^2*M^2*iSd*omega - 4*LR*LS*LSS*vSq + 4*LR*LS*LSS*RS*iSq - 3*LS^2*M^2*iSq*omega*sin(2*phi2 - 2*theta) + 6*LSS^2*M^2*iSq*omega*sin(2*phi2 - 2*theta) + 2*6^(1/2)*LS^2*M*vR*sin(phi2 - theta) - 4*6^(1/2)*LSS^2*M*vR*sin(phi2 - theta) + 12*LR*LS*LSS^2*dphi2dt*iSd - 18*LS*LSS*M^2*dphi2dt*iSd + 6*LS*M^2*RS*iSq*cos(phi2 - theta)^2 - 12*LSS*M^2*RS*iSq*cos(phi2 - theta)^2 + 6*LS*LSS*M^2*iSd*omega + 3*LS*M^2*RS*iSd*sin(2*phi2 - 2*theta) - 6*LSS*M^2*RS*iSd*sin(2*phi2 - 2*theta) - 3*6^(1/2)*LS*M^3*iR*omega + 6*6^(1/2)*LSS*M^3*iR*omega + 4*LS^2*M^2*dphi2dt*iSd*cos(theta)^2 + 4*LSS^2*M^2*dphi2dt*iSd*cos(theta)^2 + 4*LS^2*M^2*dphi2dt*iSd*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*dphi2dt*iSd*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*dphi2dt*iSd*cos(theta - pi/3)^2 + 4*LSS^2*M^2*dphi2dt*iSd*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*dphi2dt*iSd*cos(theta - (4*pi)/3)^2 + 6*LS^2*M^2*iSd*omega*cos(phi2 - theta)^2 - 12*LSS^2*M^2*iSd*omega*cos(phi2 - theta)^2 - 2*6^(1/2)*LS*LSS*M*vR*sin(phi2 - theta) + 6*6^(1/2)*LS*M^3*iR*omega*cos(phi2/2 - theta/2)^2 - 12*6^(1/2)*LSS*M^3*iR*omega*cos(phi2/2 - theta/2)^2 - 2*6^(1/2)*LS^2*M*RR*iR*sin(phi2 - theta) + 4*6^(1/2)*LSS^2*M*RR*iR*sin(phi2 - theta) + 8*LS*LSS*M^2*dphi2dt*iSd*cos(theta)^2 + 8*LS*LSS*M^2*dphi2dt*iSd*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*dphi2dt*iSd*cos(theta - (2*pi)/3)^2 + 2*6^(1/2)*LR*LS^2*M*iR*omega - 4*6^(1/2)*LR*LSS^2*M*iR*omega - 6*LS*LSS*M^2*iSd*omega*cos(phi2 - theta)^2 + 3*LS*LSS*M^2*iSq*omega*sin(2*phi2 - 2*theta) + 2*6^(1/2)*LS*LSS*M*RR*iR*sin(phi2 - theta) - 4*6^(1/2)*LR*LS^2*M*iR*omega*cos(phi2/2 - theta/2)^2 + 8*6^(1/2)*LR*LSS^2*M*iR*omega*cos(phi2/2 - theta/2)^2 - 2*6^(1/2)*LR*LS*LSS*M*iR*omega + 4*6^(1/2)*LR*LS*LSS*M*iR*omega*cos(phi2/2 - theta/2)^2)/(8*LR*LSS^3 - 4*LR*LS^3 - 18*LSS^2*M^2 + 12*LR*LS*LSS^2 - 18*LS*LSS*M^2 + 4*LS^2*M^2*cos(theta)^2 + 4*LSS^2*M^2*cos(theta)^2 + 4*LS^2*M^2*cos(theta - (2*pi)/3)^2 + 4*LS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LSS^2*M^2*cos(theta - pi/3)^2 + 4*LSS^2*M^2*cos(theta - (2*pi)/3)^2 - 4*LSS^2*M^2*cos(theta - (4*pi)/3)^2 + 8*LS*LSS*M^2*cos(theta)^2 + 8*LS*LSS*M^2*cos(theta - pi/3)^2 + 8*LS*LSS*M^2*cos(theta - (2*pi)/3)^2);
            diRdt = -(2*LS^2*vR - 4*LSS^2*vR - 2*LS*LSS*vR - 2*LS^2*RR*iR + 4*LSS^2*RR*iR + 2*LS*LSS*RR*iR - 6^(1/2)*LS*M*vSd*cos(phi2 - theta) + 2*6^(1/2)*LSS*M*vSd*cos(phi2 - theta) + 6^(1/2)*LS*M*vSq*sin(phi2 - theta) - 2*6^(1/2)*LSS*M*vSq*sin(phi2 - theta) + 6^(1/2)*LS*M*RS*iSd*cos(phi2 - theta) - 2*6^(1/2)*LSS*M*RS*iSd*cos(phi2 - theta) - 6^(1/2)*LS*M*RS*iSq*sin(phi2 - theta) + 2*6^(1/2)*LSS*M*RS*iSq*sin(phi2 - theta) - 6^(1/2)*LS^2*M*iSq*omega*cos(phi2 - theta) + 2*6^(1/2)*LSS^2*M*iSq*omega*cos(phi2 - theta) - 6^(1/2)*LS^2*M*iSd*omega*sin(phi2 - theta) + 2*6^(1/2)*LSS^2*M*iSd*omega*sin(phi2 - theta) + 6^(1/2)*LS*LSS*M*iSq*omega*cos(phi2 - theta) + 6^(1/2)*LS*LSS*M*iSd*omega*sin(phi2 - theta))/(4*LR*LSS^2 - 2*LR*LS^2 + 3*LS*M^2 - 6*LSS*M^2 + 2*LR*LS*LSS + LS*M^2*cos(2*theta) + LSS*M^2*cos(2*theta) + LS*M^2*cos(2*theta - (4*pi)/3) + LS*M^2*cos(2*theta - (8*pi)/3) + 2*LSS*M^2*cos(2*theta - (2*pi)/3) + LSS*M^2*cos(2*theta - (4*pi)/3) - LSS*M^2*cos(2*theta - (8*pi)/3));
            domegadt = -(tauL + B*omega - (6^(1/2)*M*iR*iSq*cos(phi2 - theta))/2 - (6^(1/2)*M*iR*iSd*sin(phi2 - theta))/2)/J;
            dthetadt = omega;
            domegaIntdt = omega_ref-omega;
            domega_ref_dt = -Ks*(omega_ref - PercentMax*omega_max);

            StateSpace = [diddt ; diqdt ; dqCdt ; diSddt ; diSqdt ; diRdt ; domegadt ; dthetadt ; domegaIntdt ; domega_ref_dt];  
        end
    end
end