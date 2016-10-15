function testPVdroopCfdt
Pref = 3/4;
Vref = 1;
Qref = 0.01;
omega0=1;
CTL = 0.01;
RTL = 1e-5;
LTL = 0.1;

%Load considered
PL = 0.98*Pref; QL = PL*tan(acos(0.8));

Lf = 0.1;
%Cf = 1e-2;
Rf = 0.4;
x0= [-1.1347
   -1.1905
   -0.4338
    0.4122
    0.1517
   -0.1459
    0.0301
   -0.0270
    0.8930
    0.9433];
    tspan = [0 1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function dx = PVDynamics(t,x)
vTLLd = x(1);
vTLLq = x(2);
iTLMd = x(3);
iTLMq = x(4);
iFd = x(5);
iFq = x(6);
iLd = x(7);
iLq = x(8);
vTLRd = x(9);
vTLRq = x(10);

t
vACd = vTLLd; vACq = vTLLq;
vd = vACd; vq = vACq;
dphidt = omega0;
%RL = -Pref/(1.5*(vACd^2 + vACq^2)*(Pref^2 + Qref^2)); 
%RL = (Pref-1.5*(iFd^2+iFq^2)*Rf)/(1.5*(Vref^2)*(Pref^2 + Qref^2)); 
%LL = imag((vPVd + 1i*vPVq)/(iPVd + 1i*iPVq));%0.01;%-Qref/(1.5*(Vref^2)*(Pref^2 + Qref^2)); 
id_star = (PL*vd + QL*vq)/(vd^2 + vq^2);
iq_star = (PL*vq - QL*vd)/(vd^2 + vq^2);

Vs = 1;
ud = (2*(Rf*id_star - Lf*iq_star*dphidt))/Vs;%+vTLLd;
            uq = (2*(Rf*iq_star + Lf*id_star*dphidt))/Vs;%+vTLLq;
            
vPVd = Vs*ud/2; vPVq = Vs*uq/2;
diFddt = (vPVd - vACd - Rf*iFd)/Lf + omega0*iFq;
diFqdt = (vPVq - vACq - Rf*iFq)/Lf - omega0*iFd;

%newdt = (abs(vACd + 1i*vACq) - Vref);

iInLd = iFd;
iInLq = iFq; 
iInRd = -iLd; 
iInRq = -iLq;

            dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
            dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;

            %Equivalent R and L for Load
RL = PL/(PL^2 + QL^2);
LL = QL/(PL^2 + QL^2);

%Dynamics for Load
diLddt = (vTLRd - RL*iLd)/LL + omega0*iLq;
diLqdt = (vTLRq - RL*iLq)/LL - omega0*iLd;

            
            dx = 377*[dvTLLddt ; dvTLLqdt ; diTLMddt ; diTLMqdt;...
                diFddt;diFqdt;...
                diLddt;diLqdt;dvTLRddt ; dvTLRqdt];

end
I = sqrt(x(:,5).^2 + x(:,6).^2);
V = sqrt(x(:,1).^2 + x(:,2).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,1).*x(:,5) + x(:,2).*x(:,6);
Q = x(:,2).*x(:,5) - x(:,1).*x(:,6);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');
save('PVControlwithSwitches.mat')
end