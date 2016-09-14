function PV_PQLoad
%PQ as Negative PQ load
PPV = -(3.5/4); QPV = -0.2/4;
CTL = 0.01;
RTL = 0.0099;
LTL = 0.01;% + 0.004;
PL = PPV; QL = 0.98*QPV;
% RTL=3e-4p.u.;LTL=0.1p.u;CTL=0.01p.u.
% CTL = 0.01;
% RTL = 3e-2;
% LTL = 0.1;

omega0=1;
tic
% x0 = 0.5*ones(6,1);
% x0 = [1 0 1 0 1 0]';
x0 = [-1.179 1.058 0.122 0.96 0.406 0]';
[t,x] = ode45(@PVDynamics,[0,1],x0);
toc
    
function dx = PVDynamics(t,x)
t
vTLLd = x(1);
vTLLq = x(2);
iPVd = x(3);
iPVq = x(4);
iLd = x(5);
iLq = x(6);

%Volatge Balance at PV and TL
vPVd = vTLLd; vPVq = vTLLq;
vPVd1 = vTLLd; vPVq1 = vTLLq;
% vPVd1 = 1; vPVq1 = 0;
%Equivalent R and L for PV
RPV = (vPVd1^2 + vPVq1^2)*PPV/(PPV^2 + QPV^2);
% LPV = -LTL - (CTL*RTL*RPV) -0.1;
LPV = (vPVd1^2 + vPVq1^2)*QPV/(PPV^2 + QPV^2);

%KCL at PV and TL
iInLd = -iPVd; iInLq = -iPVq;
%KCL at Load and TL
iInRd = -iLd; iInRq = -iLq;

% vTLRd = 1; vTLRq = 0;
%Dynamics for TL
dvTLLddt = (iInLd + iInRd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq + iInRq)/CTL - omega0*vTLLd;
            
%Dyhamics for PV
diPVddt = (vPVd - RPV*iPVd)/LPV + omega0*iPVq;
diPVqdt = (vPVq - RPV*iPVq)/LPV - omega0*iPVd;

%Equivalent R and L for Load
RL = PL*(vPVd1^2 + vPVq1^2)/(PL^2 + QL^2);
LL = QL*(vPVd1^2 + vPVq1^2)/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[dvTLLddt; dvTLLqdt;...
    diPVddt;diPVqdt;diLddt;diLqdt]; 
end 

save('PV_PQLoad.mat')
end