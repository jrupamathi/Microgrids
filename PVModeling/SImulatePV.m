function SImulatePV

PPV = 3.5/4; QPV = 0.01;
CTL = 0.01;
RTL = 0.0099;
LTL = 0.01;% + 0.004;
% RTL=3e-4p.u.;LTL=0.1p.u;CTL=0.01p.u.
% CTL = 0.01;
% RTL = 3e-2;
% LTL = 0.1;

omega0=1;
tic
% x0 = 0.5*ones(6,1);
% x0 = [1 0 1 0 1 0]';
x0 = [-1.179 1.058 0.122 0.96 0.406 -0.375]';
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

vPVd1 = real((-5.32-1i*2)*(iPVd+1i*iPVq));%vTLLd; 
vPVq1 = imag((-5.32-1i*2)*(iPVd+1i*iPVq));%vTLLq;
vPVd = vTLLd; 
vPVq = vTLLq;
% vPVd1 = vTLLd; vPVq1 = vTLLq;
% vPVd1 = 1; vPVq1 = 0;
RPV = (vPVd1^2 + vPVq1^2)*PPV/(PPV^2 + QPV^2);
% LPV = -LTL - (CTL*RTL*RPV) -0.1;
LPV = (vPVd1^2 + vPVq1^2)*QPV/(PPV^2 + QPV^2);
iInLd = -iPVd; iInLq = -iPVq;
vTLRd = 1; vTLRq = 0;
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            
diPVddt = (vPVd - RPV*iPVd)/LPV + omega0*iPVq;
diPVqdt = (vPVq - RPV*iPVq)/LPV - omega0*iPVd;
            
dx = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    diPVddt;diPVqdt];%delPdt;delQdt]; 
end
I = sqrt(x(:,5).^2 + x(:,6).^2);
V = sqrt(x(:,1).^2 + x(:,2).^2);
plot(t,I,'b',t,V,'r')
save('PVdata.mat')
end