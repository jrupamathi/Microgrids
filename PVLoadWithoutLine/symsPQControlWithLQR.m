%Lincoln lab parameter
PPV = 3/4;
%Load considered
PL = PPV; QL = PL*tan(acos(0.8));

%Set points for PVcontrol
Pref = PPV;
Qref = QL;
omega0=1;

%Transmission line pi model
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

%Filter adjacebt to PV bus 
RR = 0.5;
LR = 0.005;

syms iRd iRq vTLLd vTLLq iLd iLq real
x = [iRd; iRq ;vTLLd; vTLLq];
dphidt = omega0;

%KCL for TLL and PV
iInLd = iRd; iInLq = iRq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd + iInRd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq + iInRq)/CTL - dphidt*vTLLd;
            
Vdref = 1; Vqref = 0;

ConvMat = [Vdref Vqref;
            Vqref -Vdref];
I = ConvMat\[Pref;Qref];
iSdref = I(1)/1.5;
iSqref = I(2)/1.5;
xref = [iSdref;iSqref;Vdref;Vqref];
vPVdref = Vdref + RR*iSdref - omega0*iSqref*LR;
vPVqref = Vqref + RR*iSqref + omega0*iSdref*LR;

k =  [3.0460   -0.0000    0.4142    0.0000
   -0.0000    3.0460   -0.0000    0.4142];
vRLd = -k(1,:)*(x(1:4)-xref) + vPVdref;
vRLq = -k(2,:)*(x(1:4)-xref) + vPVqref;

vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
%Equivalent R and L for Load
RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];
 
x = [iRd; iRq; vTLLd; vTLLq; iLd; iLq ];