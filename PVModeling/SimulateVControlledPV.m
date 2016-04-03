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

iInLd = -iPVd; iInLq = -iPVq;
vTLRd = 1; vTLRq = 0;

dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
vTLL = sqrt(vTLLd^2+vTLLq^2);
vTLR = sqrt(vTLRd^2+vTLRq^2);
Vc = 1; delta = (Lr * PPV) /(Vc * vTLL);

vPVd = Vc * cos(delta); vPVq = Vc* sin(delta);
%vPVd1 = vTLLd; vPVq1 = vTLLq;

            
diPVddt = (vPVd - Rr*iPVd - vTLLd)/Lr + omega0*iPVq;
diPVqdt = (vPVq - Rr*iPVq - vTLLq)/Lr - omega0*iPVd;
            
dx = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    diPVddt;diPVqdt];%delPdt;delQdt]; 
end 
save('PVdata.mat')
end