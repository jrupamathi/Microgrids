function PVControlWithPI
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


x0= 0.5*ones(8,1)

Kp1 = 0.02; Ki1 = 0.2;
Kp2 = 0.02; Ki2 = 0.2;

tspan = [0,0.15];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
delPInt = x(3);
delVInt = x(4);
vTLLd = x(5);
vTLLq = x(6);
iLd = x(7);
iLq = x(8);

t
dphidt = omega0;

%KCL for TLL and PV
iInLd = iRd; iInLq = iRq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd + iInRd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq - iInRq)/CTL - dphidt*vTLLd;
            
P = 1.5*(vTLLd*iRd + vTLLq*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);

delPdt = Pref - P;
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
PL = PPV; QL = PL*tan(acos(0.8));

RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

% RL = PL/(PL^2 + QL^2);
% LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delVdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];
 
end

save('PVControlWithPI.mat')
end