function SImulatePV
%SM - TL - InfBus - PV
PPV = 3.5/4; QPV = 0.2/4;
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
x0 = [-1.179 1.058 0.122 0.96 0.406 -0.375 -1.179 1.058]';
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

iSd_G23 = x(9);
iSq_G23 = x(10);
iRd_G23 = x(11);
iRq_G23 = x(12);
iF_G23 = x(13);
delta_G23 = x(14);
omega_G23 = x(15);

vTLRd = 1;%x(7);
vTLRq = 0;%x(8);

vPVd = vTLRd; vPVq = vTLRq;
% vPVd1 = vTLLd; vPVq1 = vTLLq; %For PQ Load
vPVd1 = 1; vPVq1 = 0; %For RL Load
RPV = -(vPVd1^2 + vPVq1^2)*PPV/(PPV^2 + QPV^2);
% LPV = -LTL - (CTL*RTL*RPV) -0.1;
LPV = -(vPVd1^2 + vPVq1^2)*QPV/(PPV^2 + QPV^2);
iInLd = -iPVd; iInLq = -iPVq;
% vTLRd = 1; vTLRq = 0;
dvTLLddt = (iInLd - iTLMd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - omega0*vTLLd;
diTLMddt = omega0*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - omega0*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = 0;%(iInRd + iTLMd)/CTL + omega0*vTLLq;
dvTLRqdt = 0;%(iInRq + iTLMq)/CTL - omega0*vTLLd;
            
diPVddt = (vPVd - RPV*iPVd)/LPV + omega0*iPVq;
diPVqdt = (vPVq - RPV*iPVq)/LPV - omega0*iPVd;
            
dx = 377*[dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    diPVddt;diPVqdt;dvTLRddt; dvTLRqdt]; 
end 
save('PVdata.mat')
end