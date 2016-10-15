function testPVdroopCfdt
Pref = 3/4;
Vref = 1;
Qref = 0.01;
omega0=1;
CTL = 0.01;

PL = Pref;
QL = 0.95*Qref;

Lf = 0.005;
%Cf = 1e-2;
Rf = 0.5;
x0= randn(10,1);
tspan = [0,1];
[t,x] = ode45(@PVDynamics,tspan,x0);

function dx = PVDynamics(t,x)
vPVd = x(1);
vPVq = x(2);
iFd = x(3);
iFq = x(4);
Cf = x(5);
CfIn = x(6);
vTLLd = x(7);
vTLLq = x(8);
iLd = x(9);
iLq = x(10);

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
            dvTLLddt = (iInLd - iLd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iLq)/CTL - dphidt*vTLLd;

%Equivalent R and L for Load
RL = PL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);
LL = QL*(vTLLd^2 + vTLLq^2)/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLLd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLLq - RL*iLq)/LL - omega0*iLd;

            dx = 377*[dvPVddt;dvPVqdt; diFddt;diFqdt;...
                dCfdt;CfIndt;dvTLLddt ; dvTLLqdt ;diLddt;diLqdt];

end
save('dataPV.mat')
end