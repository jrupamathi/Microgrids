function PVControlWithVaryingRLC
PPV = 3/4;
Pref = PPV;
Vref = 1.15;
Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

%Filter adjacebt to PV bus 
RR = 0.5;
LR = 0.005;


x0= randn(10,1)

tspan = [0,2];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iTLMd = x(5);
iTLMq = x(6);
vTLRd = x(7);
vTLRq = x(8);
iLd = x(9);
iLq = x(10);

t
dphidt = omega0;

%KCL for TLL and PV
iInLd = iRd; iInLq = iRq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
P = 1.5*(vTLLd*iRd + vTLLq*iRq);
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
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
end

save('PVControlWithVaryingRLC.mat')
end