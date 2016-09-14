function testPVdroopSimulatorPQLoad
Pref = 3/4;
Vref = 1.05;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;
VdrefArr = [1];% 0.95; 1];
% Kp1 = 2*Iref; Ki1 = Iref^2; 
% Kp2 = 2*Vref*50; Ki2 = Vref^2;
Kp1= 0.02; Ki1 = 0.05;
Kp2 = 0.2; Ki2 = 0.2;
RR = 0.4; LR = 0.1;
tArray = [0.5 1 0.8 1.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= [1.0374
   -0.0149
    0.0096
   -0.4760
    0.0337
   -0.4571
    2.9186
    0.3167]';
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
iRd = x(3);
iRq = x(4);
delPInt = x(5);
delQInt = x(6);
iLd = x(7);
iLq = x(8);
t
dphidt = omega0;
iInLd = iRd; iInLq = iRq; 
            dvTLLddt = (iInLd - iLd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iLq)/CTL - dphidt*vTLLd;

P = 1.5*(vTLLd*iRd + vTLLq*iRq);
PL = P;  
            %Equivalent R and L for Load
            QL = PL*tan(acos(0.8));

RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;
Q = (vTLLq*iRd - vTLLd*iRq);
Vt = sqrt(vTLLd^2+ vTLLq^2);
delP = vTLLd*diLddt + vTLLq*diLqdt + diLddt*iLd +  dvTLLqdt*iLq;
delV =  Vt^(-0.5) * (vTLLd*dvTLLddt + vTLLq*dvTLLqdt );
delPdt = delP/delV;
% delQdt = Qref - Q;
delQdt = Vref - Vt;

alpha = -Kp1*(delPdt) - Ki1* delPInt;
% Vcstar = (Kp2*(Qref-Q) + Ki2*delQInt);%*Vt;
Vcstar = (1+ Kp2*(Vref-Vt) + Ki2*delQInt)*Vt;
vRLd = Vcstar*cos(alpha);
vRLq = Vcstar*sin(alpha);
vRRd = vTLLd; vRRq = vTLLq;


diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diRddt;diRqdt;delPdt;delQdt; diLddt;diLqdt]; 
            plot(t,x(7),'b*',t,x(8),'r*');hold on;

end
save('testPVMPPT.mat')
end