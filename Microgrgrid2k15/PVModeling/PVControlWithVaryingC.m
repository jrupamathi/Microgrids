function PVControlWithVaryingC
PPV = 3/4;
PL = 0.98*PPV; QL = PL*tan(acos(0.8));
Vref = 1.15;
% Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.005;
LR = 50;


x0= ones(14,1);

tspan = [0,1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
vPVd = x(1);
vPVq = x(2);
Cf = x(3);
CfIn = x(4);
iFd = x(5);
iFq = x(6);
vTLLd = x(7);
vTLLq = x(8);
iTLMd = x(9);
iTLMq = x(10);
vTLRd = x(11);
vTLRq = x(12);
iLd = x(13);
iLq = x(14);

t
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
            
dCfdt =  (sqrt(vPVd^2+vPVq^2) - Vref) + CfIn;%(Qref + 1.5*(iFd^2+iFq^2)*Lf)/(1.5*(vPVd^2+ vPVq^2));
CfIndt = (sqrt(vPVd^2+vPVq^2) - Vref);
ConvMat = [vPVd vPVq;
            vPVq -vPVd];
%ConvMat = [1 0; 0 -1];
Pref = PL - 1.5*(iTLMd^2+iTLMq^2)*RTL;
Qref = QL - 1.5*(iTLMd^2+iTLMq^2)*LTL;
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
 
end
I = sqrt(x(:,3).^2 + x(:,4).^2);
V = sqrt(x(:,7).^2 + x(:,8).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,7).*x(:,3) + x(:,8).*x(:,4);
Q = x(:,8).*x(:,4) - x(:,7).*x(:,4);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');

save('PVControlWithVaryingC.mat')
end