function SimulateVControlledPV
%Model 1 - simple control to real power
PPV = 3.5/4; QPV = 0.01;
CTL = 0.01;
RTL = 0.01;
LTL = 0.01;
Rr = 0.015;
Lr = 0.01;
omega0=1;
tic
%x0 = 0.5*ones(6,1);
x0 = [1; 0 ; 1; 0; 1 ; 0; 1; 0];
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
vTLRd = x(7);
vTLRq = x(8);

iInLd = iPVd; iInLq = iPVq;
% vTLRd = 1; vTLRq = 0;

dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
iInRd = -0.9*iPVd; iInRq = -0.8*iPVq;
dvTLRddt = (iInRd + iTLMd)/CTL + omega0*vTLLq;
dvTLRqdt = (iInRq + iTLMq)/CTL - omega0*vTLLd;

vTLL = sqrt(vTLLd^2+vTLLq^2);
vTLR = sqrt(vTLRd^2+vTLRq^2);
Vc = 1.02; delta = (Lr * (PPV-0.01)) /(Vc * vTLL) + atan(vTLLq/vTLLd) ;

vPVd = Vc * cos(delta); vPVq = Vc* sin(delta);
%vPVd1 = vTLLd; vPVq1 = vTLLq;

            
diPVddt = (vPVd - Rr*iPVd - vTLLd)/Lr + omega0*iPVq;
diPVqdt = (vPVq - Rr*iPVq - vTLLq)/Lr - omega0*iPVd;
            
dx = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    diPVddt;diPVqdt;dvTLRddt; dvTLRqdt];%delPdt;delQdt]; 
end 
save('PVdata.mat')
end