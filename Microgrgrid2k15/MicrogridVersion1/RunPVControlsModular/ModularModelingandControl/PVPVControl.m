classdef PVPVControl < Module
    methods
        function this = PVPQLoad(IndexName,RefFrameAngle,RefFrameSpeed)
            ParameterNames={'iDC','RPV','LPV','CPV'};
            StateVariableNames = {'iPVd','iPVq','vDC','delPInt','delVInt'};
            PortInputNames = {'vPVd','vPVq'};
            PortStateNames = {'iPVd','iPVq'};
            ControllableInputNames = {'Sd','Sq'};
            ControllerGainNames = {'K1','K2','K3','K4'};
            SetPointNames = {'PPV','VMag'};
            
            this.RefFrameAngle = RefFrameAngle;
            this.RefFrameSpeed = RefFrameSpeed;
            this.Parameters = sym(sym(strcat(ParameterNames,IndexName)),'real');
            this.StateVariables = sym(sym(strcat(StateVariableNames,IndexName)),'real');
            this.ControllableInputs = sym(sym(strcat(ControllableInputNames,IndexName)),'real');
            this.ControllerGains = sym(sym(strcat(ControllerGainNames,IndexName)),'real');
            this.SetPoints = sym(sym(strcat(SetPointNames,IndexName,'_ref'),'real'));
            this.PortInputs = sym(sym(strcat(PortInputNames,IndexName)),'real');
            this.PortStates = sym(sym(strcat(PortStateNames,IndexName)),'real');
            this.PortVoltages = this.PortInputs;
            this.PortCurrents = -this.PortStates;
            this.StateVariableDerivatives = sym(sym(strcat('d',StateVariableNames,IndexName,'dt')),'real');
            this.PortStateDerivatives = sym(sym(strcat('d',PortStateNames,IndexName,'dt')),'real');
            this.PortStates_Time = sym(sym(strcat(PortStateNames,IndexName,'_t(t)')));
            this.PortStateTypes = {'Current','Current'};
           [this.StateSpace,this.ControlInputEquations] = PVPVControl.PVPVControlDynamics(this.Parameters,this.StateVariables,this.ControllableInputs,...
                this.ControllerGains,this.SetPoints,this.PortInputs,this.RefFrameAngle,this.RefFrameSpeed);
        end
    end
    methods(Static)
        function [StateSpace ControlInputEquations] = PVPVControlDynamics(Parameters,StateVariables,ControllableInputs,...
                ControllerGains,SetPoints,PortInputs,phi,omega0)
            
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
            
            iPVd = StateVariables(1);
            iPVq = StateVariables(2);
            vDC = StateVariables(3);
            delPInt = StateVariables(4);
            delVInt = StateVariables(5);
            
            vPVd = PortInputs(1);
            vPVq = PortInputs(2);
            
            iDC = Parameters(1);
            RPV = Parameters(2);
            LPV = Parameters(3);
            CPV = Parameters(4);
            
            Sd = ControllableInputs(1);
            Sq = ControllableInputs(2);
            
            PPV = SetPoints(1);
            Vmag = SetPoints(2);
            Vc_eq = SetPoints(3);
            delta_eq = SetPoints(4);
            Sd_eq = SetPoints(3);
            Sq_eq = SetPoints(4);
            
            Kps1 = ControllerGains(1);
            Kis1 = ControllerGains(2);
            Kps2 = ControllerGains(3);
            Kis2 = ControllerGains(4);
            Kpu1 = ControllerGains(5);
            Kiu1 = ControllerGains(6);
            Kpu2 = ControllerGains(7);
            Kiu2 = ControllerGains(8);
            
            P = vPVd*iPVd + vPVq*iPVq;
            V = sqrt(vPVd^2 + vPVq^2);
            
            
            %PVPQLoad Dynamics
            diPVddt = -RPV/LPV*iPVd + omega0*iPVq + vDC/LPV*Sd - vPVd/LPV;
            diPVqdt = -RPV/LPV*iPVq - omega0*iPVd + vDC/LPV*Sq - vPVq/LPV;
            dvDCdt = -(iPVd*Sd + iPVq*Sq)/CPV + iDC/CPV;
            
            delta = -Kps1*(P-PV) - Kis1*delPInt + delta_eq;
            Vc = -Kps2*(V-Vmag) - Kis2*delVInt + Vc_eq;
            
            delPIntdt = -(P-PPV);
            delVIntdt = -(V-Vmag);
            
            iPVd_ref = - (RPV*(vPVd - Vc*cos(delta)))/(LPV^2*omeaga0^2 + RPV^2) - (LPV*omeaga0*(vPVq - Vc*sin(delta)))/(LPV^2*omeaga0^2 + RPV^2);
            iPVq_ref = (LPV*omeaga0*(vPVd - Vc*cos(delta)))/(LPV^2*omeaga0^2 + RPV^2) - (RPV*(vPVq - Vc*sin(delta)))/(LPV^2*omeaga0^2 + RPV^2);

            deliPVdIntdt = -(iPVd-iPVd_ref);
            deliPVqIntdt = -(iPVq-iPVq_ref);
            
            Sd = (vPVd + Kpu1*(iPVd - iPVd_ref) + Kiu1*(deliPVdInt) - omega0*LPV*iPVq)/vDC + Sd_eq;
            Sq = (vPVq + Kpu2*(iPVq - iPVq_ref) + Kiu2*(deliPVqInt) + omega0*LPV*iPVd)/vDC + Sq_eq;
            
            StateSpace = 377*[ diPVddt ; diPVqdt; dvDCdt; delPIntdt;delVIntdt; deliPVdIntdt;deliPVqIntdt];
            ControlInputEquations = [Sd;Sq];
        end
    end
end