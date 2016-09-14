function testPVControlWithoutInf
Pref = 3/4;
Vref = 1.15;
Qref = 0.1;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
% VdrefArr = [1.15  0.75 1];
RR = 0.4; LR = 50;%0.1;
k1 = LR*0.1; k2 = LR*0.1;
c1 = 0.01; c2 = 0.01;

% tArray = [0 0.2 0.4 0.6];
% Kgp = 0.2519;
% Kgq = 0.2632;
x0= 0.5*ones(10,1)
% t=[]; x=[];
% for j = 1:numel(VdrefArr)
%     Vd = VdrefArr(j);
%     factor = Vd/1.12;
%Kp1 = 0.1/(0.85*factor); Ki1 = 1/(1.35*factor); Kp2 = 1/(0.5*factor); Ki2 = 1/(2*factor);
 Kp1 = 0.02; Ki1 = 0.2;
 Kp2 = 0.4; Ki2 = 0.25;
%Kp1 = 0.002/(0.85*factor); Ki1 = 0.2/(1.35*factor); Kp2 = 0.002/(0.5*factor); Ki2 = 0.2/(2*factor);
% tspan = [tArray(j) tArray(j+1)];
tspan = [0,1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);
% x0 = xStep(end,:);
% t = [t,tStep'];
% x = [x, xStep'];
% end


function [dx] = PVDynamics(t,x)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iRd = x(5);
iRq = x(6);
delPInt = x(7);
delQInt = x(8);
vTLRd = 1;%x(9);
vTLRq = 0;%x(10);
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq;
%iInRd = -Power; iInRq = 0;
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = 0;%(iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = 0;%(iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
P = 1.5*(vTLLd*iRd + vTLLq*iRq);
Q = 1.5*(vTLLq*iRd - vTLLd*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);
delPdt = Pref - P;
delQdt = Qref - Q;
%delQdt = Vref - Vt;
slide1 = delPdt + c1*delPInt;
slide2 = delQdt + c2*delQInt;
alpha = Kp1*(Pref - P) + Ki1* delPInt + k1*sign(slide1);
Vcstar = (1+ Kp2*(Qref-Q) + Ki2*delQInt);%*Vt ;%+ k2*sign(slide2);
%Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt + k2*sign(slide2);
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diRddt;diRqdt;delPdt;delQdt;dvTLRddt ; dvTLRqdt]; 
            plot(t,x(7),'b*',t,x(8),'r*');hold on;

end

save('dataPV.mat')
end