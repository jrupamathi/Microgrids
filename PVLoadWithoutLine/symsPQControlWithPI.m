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

%COntrol gains
% Kp1 = 0.02; 
Ki1 = 0.2;
Kp2 = 0.02; Ki2 = 0.2;

syms iRd iRq delPInt delQInt vTLLd vTLLq iLd iLq CTL real
% syms Ki1 Kp2 Ki2 real
syms Kp1 real
dphidt = omega0;

%KCL for TLL and PV
iInLd = iRd; iInLq = iRq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd + iInRd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq + iInRq)/CTL - dphidt*vTLLd;
            
P = (vTLLd*iRd + vTLLq*iRq);
Q = (vTLLq*iRd - vTLLd*iRq);

% Vt = sqrt(vTLLd^2+ vTLLq^2);

delPdt = Pref - P;
delQdt = Qref - Q;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt;
Vcstar = (Kp2*(Qref-Q) + Ki2*delQInt);
%Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
%Equivalent R and L for Load
RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delQdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];

x = [iRd; iRq; delPInt; delQInt; vTLLd; vTLLq; iLd; iLq ];