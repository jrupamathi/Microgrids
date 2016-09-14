PPV = 3/4;
PL = 0.98*PPV; QL = PL*tan(acos(0.8));
% Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.5;
LR = 0.005;

syms Pref Qref real
syms Kp1 Ki1 Kp2 Ki2 real

syms iRd iRq delPInt delQInt vTLLd vTLLq iTLMd iTLMq vTLRd vTLRq iLd iLq real

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
Q = 1.5*(vTLLq*iRd - vTLLd*iRq);

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
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delQdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];

x = [iRd; iRq; delPInt; delQInt; vTLLd; vTLLq; iTLMd; iTLMq; vTLRd; vTLRq; iLd; iLq];
