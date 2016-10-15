%To find equilibrium or PVControlWithWaryingC
PPV = 3/4;
syms PL QL real
% PL = 0.98*PPV; QL = PL*tan(acos(0.8));
Vref = 1.15;
% Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.5;
LR = 0.005;

syms vPVd vPVq Cf CfIn iFd iFq real
syms vTLLd vTLLq iTLMd iTLMq vTLRd vTLRq real
syms iLd iLq Kp Ki1 Ki2 real

dphidt = omega0;

%KCL for TLL and PV
iInLd = iFd; iInLq = iFq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
dCfdt =  Kp*(sqrt(vPVd^2+vPVq^2) - Vref) + Ki1*CfIn;%(Qref + 1.5*(iFd^2+iFq^2)*Lf)/(1.5*(vPVd^2+ vPVq^2));
CfIndt = Ki2*(sqrt(vPVd^2+vPVq^2) - Vref);
ConvMat = [vPVd vPVq;
            vPVq -vPVd];
%ConvMat = [1 0; 0 -1];
syms Pref real% = PL - 1.5*(iTLMd^2+iTLMq^2)*RTL;
syms Qref real%= QL - 1.5*(iTLMd^2+iTLMq^2)*LTL;
I = ConvMat\[Pref-1.5*(iFd^2+iFq^2)*RR;Qref-1.5*(iFd^2+iFq^2)*LR];
iRefd = I(1)/1.5;
iRefq = I(2)/1.5;

iPVd = iRefd;
iPVq = iRefq;

dvPVddt = (iPVd - iFd)/Cf + omega0*vPVq;
dvPVqdt = (iPVq - iFq)/Cf - omega0*vPVd;
diFddt = (vPVd - vTLLd - RR*iFd)/LR + omega0*iFq;
diFqdt = (vPVq - vTLLq - RR*iFq)/LR - omega0*iFd;

%Equivalent R and L for Load
RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[dvPVddt; dvPVqdt; diFddt; diFqdt;dCfdt;CfIndt;
    dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
x = [vPVd;vPVq; iFd; iFq; Cf; CfIn;...
    vTLLd;vTLLq; iTLMd; iTLMq; vTLRd; vTLRq;...
    iLd;iLq];