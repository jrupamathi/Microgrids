function testPVdroopVarRfCf
Pref = 3/4;
Vref = 1.15;
Qref = 0.1;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

Lf = 0.1;
Rf = 1e-3;
VdrefArr = [1 ];%0.85  1];
tArray = [0 1 1.5 2.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= 0.9*ones(6,1);
t=[]; x=[];
for k = 1:numel(VdrefArr)
    Vd = VdrefArr(k)
    tspan = [tArray(k) tArray(k+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0=xStep(end,:);
t = [t tStep'];
x =[x xStep'];
end

function dx = PVDynamics(t,x,vTLRd)
iSd = x(1);
iSq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iTLMd = x(5);
iTLMq = x(6);

vTLRq = 0.001;

t
vACd = vTLLd; vACq = vTLLq;
%vPVd = V*cos(delta); vPVq = V*sin(delta);
Vdref = 1.1;
Vqref = 0.02;

% k =  [3.0460   -0.0000    0.4142    0.0000
%    -0.0000    3.0460   -0.0000    0.4142];
% vPVd = -k(1,:)*(x(1:4)-xref) + vPVdref;
% vPVq = -k(2,:)*(x(1:4)-xref) + vPVqref;
P = 1.5*(vACd*iSd + vACq*iSq);
V = sqrt(vACd^2 + vACq^2);
Lf = 0.01;
% CTL =  (Qref/1.5 + (iSd^2 + iSq^2)*Lf)/(vACd^2 + vACq^2);
% Rf = -Pref/(1.5*(iSd^2 + iSq^2)); 

Rf = 1*(P -Pref);
CTL = 1*(V-Vref);
diSddt = (vACd - Rf*iSd)/Lf + omega0*iSq;
diSqdt = (vACq - Rf*iSq)/Lf - omega0*iSd;
%ddeltadt = omega-omega0;
%domegadt = -(omega - omega0) - Kp*(P-Pref);
%dVdt = -(V-Vref) + Kq*(Q-Qref);

dphidt = omega0;
iInLd = -iSd; iInLq = -iSq; 
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            
            dx = 377*[diSddt;diSqdt;...
                ...%ddeltadt;domegadt;dVdt;
                dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt];
            plot(t,x(3));
            hold on;
end
save('dataPV.mat')
end