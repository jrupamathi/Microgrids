function testPVdroopSimulatorPQLoad
Pref = 3/4;
Vref = 1.15;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.05];%  0.95 1];
Kp1 = 0.002; Ki1 = 0.2; 
Kp2 = 0.002; Ki2 = 0.2;
% RR = 0.4; LR = 0.1;
RR = 0.005;
LR = 50;

tArray = [0 1 0.8 1.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= [1.1; 0.01; 1.05; 0.1; 1.12; 0.001; 1.02; 0.01];
    Vd = 1;
    
tspan = [0 1];
[t,x] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);

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
delI = diTLMddt + diTLMqdt; 
delV = dvTLLddt + dvTLLqdt;
delPdt = delI/delV + sqrt((iTLMd^2+iTLMq^2)/(vTLLd^2 + vTLLq^2));
delQdt = Qref - Q;
% delQdt = Vref - Vt;

alpha = Kp1*(delPdt) + Ki1* delPInt;
Vcstar = (1+ Kp2*(Qref-Q) + Ki2*delQInt)*sqrt(vTLLd^2+ vTLLq^2);
% Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt;
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diRddt;diRqdt;delPdt;delQdt]; 
%             plot(t,x(7),'b*',t,x(8),'r*');hold on;

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
save('dataPV.mat')
end