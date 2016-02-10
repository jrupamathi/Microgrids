classdef Module < handle
    %dynamic module superclass
    
    properties
        RefFrameAngle;      %angular position of dq ref frame
        RefFrameSpeed;      %angular speed of dq ref frame
        Parameters;         %inductances, capacitances, etc.
        ControllerGains;    %gains of controllers 
        SetPoints;          %set points for controllers
        StateVariables;
        StateSpace;
        StateVariableDerivatives;
        PortInputs;
        PortStates;
        PortVoltages;
        PortCurrents;
        PortStates_Time;
        PortStateDerivatives;
        PortStateTypes;     %either "current" or "charge"
        ControllableInputs;   %with passivity-based control, controllable inputs
        ControlInputEquations;   %in PBC, mathematical equations for controllable inputs
        DesiredStateVariables;   %with PBC, for underactuated systems, there will be desired state variables
        DesiredStateVariableDerivatives;
        DesiredStateSpace;
        SetPointOutputs;   %set point outputs that are sent to another module
        SetPointOutputEquations;  %set point
        GTemp;
    end
    
    methods

    end
end