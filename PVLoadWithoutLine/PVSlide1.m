function PVSlide1
Pref = 3/4;
Vref = 1.15;
Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.005;
LR = 50;
k1 = LR*0.1; k2 = LR*0.1;
c1 = 0.01; c2 = 0.01;


x0= 0.5*ones(10,1)

Kp1 = 0.02; Ki1 = 0.2;
Kp2 = 0.4; Ki2 = 0.25;

tspan = [0,1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
delPInt = x(3);
delQInt = x(4);
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
dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
P = 1.5*(vTLLd*iRd + vTLLq*iRq);
Q = 1.5*(vTLLq*iRd - vTLLd*iRq);

% Vt = sqrt(vTLLd^2+ vTLLq^2);

delPdt = Pref - P;
delQdt = Qref - Q;
%delQdt = Vref - Vt;
slide1 = delPdt + c1*delPInt;
% slide2 = delQdt + c2*delQInt;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt + k1*sign(slide1);
Vcstar = (1+ Kp2*(Qref-Q) + Ki2*delQInt);%*Vt ;%+ k2*sign(slide2);
%Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
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

dx = 377*[diRddt; diRqdt; delPdt;delQdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
end

save('PVSlide1.mat')
end