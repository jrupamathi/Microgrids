function testPVControl
Pref = 3.5/4;
Vref = 1.15;
Qref = 0.2/4;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1];%  0.95 1];
RR = 0.4; LR = 0.1;
tArray = [0 0.2 0.2 0.3];
Kgp = 0.2519;
Kgq = 0.2632;
x0= [1;0;1;0;1;0;0;0];
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    factor = Vd/1.12;
%Kp1 = 0.1/(0.85*factor); Ki1 = 1/(1.35*factor); Kp2 = 1/(0.5*factor); Ki2 = 1/(2*factor);
 Kp1 = 0.02; Ki1 = 0.08;
 Kp2 = 0.02; Ki2 = 0.08;
%Kp1 = 0.002/(0.85*factor); Ki1 = 0.2/(1.35*factor); Kp2 = 0.002/(0.5*factor); Ki2 = 0.2/(2*factor);
tspan = [tArray(j) tArray(j+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0 = xStep(end,:);
t = [t,tStep'];
x = [x, xStep'];
end


function [dx,alpha,Vcstar] = PVDynamics(t,x,vTLRd)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iRd = x(5);
iRq = x(6);
delPInt = x(7);
delQInt = x(8);
vTLRq = 0;
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq; 
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);

P = 1.5*(vTLLd*iTLMd + vTLLq*iTLMq);
Q = 1.5*(vTLLq*iTLMd - vTLLd*iTLMq);
Vt = sqrt(vTLLd^2+ vTLLq^2);
delPdt = Pref - P;
delQdt = Qref - Q;
% delQdt = Vref - Vt;

alpha = Kp1*(Pref - P) + Ki1* delPInt;
Vcstar = (Kp2*(Qref-Q) + 10*Ki2*delQInt);%*sqrt(vTLLd^2+ vTLLq^2);
% Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt);%*Vt;
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diRddt;diRqdt;delPdt;delQdt]; 
            plot(t,x(7),'b*',t,x(8),'r*');hold on;

end
save('dataPV.mat')
end