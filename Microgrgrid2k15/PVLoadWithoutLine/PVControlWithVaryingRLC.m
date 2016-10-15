function PVControlWithVaryingRLC
PPV = 3/4;
Pref = PPV;
Vref = 1.15;
Qref = 0.1;
omega0=1;

CTL = 0.01;

%Filter adjacebt to PV bus 
RR = 0.5;
LR = 0.005;


x0= randn(6,1)

tspan = [0,2];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iLd = x(5);
iLq = x(6);

t
dphidt = omega0;

%KCL for TLL and PV
iInLd = iRd; iInLq = iRq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd + iInRd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq + iInRq)/CTL - dphidt*vTLLd;
            
P = (vTLLd*iRd + vTLLq*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);

%Control law
LPV = max((Vt-Vref),LR);
RPV = max(RR+(P-Pref),RR);

vRLd = 0;
vRLq = 0;
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RPV*iRd - vRRd)/LPV + omega0*iRq;
diRqdt = (vRLq - RPV*iRq - vRRq)/LPV - omega0*iRd;
            
%Equivalent R and L for Load
PL = PPV; QL = PL*tan(acos(0.8));

RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];
 
end

save('PVControlWithVaryingRLC.mat')
end