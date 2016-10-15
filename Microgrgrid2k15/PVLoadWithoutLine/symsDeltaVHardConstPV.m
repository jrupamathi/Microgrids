% PPV = 3.5/4; %QPV = 0.01;
% CTL = 0.1;


%Filter parameters
% Rr = 0.5;
% Lr = 0.005;
omega0=1;

syms iPVd iPVq vTLLd vTLLq iLd iLq
syms PPV Rr Lr CTL real

vTLL = sqrt(vTLLd^2+vTLLq^2);
Vang = atan(vTLLq/vTLLd);
%Control law
% QPV = vTLL^2/Lr;
Vc = 1.2; 
delta = (Lr * PPV) /(Vc * vTLL) + Vang;

%KCL at PV and TL
iInLd = iPVd; iInLq = iPVq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL dynamics
dvTLLddt = (iInLd+iInRd)/CTL + omega0*vTLLq;
dvTLLqdt = (iInLq + iInRq)/CTL - omega0*vTLLd;

vPVd = Vc * cos(delta); vPVq = Vc* sin(delta);
%vPVd1 = vTLLd; vPVq1 = vTLLq;
diPVddt = (vPVd - Rr*iPVd - vTLLd)/Lr + omega0*iPVq;
diPVqdt = (vPVq - Rr*iPVq - vTLLq)/Lr - omega0*iPVd;


%Equivalent R and L for Load
PL = PPV; QL = PL*tan(acos(0.8));

RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diPVddt; diPVqdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];%delPdt;delQdt]; 
x = [iPVd iPVq vTLLd vTLLq iLd iLq];