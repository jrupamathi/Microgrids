classdef SM7State < Module
    methods
        function this = SM7State(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'Lad','Laf','Laq','Ldf','LSd','LSq','LRD','LF','LRQ','RS','RR','RF','H','B','Tm','vR'};
            StateVariableNames = {'iSd','iSq','iRd','iRq','iF','delta','omega'};
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
            this.PortCurrents = -this.PortStates;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
            this.StateSpace = SM7State.SM7StateDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                                             this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function StateSpace = SM7StateDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,omega0)
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
            
            Id = StateVariables(1);
            Iq = StateVariables(2);
            iD  = StateVariables(3);
            iQ = StateVariables(4);
            iF = StateVariables(5);
            delta = StateVariables(6);
            omega = StateVariables(7);
            
            vds = PortInputs(1);
            vqs = PortInputs(2);
            
            Lad = Parameters(1);
            Laf = Parameters(2);
            Laq = Parameters(3);
            Ldf = Parameters(4);
            Ld = Parameters(5);
            Lq = Parameters(6);
            LD = Parameters(7);
            LF = Parameters(8);
            LQ = Parameters(9);
            rs = Parameters(10);
            rr = Parameters(11);
            rf = Parameters(12);
            H = Parameters(13);
            F = Parameters(14);
            Tm = Parameters(15);
            vf = Parameters(16);
wb=377;
            dIddt=-wb*(iF*((rf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Laf*omega*cos(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Lad*omega*cos(delta))/(Laq^2 - LQ*Lq)) - vds*(LQ/(2*(Laq^2 - LQ*Lq)) + cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Iq*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + iQ*((Laq*rr*cos(delta))/(Laq^2 - LQ*Lq) - (Laq*omega*sin(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*(rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - vqs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
dIqdt=wb*(iF*((rf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Laf*omega*sin(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Lad*omega*sin(delta))/(Laq^2 - LQ*Lq)) - vqs*(cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Id*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - iQ*((Laq*rr*sin(delta))/(Laq^2 - LQ*Lq) + (Laq*omega*cos(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*(rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + vds*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diDdt=wb*(Iq*((rs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*((rs*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vqs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vds*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Laf^2 - LF*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Laq*iQ*omega*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diFdt=-wb*(Id*((rs*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*((rs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vqs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vds*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Laq*iQ*omega*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diQdt=-wb*(Id*((Laq*rs*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*Ld*omega*sin(delta))/(Laq^2 - LQ*Lq)) + Iq*((Laq*rs*sin(delta))/(Laq^2 - LQ*Lq) - (Laq*Ld*omega*cos(delta))/(Laq^2 - LQ*Lq)) + (Laq*vds*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*vqs*sin(delta))/(Laq^2 - LQ*Lq) - (Lq*iQ*rr)/(Laq^2 - LQ*Lq) + (Lad*Laq*iD*omega)/(Laq^2 - LQ*Lq) + (Laf*Laq*iF*omega)/(Laq^2 - LQ*Lq));
ddeltadt=wb*(omega - 1);
domegadt=-(Id*vds - Tm +F*omega + Iq*vqs)/(2*H);

            StateSpace = [dIddt ; dIqdt ; diDdt ; diQdt; diFdt; ddeltadt; domegadt];

        end
    end
end