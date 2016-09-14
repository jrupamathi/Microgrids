function testPVSlideControl
Pref = 3/4;
Vref = 1.15;
Qref = 0.5;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.05];%  0.95 1];
RR = 0.4; LR = 0.1;
tArray = [0 1 0.2 0.3];
k1 = 0;%LR*1;%*0.01;
k2 = 0;%LR*1000;%*0.01;
c1 = 0.1; c2 = 0.01; 
x0= [1;0;1;0;1;0;1;0];
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    
tspan = [tArray(j) tArray(j+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0 = xStep(end,:);
t = [t,tStep'];
x = [x, xStep'];
end


function [dx,alpha,Vcstar] = PVDynamics(t,x,Power)
vTLLd = x(1);
vTLLq = x(2);
vTLRd = x(3);
vTLRq = x(4);
iTLMd = x(5);
iTLMq = x(6);
iRd = x(7);
iRq = x(8);
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq;
iInRd = -Power; iInRq = 0;
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
%             
% convMat = [vTLLd vTLLq;
%             -vTLLq vTLLd];
%convMat = eye(2);
% I = convMat\[Pref;Qref];
%  iRdref = I(1)/1.5; iRqref = I(2)/1.5;         

vQ = (3*vTLLd^2*vTLLq + 3*vTLLq^3 + 3*LR*iRd*vTLLd^2 + 3*LR*iRd*vTLLq^2 + 3*RR*iRq*vTLLd^2 + 3*RR*iRq*vTLLq^2 - 3*LR*c2*iRq*vTLLd^2 - 3*LR*c1*iRq*vTLLq^2 + 2*LR*Pref*c1*vTLLq + 2*LR*Qref*c2*vTLLd - 3*LR*dvTLLddt*iRd*vTLLq + 3*LR*dvTLLqdt*iRd*vTLLd - 3*LR*dvTLLddt*iRq*vTLLd - 3*LR*dvTLLqdt*iRq*vTLLq - 3*LR*c1*iRd*vTLLd*vTLLq + 3*LR*c2*iRd*vTLLd*vTLLq)/(3*(vTLLd^2 + vTLLq^2));
vD = -(3*LR*iRq*vTLLd^2 - 3*vTLLd^3 - 3*vTLLd*vTLLq^2 + 3*LR*iRq*vTLLq^2 - 3*RR*iRd*vTLLd^2 - 3*RR*iRd*vTLLq^2 + 3*LR*c1*iRd*vTLLd^2 + 3*LR*c2*iRd*vTLLq^2 - 2*LR*Pref*c1*vTLLd + 2*LR*Qref*c2*vTLLq + 3*LR*dvTLLddt*iRd*vTLLd + 3*LR*dvTLLqdt*iRd*vTLLq - 3*LR*dvTLLddt*iRq*vTLLq + 3*LR*dvTLLqdt*iRq*vTLLd + 3*LR*c1*iRq*vTLLd*vTLLq - 3*LR*c2*iRq*vTLLd*vTLLq)/(3*(vTLLd^2 + vTLLq^2));

slide1 = Pref - 1.5*(vTLLd*iRd +vTLLq*iRq);%(VTL*Vc*sin(alpha-delta)/LR);
slide2 = Qref - 1.5*(-vTLLq*iRd + vTLLd*iRq);

alpha = atan(vQ/vD) + k1*sign(slide1);
Vc = abs(sqrt(vD^2 + vQ^2)) + k2*sign(slide2);

vRLd = Vc*cos(alpha); vRLq = Vc*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt; dvTLRddt ; dvTLRqdt;...
                diRddt;diRqdt]; 
            plot(t,Vc,'b*',t,alpha,'r*');hold on;
end
save('dataPV.mat')
end