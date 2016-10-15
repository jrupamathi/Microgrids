function PVControlWithIncConduc
PPV = 3/4;
Pref = PPV;
Vref = 1.15;
Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.005;
LR = 50;


% x0= rand(12,1);
x0 = [    0.6358    0.9452    0.2089    0.7093    0.2362    0.1194    0.6073    0.4501    0.4587    0.6619    0.7703    0.3502];
Kp1 = 0.02; Ki1 = 2; 
Kp2 = 0.02; Ki2 = 2;

tspan = [0,1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
delPInt = x(3);
delVInt = x(4);
vTLLd = x(5);
vTLLq = x(6);
iTLMd = x(7);
iTLMq = x(8);
vTLRd = x(9);
vTLRq = x(10);
iLd = x(11);
iLq = x(12);

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

delI = diTLMddt + diTLMqdt; 
delV = dvTLLddt + dvTLLqdt;

delPdt = delI/delV + sqrt((iTLMd^2+iTLMq^2)/(vTLLd^2 + vTLLq^2));
delVdt = Vref - Vt;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt;
Vcstar = (Vref+Kp2*(Vref-Vt) + Ki2*delVInt)*Vref;

vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
%Equivalent R and L for Load
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delVdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
end

save('PVControlWithIncConduct.mat')
end