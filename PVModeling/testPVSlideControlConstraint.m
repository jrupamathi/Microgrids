function testPVSlideControl
Pref = 3/4;
Vref = 1.15;
Qref = 0;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.05];%  0.95 1];
RR = 0.4; LR = 0.1;
tArray = [0 1 0.2 0.3];
k1 = LR*0.01;
k2 = LR*0.01;
c1 = 0.1; c2 = 1; 
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

vQ = (3*vTLLd*(- 4*LR^2*c1^2*iRd^2*vTLLd^2 - 8*LR^2*c1^2*iRd*iRq*vTLLd*vTLLq + (16*Pref*LR^2*c1^2*iRd*vTLLd)/3 - 4*LR^2*c1^2*iRq^2*vTLLq^2 + (16*Pref*LR^2*c1^2*iRq*vTLLq)/3 - (16*Pref^2*LR^2*c1^2)/9 - 8*LR^2*c1*dvTLLddt*iRd^2*vTLLd - 8*LR^2*c1*dvTLLddt*iRd*iRq*vTLLq + (16*Pref*LR^2*c1*dvTLLddt*iRd)/3 - 8*LR^2*c1*dvTLLqdt*iRd*iRq*vTLLd - 8*LR^2*c1*dvTLLqdt*iRq^2*vTLLq + (16*Pref*LR^2*c1*dvTLLqdt*iRq)/3 + 8*LR^2*c1*iRd^2*vTLLd*vTLLq - 8*LR^2*c1*iRd*iRq*vTLLd^2 + 8*LR^2*c1*iRd*iRq*vTLLq^2 - (16*Pref*LR^2*c1*iRd*vTLLq)/3 - 8*LR^2*c1*iRq^2*vTLLd*vTLLq + (16*Pref*LR^2*c1*iRq*vTLLd)/3 - 4*LR^2*dvTLLddt^2*iRd^2 - 8*LR^2*dvTLLddt*dvTLLqdt*iRd*iRq + 8*LR^2*dvTLLddt*iRd^2*vTLLq - 8*LR^2*dvTLLddt*iRd*iRq*vTLLd - 4*LR^2*dvTLLqdt^2*iRq^2 + 8*LR^2*dvTLLqdt*iRd*iRq*vTLLq - 8*LR^2*dvTLLqdt*iRq^2*vTLLd - 4*LR^2*iRd^2*vTLLq^2 + 8*LR^2*iRd*iRq*vTLLd*vTLLq - 4*LR^2*iRq^2*vTLLd^2 + 8*LR*RR*c1*iRd^2*vTLLd^2 + 16*LR*RR*c1*iRd*iRq*vTLLd*vTLLq - (16*Pref*LR*RR*c1*iRd*vTLLd)/3 + 8*LR*RR*c1*iRq^2*vTLLq^2 - (16*Pref*LR*RR*c1*iRq*vTLLq)/3 + 8*LR*RR*dvTLLddt*iRd^2*vTLLd + 8*LR*RR*dvTLLddt*iRd*iRq*vTLLq + 8*LR*RR*dvTLLqdt*iRd*iRq*vTLLd + 8*LR*RR*dvTLLqdt*iRq^2*vTLLq - 8*LR*RR*iRd^2*vTLLd*vTLLq + 8*LR*RR*iRd*iRq*vTLLd^2 - 8*LR*RR*iRd*iRq*vTLLq^2 + 8*LR*RR*iRq^2*vTLLd*vTLLq + 8*LR*c1*iRd*vTLLd^3 + 8*LR*c1*iRd*vTLLd*vTLLq^2 + 8*LR*c1*iRq*vTLLd^2*vTLLq + 8*LR*c1*iRq*vTLLq^3 - (16*Pref*LR*c1*vTLLd^2)/3 - (16*Pref*LR*c1*vTLLq^2)/3 + 8*LR*dvTLLddt*iRd*vTLLd^2 + 8*LR*dvTLLddt*iRd*vTLLq^2 + 8*LR*dvTLLqdt*iRq*vTLLd^2 + 8*LR*dvTLLqdt*iRq*vTLLq^2 - 8*LR*iRd*vTLLd^2*vTLLq - 8*LR*iRd*vTLLq^3 + 8*LR*iRq*vTLLd^3 + 8*LR*iRq*vTLLd*vTLLq^2 - 4*RR^2*iRd^2*vTLLd^2 - 8*RR^2*iRd*iRq*vTLLd*vTLLq - 4*RR^2*iRq^2*vTLLq^2 - 8*RR*iRd*vTLLd^3 - 8*RR*iRd*vTLLd*vTLLq^2 - 8*RR*iRq*vTLLd^2*vTLLq - 8*RR*iRq*vTLLq^3 - 4*vTLLd^4 - 8*vTLLd^2*vTLLq^2 + 4*vTLLd^2 - 4*vTLLq^4 + 4*vTLLq^2)^(1/2) + 6*vTLLd^2*vTLLq + 6*vTLLq^3 + 6*LR*iRd*vTLLq^2 + 6*RR*iRq*vTLLq^2 - 6*LR*iRq*vTLLd*vTLLq + 6*RR*iRd*vTLLd*vTLLq - 6*LR*c1*iRq*vTLLq^2 + 4*LR*Pref*c1*vTLLq - 6*LR*dvTLLddt*iRd*vTLLq - 6*LR*dvTLLqdt*iRq*vTLLq - 6*LR*c1*iRd*vTLLd*vTLLq)/(6*(vTLLd^2 + vTLLq^2));  
if ~isreal(vQ)
    vQ = vTLLq;
end

vD = -(2*LR*((3*dvTLLddt*iRd)/2 + (3*dvTLLqdt*iRq)/2 + c1*((3*iRd*vTLLd)/2 - Pref + (3*iRq*vTLLq)/2) + (3*vTLLd*(iRq - (vTLLd + RR*iRd)/LR))/2 - (3*vTLLq*(iRd + (vTLLq + RR*iRq - (3*vTLLd*(- 4*LR^2*c1^2*iRd^2*vTLLd^2 - 8*LR^2*c1^2*iRd*iRq*vTLLd*vTLLq + (16*Pref*LR^2*c1^2*iRd*vTLLd)/3 - 4*LR^2*c1^2*iRq^2*vTLLq^2 + (16*Pref*LR^2*c1^2*iRq*vTLLq)/3 - (16*Pref^2*LR^2*c1^2)/9 - 8*LR^2*c1*dvTLLddt*iRd^2*vTLLd - 8*LR^2*c1*dvTLLddt*iRd*iRq*vTLLq + (16*Pref*LR^2*c1*dvTLLddt*iRd)/3 - 8*LR^2*c1*dvTLLqdt*iRd*iRq*vTLLd - 8*LR^2*c1*dvTLLqdt*iRq^2*vTLLq + (16*Pref*LR^2*c1*dvTLLqdt*iRq)/3 + 8*LR^2*c1*iRd^2*vTLLd*vTLLq - 8*LR^2*c1*iRd*iRq*vTLLd^2 + 8*LR^2*c1*iRd*iRq*vTLLq^2 - (16*Pref*LR^2*c1*iRd*vTLLq)/3 - 8*LR^2*c1*iRq^2*vTLLd*vTLLq + (16*Pref*LR^2*c1*iRq*vTLLd)/3 - 4*LR^2*dvTLLddt^2*iRd^2 - 8*LR^2*dvTLLddt*dvTLLqdt*iRd*iRq + 8*LR^2*dvTLLddt*iRd^2*vTLLq - 8*LR^2*dvTLLddt*iRd*iRq*vTLLd - 4*LR^2*dvTLLqdt^2*iRq^2 + 8*LR^2*dvTLLqdt*iRd*iRq*vTLLq - 8*LR^2*dvTLLqdt*iRq^2*vTLLd - 4*LR^2*iRd^2*vTLLq^2 + 8*LR^2*iRd*iRq*vTLLd*vTLLq - 4*LR^2*iRq^2*vTLLd^2 + 8*LR*RR*c1*iRd^2*vTLLd^2 + 16*LR*RR*c1*iRd*iRq*vTLLd*vTLLq - (16*Pref*LR*RR*c1*iRd*vTLLd)/3 + 8*LR*RR*c1*iRq^2*vTLLq^2 - (16*Pref*LR*RR*c1*iRq*vTLLq)/3 + 8*LR*RR*dvTLLddt*iRd^2*vTLLd + 8*LR*RR*dvTLLddt*iRd*iRq*vTLLq + 8*LR*RR*dvTLLqdt*iRd*iRq*vTLLd + 8*LR*RR*dvTLLqdt*iRq^2*vTLLq - 8*LR*RR*iRd^2*vTLLd*vTLLq + 8*LR*RR*iRd*iRq*vTLLd^2 - 8*LR*RR*iRd*iRq*vTLLq^2 + 8*LR*RR*iRq^2*vTLLd*vTLLq + 8*LR*c1*iRd*vTLLd^3 + 8*LR*c1*iRd*vTLLd*vTLLq^2 + 8*LR*c1*iRq*vTLLd^2*vTLLq + 8*LR*c1*iRq*vTLLq^3 - (16*Pref*LR*c1*vTLLd^2)/3 - (16*Pref*LR*c1*vTLLq^2)/3 + 8*LR*dvTLLddt*iRd*vTLLd^2 + 8*LR*dvTLLddt*iRd*vTLLq^2 + 8*LR*dvTLLqdt*iRq*vTLLd^2 + 8*LR*dvTLLqdt*iRq*vTLLq^2 - 8*LR*iRd*vTLLd^2*vTLLq - 8*LR*iRd*vTLLq^3 + 8*LR*iRq*vTLLd^3 + 8*LR*iRq*vTLLd*vTLLq^2 - 4*RR^2*iRd^2*vTLLd^2 - 8*RR^2*iRd*iRq*vTLLd*vTLLq - 4*RR^2*iRq^2*vTLLq^2 - 8*RR*iRd*vTLLd^3 - 8*RR*iRd*vTLLd*vTLLq^2 - 8*RR*iRq*vTLLd^2*vTLLq - 8*RR*iRq*vTLLq^3 - 4*vTLLd^4 - 8*vTLLd^2*vTLLq^2 + 4*vTLLd^2 - 4*vTLLq^4 + 4*vTLLq^2)^(1/2) + 6*vTLLd^2*vTLLq + 6*vTLLq^3 + 6*LR*iRd*vTLLq^2 + 6*RR*iRq*vTLLq^2 - 6*LR*iRq*vTLLd*vTLLq + 6*RR*iRd*vTLLd*vTLLq - 6*LR*c1*iRq*vTLLq^2 + 4*LR*Pref*c1*vTLLq - 6*LR*dvTLLddt*iRd*vTLLq - 6*LR*dvTLLqdt*iRq*vTLLq - 6*LR*c1*iRd*vTLLd*vTLLq)/(6*(vTLLd^2 + vTLLq^2)))/LR))/2))/(3*vTLLd);
if ~isreal(vD)
    vD = vTLLd;
end
            slide1 = Pref - 1.5*(vTLLd*iRd+ vTLLq*iRq); 
            slide2 = abs(sqrt(vQ^2 + vD^2))-1;

alpha = atan(vQ/vD) + k1*sign(slide1);
Vc = abs(sqrt(vD^2 + vQ^2)) + k2*sign(slide2);

vRLd = Vc*cos(alpha); vRLq = Vc*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;

diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt; dvTLRddt ; dvTLRqdt;...
                diRddt;diRqdt]; 
            plot(t,x(1),'b*',t,x(2),'r*');hold on;
end
save('dataPV.mat')
end