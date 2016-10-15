function SimulateVControlledPV
%Model 1 - simple control to real power
PPV = 3.5/4; QPV = 0.01;
CTL = 0.01;
RTL = 3e-4;
LTL = 0.001;
Rr = 2e-4;
Lr = 0.01;
omega0=1;
tic
%x0 = 0.5*ones(6,1);
x0 = [1; 0 ; 1; 0; 1 ; 0];
[t,x] = ode45(@PVDynamics,[0,1],x0);
toc
    
function dx = PVDynamics(t,x)
t
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iPVd = x(5);
iPVq = x(6);
% delQInt = x(7);

iInLd = -iPVd; iInLq = -iPVq;
vTLRd = 1; vTLRq = 0;
% RL = 0.06;
% vTLRd = 0.95*iPVd * RL; vTLRq = 0.95*iPVq * RL;
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
vTLL = sqrt(vTLLd^2+vTLLq^2);
% vTLR = sqrt(vTLRd^2+vTLRq^2);
% Q = vTLLq*iPVd - vTLLd*iPVq;
Vc = 1;% - (Q-QPV) - delQInt; 

delta = atan(vTLLq/vTLLd) + (Lr * PPV) /(Vc * vTLL);

vPVd = Vc * cos(delta); vPVq = Vc* sin(delta);
%vPVd1 = vTLLd; vPVq1 = vTLLq;

            
diPVddt = (-vPVd - Rr*iPVd + vTLLd)/Lr + omega0*iPVq;
diPVqdt = (-vPVq - Rr*iPVq + vTLLq)/Lr - omega0*iPVd;
 
% delQIntdt = (Q-QPV);
dx = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    diPVddt;diPVqdt];%delPdt;delQdt]; 
end 
I = sqrt(x(:,5).^2 + x(:,6).^2);
V = sqrt(x(:,1).^2 + x(:,2).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,1).*x(:,5) + x(:,2).*x(:,6);
Q = x(:,2).*x(:,5) - x(:,1).*x(:,6);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');
save('PVdata.mat')
end