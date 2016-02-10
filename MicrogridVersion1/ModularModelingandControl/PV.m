classdef PV < Module
    methods
        function this = PV(IndexName,RefFrameAngle,RefFrameSpeed,BaseSpeed)
            ParameterNames={'RR','LR','Pref','Vref','Kp1','Ki1','Kp2','Ki2','c1','c2','k1','k2'};
            StateVariableNames = {'iLd','iLq','PInt','QInt'};
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
            this.StateSpace = PV.PVDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                                                     this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function StateSpace = PVDynamics(Parameters,StateVariables,ControllableInputs,PortInputs,phi,dphidt)
            
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
            
            iRd = StateVariables(1);
            iRq = StateVariables(2);
            delPInt = StateVariables(3);
            delQInt = StateVariables(4);
            
            vTLLd = PortInputs(1);
            vTLLq = PortInputs(2);
            
            RR = Parameters(1);
            LR = Parameters(2);
            Pref = Parameters(3);
            Vref = Parameters(4);
            Kp1 = Parameters(5);
            Ki1 = Parameters(6);
            Kp2 = Parameters(7);
            Ki2 = Parameters(8);
            c1 = Parameters(9);
            c2 = Parameters(10);
            k1 = Parameters(11);
            k2 = Parameters(12);
            omega0=1;
           
            P = 1.5*(vTLLd*iRd + vTLLq*iRq);
            Vt = sqrt(vTLLd^2 + vTLLq^2);
            
            ddelPIntdt = Pref - P;
            ddelQIntdt = Vref - Vt;
            
            slide1 = ddelPIntdt + c1*delPInt;
            slide2 = ddelQIntdt + c2*delQInt;
            alpha = Kp1*(Pref - P) + Ki1* delPInt + k1*sign(slide1);
            Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
            vRLd = Vcstar*cos(alpha);
            vRLq = Vcstar*sin(alpha);
            vRRd = vTLLd; vRRq = vTLLq;

            diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
            diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;

            StateSpace =377*[ diRddt ; diRqdt ; ddelPIntdt;ddelQIntdt];
        end
    end
end