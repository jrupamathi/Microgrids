function DeltaVHardConstPV
%Model 1 - simple control to real power
PPV = 3.5/4; %QPV = 0.01;
CTL = 0.01;
RTL = 0.0099;
LTL = 0.01;% + 0.004;

PL = 0.98*PPV; QL = PL*tan(acos(0.8));

%Filter parameters
Rr = 0.4;
Lr = 0.1;
omega0=1;
tic
%x0 = 0.5*ones(6,1);
x0 = [-0.0009
   -0.0031
   -0.0025
   -0.0018
   -0.0014
   -0.0028
   -0.0021
   -0.0019
   -0.0014
   -0.0029];
[t,x] = ode45(@PVDynamics,[0,1],x0);
toc
    
function dx = PVDynamics(t,x)
t
iPVd = x(1);
iPVq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iTLMd = x(5);
iTLMq = x(6);
vTLRd = x(7);
vTLRq = x(8);
iLd = x(9);
iLq = x(10);

vTLL = sqrt(vTLLd^2+vTLLq^2);
Vang = atan(vTLLq/vTLLd);
%Control law
% QPV = vTLL^2/Lr;
Vc = 1; 
delta = (Lr * PL) /(Vc * vTLL) + Vang;

%KCL at PV and TL
iInLd = iPVd; iInLq = iPVq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL dynamics
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + omega0*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - omega0*vTLRd;

vPVd = Vc * cos(delta); vPVq = Vc* sin(delta);
%vPVd1 = vTLLd; vPVq1 = vTLLq;
diPVddt = (vPVd - Rr*iPVd - vTLLd)/Lr + omega0*iPVq;
diPVqdt = (vPVq - Rr*iPVq - vTLLq)/Lr - omega0*iPVd;


%Equivalent R and L for Load
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diPVddt; diPVqdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt];%delPdt;delQdt]; 
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
save('DeltaVHardConstPV.mat')

end