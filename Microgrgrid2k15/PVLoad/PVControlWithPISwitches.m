function PVControlWithPI
PPV = 3.5/4;
Vmag = 1.05;
% Qref = 0.1;
omega0=1;

%Load considered
PL = 0.98*PPV; QL = PL*tan(acos(0.8));

CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

Zbase = 2.4^2/4;

RPV = 0.01/Zbase;
LPV = 3.6e-3*377/Zbase;
CPV = (1/(377*0.02))/Zbase;


x0= randn(13,1);
x0 = [0.753;
    0.277
    0;
    0;
    1
    0
    0.72
    0.25
    0.99
    0.01
    0.73
    0.3
    0.94];
% x0 = [0.197361
%  -0.0777445
%    -618.465
%      6.4531
%    -0.72129
%    0.468595
%  -0.0306019
%   -0.512303
%     1.16465
%   -0.408137
%    0.205345
%   -0.068852
%     6548.33];
Kps1 = 1; Kis1 = 0.1;
Kps2 = 1; Kis2 = 0.1;
iDC = 0.8;

tspan = [0,5];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function [dx] = PVDynamics(t,x)
iPVd = x(1);
iPVq = x(2);
delPInt = x(3);
delVInt = x(4);
vTLLd = x(5);
vTLLq = x(6);
iTLMd = x(7);
iTLMq = x(8);
vTLRd = x(9);
vTLRq = x(10);
iLd = x(11);
iLq = x(12);
vDC = x(13);
t
dphidt = omega0;

%KCL for TLL and PV
iInLd = iPVd; iInLq = iPVq;
%KCL at TL and Load
iInRd = -iLd; iInRq = -iLq;

%TL Dynamics
dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;

vPVd = vTLLd; vPVq = vTLLq;

Ipv = iPVd + 1i*iPVq;
% Vdrop = Ipv*(RPV+ 1i*omega0*LPV);
% Vdrop_mag = abs(Vdrop);
% [theta,~] = cart2pol(real(Vdrop),imag(Vdrop));
% ang_diff = theta-atan(vPVq/vPVd);
% 
% V_ref = Vmag^2 + Vdrop_mag^2 + 2*Vmag*Vdrop_mag*cos(ang_diff);
V_ref = 0.96*Vmag;
delta_ref = PPV*LPV/(V_ref*Vmag);

P = vPVd*iPVd + vPVq*iPVq;
V = sqrt(vPVd^2 + vPVq^2);

delta_diff = -Kps1*(P-PPV)-Kis1*delPInt + delta_ref;
Vc = -Kps2*(V-Vmag) - Kis2*delVInt + V_ref; 

Sd = Vc*cos(delta_diff)/vDC;
Sq = Vc*sin(delta_diff)/vDC;

       
            %PVPQLoad Dynamics
diPVddt = -RPV/LPV*iPVd + omega0*iPVq + vDC/LPV*Sd - vPVd/LPV;
diPVqdt = -RPV/LPV*iPVq - omega0*iPVd + vDC/LPV*Sq - vPVq/LPV;
dvDCdt = -(iPVd*Sd + iPVq*Sq)/CPV + iDC/CPV;
            
            
delPIntdt = (P-PPV);
delVIntdt = (V-Vmag);
            
       
       
           
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

dx = 377*[diPVddt; diPVqdt; delPIntdt;delVIntdt; dvTLLddt; dvTLLqdt;diTLMddt;diTLMqdt;...
    dvTLRddt; dvTLRqdt;diLddt;diLqdt; dvDCdt];
 
end
I = sqrt(x(:,1).^2 + x(:,2).^2);
V = sqrt(x(:,5).^2 + x(:,6).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,5).*x(:,1) + x(:,6).*x(:,2);
Q = x(:,6).*x(:,1) - x(:,5).*x(:,2);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');

save('PVControlWithPI.mat')
end