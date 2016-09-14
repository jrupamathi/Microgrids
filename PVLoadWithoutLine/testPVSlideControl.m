function testPVSlideControl
Pref = 3/4;
Vref = 1.15;
Qref = 0.5;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [0.5*Pref];%  0.95 1];
RR = 0.4; LR = 0.1;
tArray = [0 1 0.2 0.3];
k1 = LR*0.001;
k2 = LR*0.001;
c1 = 0.2; c2 = 0.2; 
x0=[1.1;0.1;1.1;0.1;0.01;0.01;1.1;0.1];
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    
tspan = [tArray(j) tArray(j+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);
x0 = xStep(end,:);
t = [t,tStep'];
x = [x, xStep'];
end


function [dx] = PVDynamics(t,x)
vTLLd = x(1);
vTLLq = x(2);
iRd = x(3);
iRq = x(4);
iRdInt = x(5);
iRqInt = x(6);
iLd = x(7);
iLq = x(8);

t
dphidt = omega0;
iInLd = iRd; iInLq = iRq;
convMat = [vTLLd vTLLq;
             -vTLLq vTLLd];
%convMat = eye(2);
I = convMat\[Pref;Qref];
 iRdref = I(1)/1.5; iRqref = I(2)/1.5;         

 PL = Pref;
 QL = Qref;
 %Equivalent R and L for Load
% RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
% LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;


% iInRd = -Power/1.5; iInRq = 0;iTLMd = iRdref; iTLMq = iRqref;
            dvTLLddt = (iInLd - iLd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iLq)/CTL - dphidt*vTLLd;
            
 diRdrefdt = dvTLLddt*((2*Pref)/(3*(vTLLd^2 + vTLLq^2)) - (4*vTLLd*(Pref*vTLLd - Qref*vTLLq))/(3*(vTLLd^2 + vTLLq^2)^2)) - dvTLLqdt*((2*Qref)/(3*(vTLLd^2 + vTLLq^2)) + (4*vTLLq*(Pref*vTLLd - Qref*vTLLq))/(3*(vTLLd^2 + vTLLq^2)^2));
diRqrefdt = dvTLLqdt*((2*Pref)/(3*(vTLLd^2 + vTLLq^2)) - (4*vTLLq*(Pref*vTLLq + Qref*vTLLd))/(3*(vTLLd^2 + vTLLq^2)^2)) + dvTLLddt*((2*Qref)/(3*(vTLLd^2 + vTLLq^2)) - (4*vTLLd*(Pref*vTLLq + Qref*vTLLd))/(3*(vTLLd^2 + vTLLq^2)^2));

slide1 = (iRdref - iRd) + c1*(iRdInt);
slide2 = (iRqref - iRq) + c1*(iRqInt);

vRLd = vTLLd + LR*diRdrefdt - LR*iRq + RR*iRd - LR*c1*iRd + LR*c1*iRdref...
 + k1*sign(slide1);  

vRLq = vTLLq + LR*diRqrefdt + LR*iRd + RR*iRq - LR*c2*iRq + LR*c2*iRqref +...
    k2*sign(slide2);
vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
diRdIntdt = iRdref - iRd;
diRqIntdt = iRqref - iRq;
            dx = 377*[dvTLLddt ; dvTLLqdt ; ...
                diRddt;diRqdt;diRdIntdt;diRqIntdt;diLddt;diLqdt]; 
            plot(t,x(end),'b*',t,x(end-1),'r*');hold on;
end
save('dataPV.mat')
end