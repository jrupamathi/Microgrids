function PQControlWithLQR
%Lincoln lab parameter
PPV = 3/4;
%Load considered
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

%Set points for PVcontrol
Pref = PPV;
Qref = 0.1;
omega0=1;

%Transmission line pi model
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

%Filter adjacebt to PV bus 
RR = 0.4;
LR = 0.1;

x0= randn(10,1);


tspan = [0,1];
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
            
Vdref = 1.1;%vTLLd; 
Vqref = 0.1;%vTLLq;

ConvMat = [Vdref Vqref;
            Vqref -Vdref];
I = ConvMat\[PL;QL];
iSdref = I(1);
iSqref = I(2);
xref = [iSdref;iSqref;Vdref;Vqref];
vPVdref = Vdref + RR*iSdref - omega0*iSqref*LR;
vPVqref = Vqref + RR*iSqref + omega0*iSdref*LR;

k =  [3.0460   -0.0000    0.4142    0.0000
   -0.0000    3.0460   -0.0000    0.4142];
vRLd = -k(1,:)*(x(1:4)-xref) + vPVdref;
vRLq = -k(2,:)*(x(1:4)-xref) + vPVqref;

vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
%Equivalent R and L for Load
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
end
I = sqrt(x(:,1).^2 + x(:,2).^2);
V = sqrt(x(:,3).^2 + x(:,4).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,3).*x(:,1) + x(:,4).*x(:,2);
Q = x(:,4).*x(:,1) - x(:,3).*x(:,2);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');
save('PQControlWithLQR.mat')
end