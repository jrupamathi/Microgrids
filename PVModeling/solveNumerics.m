%function dx = PVDynamics(t,x)

PPV = 3.5/4; QPV = 0.01;
CTL = 0.5;
RTL = 8e-1;
LTL = RTL*2.9500;

omega0=1;
    
% vTLLd = x(1);
% vTLLq = x(2);
% iTLMd = x(3);
% iTLMq = x(4);
% iPVd = x(5);
% iPVq = x(6);

syms vTLLd vTLLq iTLMd iTLMq iPVd iPVq real
x = [vTLLd vTLLq iTLMd iTLMq iPVd iPVq];
vPVd = vTLLd; vPVq = vTLLq;
vPVd1 = vTLLd; vPVq1 = vTLLq;
%vPVd1 = 1; vPVq1 = 0;
RPV = -(vPVd1^2 + vPVq1^2)*PPV/(PPV^2 + QPV^2);
LPV = -(vPVd1^2 + vPVq1^2)*QPV/(PPV^2 + QPV^2);

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
% end


