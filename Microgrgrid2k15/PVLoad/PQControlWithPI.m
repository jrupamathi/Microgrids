function PQControlWithPI
%Lincoln lab parameter
PPV = 3.5/4;
%Load considered
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

%Set points for PVcontrol
Pref = PL;
Qref = QL;
omega0=1;

%Transmission line pi model
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

%Filter adjacebt to PV bus 
RR = 0.4;
LR = 0.1;


x0= [0.1459
    0.0409
   2.7082
  -1.4948
    0.1686
    0.1681
    0.1829
   -0.4436
    0.0344
   -0.3826
    0.1649
   -0.0866];

%COntrol gains
Kp1 = 1; Ki1 = 1;
Kp2 = 1; Ki2 = 0.1;

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
Q = (vTLLq*iRd - vTLLd*iRq);

% Vt = sqrt(vTLLd^2+ vTLLq^2);

delPdt = Pref - P;
delQdt = Qref - Q;

%Control law
alpha = Kp1*(Pref - P) + Ki1* delPInt;%  + atan(vTLLq/vTLLd);% - (vTLLq/vTLLd)^3/3;
Vcstar = (Kp2*(Qref-Q) + Ki2*delQInt);% + sqrt(vTLLd^2 + vTLLq^2);
%Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
%Equivalent R and L for Load
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diRddt; diRqdt; delPdt;delQdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
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


save('PQControlWithPI.mat')
end