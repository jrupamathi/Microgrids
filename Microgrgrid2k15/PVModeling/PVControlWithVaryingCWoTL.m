function PVControlWithVaryingCWoTL
PPV = 3/4;
PL = 0.98*PPV; QL = PL*tan(acos(0.8));
Vref = 1.15;
% Qref = 0.1;
omega0=1;

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

RR = 0.005;
LR = 50;


x0= zeros(6,1);

tspan = [0,2];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
vPVd = x(1);
vPVq = x(2);
Cf = x(3);
CfIn = x(4);
iFd = x(5);
iFq = x(6);

t
dphidt = omega0;

        
dCfdt =  (sqrt(vPVd^2+vPVq^2) - Vref) + CfIn;%(Qref + 1.5*(iFd^2+iFq^2)*Lf)/(1.5*(vPVd^2+ vPVq^2));
CfIndt = (sqrt(vPVd^2+vPVq^2) - Vref);
ConvMat = [vPVd vPVq;
            vPVq -vPVd];
%ConvMat = [1 0; 0 -1];
Pref = PL;% - 1.5*(iTLMd^2+iTLMq^2)*RTL;
Qref = QL;% - 1.5*(iTLMd^2+iTLMq^2)*LTL;
I = ConvMat\[Pref-1.5*(iFd^2+iFq^2)*RR;Qref-1.5*(iFd^2+iFq^2)*LR];
iRefd = I(1)/1.5;
iRefq = I(2)/1.5;

iPVd = iRefd;
iPVq = iRefq;

%Equivalent R and L for Load
RL = 1.5*PL/(PL^2 + QL^2);
LL = 1.5*QL/(PL^2 + QL^2);

vTLLd = RL*iFd; vTLLq = RL*iFq;
dvPVddt = (iPVd - iFd)/Cf + omega0*vPVq;
dvPVqdt = (iPVq - iFq)/Cf - omega0*vPVd;
diFddt = (vPVd - vTLLd - RR*iFd)/LR + omega0*iFq;
diFqdt = (vPVq - vTLLq - RR*iFq)/LR - omega0*iFd;

dx = 377*[dvPVddt; dvPVqdt; diFddt; diFqdt;dCfdt;CfIndt];
 
end

save('PVControlWithVaryingCWoTL.mat')
end