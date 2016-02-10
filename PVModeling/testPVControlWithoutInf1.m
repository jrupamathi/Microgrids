function testPVControlWithoutInf
Pref = 3/4;
Vref = 1.15;
Qref = 0.01;
omega0=1;
CTL = 0.01;CPV = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1.15];%  0.75 1];
RR = 0.4; LR = 0.1; alph = 0;
%k1 = 12*LTL*0.01; k2 = 12*0.2*LTL*0.01;
k1 = 1; k2 = -1;
c1 = 2.5; c2 = 0.3;

tArray = [0 0.2 0.4 0.6];
Kgp = 0.2519;
Kgq = 0.2632;
x0= [1.1;0.1;1.01;0.1;1.1;0.1;0.1;0.1; 1.1;0.1;0.01;0.01];
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    factor = Vd/1.12;
%Kp1 = 0.1/(0.85*factor); Ki1 = 1/(1.35*factor); Kp2 = 1/(0.5*factor); Ki2 = 1/(2*factor);
 Kp1 = 0.02; Ki1 = 0.2;
 Kp2 = -0.02; Ki2 = 0.2;
%Kp1 = 0.002/(0.85*factor); Ki1 = 0.2/(1.35*factor); Kp2 = 0.002/(0.5*factor); Ki2 = 0.2/(2*factor);
tspan = [tArray(j) tArray(j+1)];
[tStep,xStep] = ode15s(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0 = xStep(end,:);
t = [t,tStep'];
x = [x, xStep'];
end


function [dx] = PVDynamics(t,x,Power)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iRd = x(5);
iRq = x(6);
vRLd = x(7);
vRLq = x(8);
vTLRd = x(9);
vTLRq = x(10);
dPInt = x(11);
dVInt = x(12);
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq;
iInRd = -Power*0.2; iInRq = 0;
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;
   vACd = vRLd; vACq = vRLq;  
            iPVdMid =   (12*CPV*vACq^3 + 12*LTL*iRd^2*vACq + 12*CPV*vACd^2*vACq - 12*CPV*vACq^2*vTLLq - 12*CPV*vACd*vACq*vTLLd - 8*CPV*LTL*c1*vACq^3 - 12*LTL*iRd*iRq*vACd - 6*CPV*LTL*Pref*c2*iRq + 8*CPV*LTL*Pref*c2*vACq - 6*CPV*LTL*Vref^2*c1*iRq + 8*CPV*LTL*Vref^2*c1*vACq + 6*CPV*LTL*c1*iRq*vACd^2 + 6*CPV*LTL*c1*iRq*vACq^2 - 12*CPV*LTL*c2*iRq*vACq^2 + 9*CPV*LTL*c2*iRq^2*vACq - 8*CPV*LTL*c1*vACd^2*vACq + 9*CPV*LTL*c2*iRd*iRq*vACd - 12*CPV*LTL*c2*iRd*vACd*vACq)/(12*LTL*(iRd*vACq - iRq*vACd));
            iPVqMid = - (12*CPV*vACd^3 + 12*LTL*iRq^2*vACd + 12*CPV*vACd*vACq^2 - 12*CPV*vACd^2*vTLLd - 12*CPV*vACd*vACq*vTLLq - 8*CPV*LTL*c1*vACd^3 - 12*LTL*iRd*iRq*vACq - 6*CPV*LTL*Pref*c2*iRd + 8*CPV*LTL*Pref*c2*vACd - 6*CPV*LTL*Vref^2*c1*iRd + 8*CPV*LTL*Vref^2*c1*vACd + 6*CPV*LTL*c1*iRd*vACd^2 - 12*CPV*LTL*c2*iRd*vACd^2 + 9*CPV*LTL*c2*iRd^2*vACd + 6*CPV*LTL*c1*iRd*vACq^2 - 8*CPV*LTL*c1*vACd*vACq^2 + 9*CPV*LTL*c2*iRd*iRq*vACq - 12*CPV*LTL*c2*iRq*vACd*vACq)/(12*LTL*(iRd*vACq - iRq*vACd));
[ang,Mag]=cart2pol(iPVdMid,iPVqMid);
P = 1.5*(vRLd*iRd + vRLq*iRq);
dPIntdt = Pref - P;
dVIntdt = Vref^2 - vRLd^2 + vRLq^2;
slide1 = dPIntdt + dPInt;
slide2 = dVIntdt + dVInt;
ang = ang + Kp1*dPIntdt + Ki1*dPInt + k1*sign(slide1);%*norm([slide1;slide2])^(alph)*sign(slide1);
Mag = Mag + Kp2*dVIntdt + Ki2*dVInt - k2*sign(slide2);%*norm([slide1;slide2])^(alph)*sign(slide2);
iPVd = Mag*cos(ang); iPVq = Mag*sin(ang);
           
dvRLddt = (iPVd - iRd)/CPV + omega0*vRLq;
dvRLqdt = (iPVq - iRq)/CPV - omega0*vRLd;

            vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diRddt;diRqdt;dvRLddt;dvRLqdt;dvTLRddt ; dvTLRqdt;...
                dPIntdt;dVIntdt]; 
            plot(t,x(11),'b*',t,x(12),'r*');hold on;

end
save('dataPV.mat')
end