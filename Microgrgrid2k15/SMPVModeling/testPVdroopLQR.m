function testPVdroopLQR
Pref = 3/4;
Vref = 1.15;
Qref = 0;
omega0=1;
CTL = 0.01;
RTL = 1e-4;
LTL = 0.1;

Lf = 0.1;
Rf = 1e-3;
VdrefArr = [1];% 0.7 1];
tArray = [0 1 1 2.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= 0.5*ones(6,1);
t=[]; x=[];
for j = 1:numel(VdrefArr)
    Vd = VdrefArr(j);
    tspan = [tArray(j) tArray(j+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0 = xStep(end,:);
t = [t,tStep'];
x = [x, xStep'];
end

function dx = PVDynamics(t,x,vTLRd)
iSd = x(1);
iSq = x(2);
vTLLd = x(3);
vTLLq = x(4);
iTLMd = x(5);
iTLMq = x(6);
vTLRq = 0;

Vdref = 1; Vqref = 0;
t
vACd = vTLLd; vACq = vTLLq;

ConvMat = [Vdref Vqref;
            Vqref -Vdref];
I = ConvMat\[Pref;Qref];
iSdref = I(1)/1.5;
iSqref = I(2)/1.5;
xref = [iSdref;iSqref;Vdref;Vqref];
vPVdref = Vdref + Rf*iSdref - omega0*iSqref*Lf;
vPVqref = Vqref + Rf*iSqref + omega0*iSdref*Lf;

k =  [3.0460   -0.0000    0.4142    0.0000
   -0.0000    3.0460   -0.0000    0.4142];
vPVd = -k(1,:)*(x(1:4)-xref) + vPVdref;
vPVq = -k(2,:)*(x(1:4)-xref) + vPVqref;
diSddt = (vPVd - vACd - Rf*iSd)/Lf + omega0*iSq;
diSqdt = (vPVq - vACq - Rf*iSq)/Lf - omega0*iSd;
%ddeltadt = omega-omega0;
%domegadt = -(omega - omega0) - Kp*(P-Pref);
%dVdt = -(V-Vref) + Kq*(Q-Qref);

dphidt = omega0;
iInLd = iSd; iInLq = iSq; 
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            
            dx = 377*[diSddt;diSqdt;...
                ...%ddeltadt;domegadt;dVdt;
                dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt];           

end
save('dataPV.mat')
end