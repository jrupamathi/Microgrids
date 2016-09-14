function IncConductanceExp
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


% x0= [1;0.1;0.1;0.1;1;0.1;1;0.1];
% x0 = randn(8,1);
x0 = [    0.5256    1.5233    1.7985   -0.1169   -0.3202    0.8175    0.4902    0.7653];
Kp1 = 0.02; Ki1 = 200; 
Kp2 = 0.02; Ki2 = 2;

tspan = [0,1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iRd = x(1);
iRq = x(2);
delPInt = x(3);
delQInt = x(4);
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
dvTLLqdt = (iInLq + iInRq)/CTL - dphidt*vTLLd;
            
%Equivalent R and L for Load
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

P = (vTLLd*iRd + vTLLq*iRq);
Q = (vTLLq*iRd - vTLLd*iRq);
% Vt = sqrt(vTLLd^2+ vTLLq^2);
iLMag = sqrt(iLd^2 + iLq^2);
Vmag = sqrt(vTLLd^2 + vTLLq^2);

delI = (iLd*diLddt + iLq*diLqdt)/iLMag; 
delV = (vTLLd*dvTLLddt + vTLLq*dvTLLqdt)/Vmag;

delPdt = delI/delV + sqrt((iLd^2+iLq^2)/(vTLLd^2 + vTLLq^2));
delQdt = Qref - Q;

%Control law
alpha = Kp1*(delPdt) + Ki1* delPInt;
Vcstar = (Kp2*(delQdt) + Ki2*delQInt)*Vref + Vref;
%Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            

dx = 377*[diRddt; diRqdt; delPdt;delQdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];
 
end

save('IncConductanceExp.mat')
end