function testPVMPPTWithoutInf
Pref = 3/4;
Vref = 1.05;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.05];%  0.95 1];
%  Kp1 = 2*Pref*1e-2; Ki1 = Pref^2; 
%  Kp2 = 2*Vref; Ki2 = Vref^2*1e3;
 Kp1= 0.1272; Ki1 = 0.282;
 Kp2 = 12.37; Ki2 = 1.62;
%Kp1 = 1; Ki1 = 100;
%Kp2 = 1; Ki2 = 100;
RR = 0.4; LR = 0.1;
tArray = [0 0.1 0.8 1.5];
Kgp = 0.2519;
Kgq = 0.2632;
% x0= [1.18665
%     0.07455
%    -0.1247
%    -0.7052
%    -0.0981
%    -0.7640
%     0.0849
%    -1.8572
%     1.16035
%     0.2705]';
x0 = 0.5*ones(10,1);
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


function [dx] = PVDynamics(t,x,PLoad)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iRd = x(5);
iRq = x(6);
delPInt = x(7);
delQInt = x(8);
vTLRd = x(9);
vTLRq = x(10);
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq; 
convMat = [vTLRd vTLRq
            -vTLRq vTLRd];
%convMat = eye(2);
QLoad = 0.2;
I = convMat\[-PLoad;-QLoad];
iInRd = I(1)/1.5; iInRq = I(2)/1.5; 
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
            
P = 1.5*(vTLLd*iRd + vTLLq*iRq);
Q = 1.5*(vTLLq*iRd - vTLLd*iRq);
Vt = abs(vTLLd + 1i*vTLLq);
vRRd = vTLLd; vRRq = vTLLq;

delP = Pref -P;%vTLLd * diRddt + vTLLq * diRqdt + dvTLLddt * iRd + dRqdt * iTLMq;
delV =  Vt^(-0.5) * (vTLLd*dvTLLddt + vTLLq*dvTLLqdt );
delPdt = 0;%abs(iRd + 1i*iRq);% + sqrt(iRd^2 + iRq^2)*((diTLMddt^2 + diTLMqdt^2)/(dvTLLddt^2 + dvTLLqdt^2));%delP/delV;
%delQdt = Qref - Q;
delQdt = 0;%Vref - Vt;

alpha = 0;%-Kp1*(delPdt) - Ki1* delPInt;
%Vcstar = (1+ Kp2*(Qref-Q) + Ki2*delQInt)*sqrt(vTLLd^2+ vTLLq^2)
Vcstar = Vt;%(1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt;

vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;


            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diRddt;diRqdt;delPdt;delQdt;...
                dvTLRddt ; dvTLRqdt]; 
            %plot(t,x(7),'b*',t,x(8),'r*');hold on;

end
save('dataPV.mat')
end