function testPVdroopCfdt
Pref = 3/4;
Vref = 1;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-5;
LTL = 0.1;

Lf = 0.01;
%Cf = 1e-2;
Rf = 1;
VdrefArr = [1.02 0.7 1.1];
tArray = [0 1.5 1.8 2.5];
Kgp = 0.2519;
Kgq = 0.2632;
x0= ones(10,1);
t=[]; x=[];
for k = 1:numel(VdrefArr)
    Vd = VdrefArr(k);
    tspan = [tArray(k) tArray(k+1)];
[tStep,xStep] = ode45(@(t,x)PVDynamics(t,x,Vd),tspan,x0);
x0=xStep(end,:);
t = [t tStep'];
x =[x xStep'];
end

function dx = PVDynamics(t,x,vTLRd)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
vPVd = x(5);
vPVq = x(6);
iFd = x(7);
iFq = x(8);
Cf = x(9);
CfIn = x(10);
vTLRq = 0;

t
vACd = vTLLd; vACq = vTLLq;

dphidt = omega0;
%RL = -Pref/(1.5*(vACd^2 + vACq^2)*(Pref^2 + Qref^2)); 
%RL = (Pref-1.5*(iFd^2+iFq^2)*Rf)/(1.5*(Vref^2)*(Pref^2 + Qref^2)); 
%LL = imag((vPVd + 1i*vPVq)/(iPVd + 1i*iPVq));%0.01;%-Qref/(1.5*(Vref^2)*(Pref^2 + Qref^2)); 
dCfdt =  0.1*(sqrt(vPVd^2+vPVq^2) - Vref) + 0.01*CfIn;%(Qref + 1.5*(iFd^2+iFq^2)*Lf)/(1.5*(vPVd^2+ vPVq^2));
CfIndt = (sqrt(vPVd^2+vPVq^2) - Vref);
ConvMat = [vPVd vPVq;
            vPVq -vPVd];
%ConvMat = [1 0; 0 -1];
I = ConvMat\[Pref-1.5*(iFd^2+iFq^2)*Rf;Qref-1.5*(iFd^2+iFq^2)*Lf];
iRefd = I(1)/1.5;
iRefq = I(2)/1.5;

iPVd = iRefd;
iPVq = iRefq;

%diPVddt = dphidt*iPVq + (vPVd - RL*iPVd)/LL;
%diPVqdt = (vPVq - RL*iPVq)/LL - dphidt*iPVd;
dvPVddt = (iPVd - iFd)/Cf + omega0*vPVq;
dvPVqdt = (iPVq - iFq)/Cf - omega0*vPVd;
diFddt = (vPVd - vACd - Rf*iFd)/Lf + omega0*iFq;
diFqdt = (vPVq - vACq - Rf*iFq)/Lf - omega0*iFd;

%newdt = (abs(vACd + 1i*vACq) - Vref);

iInLd = iFd;
iInLq = iFq; 
            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                ...%diPVddt; diPVqdt;...
                dvPVddt;dvPVqdt; diFddt;diFqdt;...
                dCfdt;CfIndt];

end
save('dataPV.mat')
end