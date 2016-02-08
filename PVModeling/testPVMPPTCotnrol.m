function testPVdroopSimulatorPQLoad
Pref = 3/4;
Vref = 1.05;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.05];% 0.95; 1];
% Kp1 = 2*Iref; Ki1 = Iref^2; 
% Kp2 = 2*Vref*50; Ki2 = Vref^2;
Kp1= 0.02; Ki1 = 0.05;
Kp2 = 0.2; Ki2 = 0.2;
RR = 0.4; LR = 0.1;
tArray = [0 0.1 0.8 1.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= [1.0351
    0.0610
   -0.2707
    0.0570
   -0.2641
    0.1113
 -0.0877
   -0.2116]';
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    factor = Vd/1.12;
%
Kp1 = Kp1/factor; Ki1 = Ki1/factor;
Kp2 = Kp2/factor; Ki2 = Ki2/factor;
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

P = 1.5*(vTLLd*iRd + vTLLq*iRq);
Q = 1.5*(vTLLq*iRd - vTLLd*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);
delP = vTLLd * diTLMddt + vTLLq * diTLMqdt + dvTLLddt * iTLMd + dvTLLqdt * iTLMq;
delV =  Vt^(-0.5) * (vTLLd*dvTLLddt + vTLLq*dvTLLqdt );
delPdt = delP/delV;
%delQdt = Qref - Q;
delQdt = Vref - Vt;

alpha = -Kp1*(delPdt) - Ki1* delPInt;
%Vcstar = (1+ Kp2*(Qref-Q) + Ki2*delQInt)*sqrt(vTLLd^2+ vTLLq^2)
Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt;
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