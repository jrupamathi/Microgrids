function PVControlWithPI
PPV = 3/4;
Pref = PPV;
Vref = 1.15;
Qref = 0.1;
omega0=1;

%Load considered
PL = 0.98*PPV; QL = PL*tan(acos(0.8));
Pref = PL;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.4;
LR = 0.1;


x0= [-0.5903
   -0.3490
  2.2699
    3.1709
   -0.4255
   -1.1167
   -0.6000
   -0.3475
   -0.5858
   -0.9958
   -0.6139
   -0.3451];%0.5*ones(12,1)

Kp1 = 1; Ki1 = 0.1;
Kp2 = 1; Ki2 = 0.1;

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
            
P = (vTLLd*iRd + vTLLq*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);

delPdt = Pref - P;
delVdt = Vref - Vt;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt;% + vTLLq/vTLLd - (vTLLq/vTLLd)^3/3;
Vcstar = Vref+(Kp2*(Vref-Vt) + Ki2*delVInt)*Vref;

vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delVdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];
 
end
I = sqrt(x(:,1).^2 + x(:,2).^2);
V = sqrt(x(:,5).^2 + x(:,6).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,5).*x(:,1) + x(:,6).*x(:,2);
Q = x(:,6).*x(:,1) - x(:,5).*x(:,2);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');

save('PVControlWithPI.mat')
end