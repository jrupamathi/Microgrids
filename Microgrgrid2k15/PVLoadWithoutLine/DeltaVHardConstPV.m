function DeltaVHardConstPV
%Model 1 - simple control to real power
PPV = 3.5/4; %QPV = 0.01;
CTL = 0.1;
RTL = 0.0099;
LTL = 0.01;% + 0.004;


%Filter parameters
Rr = 0.5;
Lr = 0.005*377;
omega0=1;
tic
%x0 = 0.5*ones(6,1);
x0 = 0.1*ones(6,1);
[t,x] = ode45(@PVDynamics,[0,0.05],x0);
toc
    
function dx = PVDynamics(t,x)
t
iPVd = x(1);
iPVq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iLd = x(5);
iLq = x(6);

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

%Equivalent R and L for Load
RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diPVddt; diPVqdt; dvTLLddt; dvTLLqdt;diLddt;diLqdt];%delPdt;delQdt]; 
end 
save('DeltaVHardConstPV.mat')
end