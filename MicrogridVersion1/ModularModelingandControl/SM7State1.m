classdef SM7State1 < Module
    methods
        function this = SM7State1(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'Lad','Laf','Laq','Ldf','LSd','LSq','LRD','LF','LRQ',...
                'RS','RR','RF','H','B','Tmeq','vfeq'};
            StateVariableNames = {'iSd','iSq','iRd','iRq','iF','delta','omega'};
            PortInputNames = {'vSd','vSq'};
            PortStateNames = {'iSd','iSq'};
            ControllableInputNames = {'tauL','vR'};
            ControllerGainNames = {'K11','K12','K13','K14','K15','K16','K17',...
                'K21','K22','K23','K24','K25','K26','K27'};
            
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.ControllerGains = sym(sym(strcat(ControllerGainNames,IndexName)),'real');
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = this.PortInputs;
            this.PortCurrents = -this.PortStates;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
            this.SetPoints =  sym(sym(strcat(StateVariableNames,IndexName,'_ref')),'real');
            [this.StateSpace, this.ControlInputEquations] = SM7State1.SM7State1Dynamics(this);
        end
    end
    methods(Static)
        function [StateSpace ControlInputEquations] = SM7State1Dynamics(this)
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
            
            Id = this.StateVariables(1);
            Iq = this.StateVariables(2);
            iD  = this.StateVariables(3);
            iQ = this.StateVariables(4);
            iF = this.StateVariables(5);
            delta = this.StateVariables(6);
            omega = this.StateVariables(7);
            
            vds = this.PortInputs(1);
            vqs = this.PortInputs(2);
            
            Lad = this.Parameters(1);
            Laf = this.Parameters(2);
            Laq = this.Parameters(3);
            Ldf = this.Parameters(4);
            Ld = this.Parameters(5);
            Lq = this.Parameters(6);
            LD = this.Parameters(7);
            LF = this.Parameters(8);
            LQ = this.Parameters(9);
            rs = this.Parameters(10);
            rr = this.Parameters(11);
            rf = this.Parameters(12);
            H = this.Parameters(13);
            F = this.Parameters(14);
            Tmeq = this.Parameters(15);
            vfeq = this.Parameters(16);
            
            Tm = this.ControllableInputs(1);
            vf = this.ControllableInputs(2);
            
            K11 = this.ControllerGains(1);
            K12 = this.ControllerGains(2);
            K13 = this.ControllerGains(3);
            K14 = this.ControllerGains(4);
            K15 = this.ControllerGains(5);
            K16 = this.ControllerGains(6);
            K17 = this.ControllerGains(7);
            
            K21 = this.ControllerGains(8);
            K22 = this.ControllerGains(9);
            K23 = this.ControllerGains(10);
            K24 = this.ControllerGains(11);
            K25 = this.ControllerGains(12);
            K26 = this.ControllerGains(13);
            K27 = this.ControllerGains(14);
            
            K = [K13 K14 K15 K17 K16 K11 K12;
                K23 K24 K25 K27 K26 K21 K22];
            
wb=377; 
            omega0=1;
            dIddt=-wb*(iF*((rf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Laf*omega*cos(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Lad*omega*cos(delta))/(Laq^2 - LQ*Lq)) - vds*(LQ/(2*(Laq^2 - LQ*Lq)) + cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Iq*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + iQ*((Laq*rr*cos(delta))/(Laq^2 - LQ*Lq) - (Laq*omega*sin(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*(rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - vqs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            dIqdt=wb*(iF*((rf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Laf*omega*sin(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Lad*omega*sin(delta))/(Laq^2 - LQ*Lq)) - vqs*(cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Id*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - iQ*((Laq*rr*sin(delta))/(Laq^2 - LQ*Lq) + (Laq*omega*cos(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*(rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + vds*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diDdt=wb*(Iq*((rs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*((rs*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vqs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vds*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Laf^2 - LF*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Laq*iQ*omega*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diFdt=-wb*(Id*((rs*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*((rs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vqs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vds*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Laq*iQ*omega*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diQdt=-wb*(Id*((Laq*rs*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*Ld*omega*sin(delta))/(Laq^2 - LQ*Lq)) + Iq*((Laq*rs*sin(delta))/(Laq^2 - LQ*Lq) - (Laq*Ld*omega*cos(delta))/(Laq^2 - LQ*Lq)) + (Laq*vds*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*vqs*sin(delta))/(Laq^2 - LQ*Lq) - (Lq*iQ*rr)/(Laq^2 - LQ*Lq) + (Lad*Laq*iD*omega)/(Laq^2 - LQ*Lq) + (Laf*Laq*iF*omega)/(Laq^2 - LQ*Lq));
            ddeltadt=wb*(omega - 1);
                domegadt=-(Id*vds - Tm +F*omega + Iq*vqs)/(2*H);

            Tm = -K(1,:)*(this.StateVariables - this.SetPoints)' + Tmeq;
            vf = -K(2,:)*(this.StateVariables - this.SetPoints)' + vfeq;
            
            StateSpace = [dIddt ; dIqdt ; diDdt ; diQdt; diFdt; ddeltadt; domegadt];
            
            ControlInputEquations = [Tm;vf] ;

        end
    end
end