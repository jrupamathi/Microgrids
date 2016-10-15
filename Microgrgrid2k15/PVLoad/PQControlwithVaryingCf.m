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
x0= [1.1166
   -0.2712
   -2.7282
   -1.1372
    0.1362
   -0.9958
   -2.7249
   -1.1273
    2.8294
    0.0425
    1
    0
    1
    0];
    tspan = [0 1];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);

function dx = PVDynamics(t,x)
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
iLd = x(11);
iLq = x(12);
vTLRd = x(13);
vTLRq = x(14);

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
I = ConvMat\[PL;QL];%[PL+(iFd^2+iFq^2)*Rf;QL+(iFd^2+iFq^2)*Lf];
iRefd = I(1);
iRefq = I(2);

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
                ...%diPVddt; diPVqdt;...
                dvPVddt;dvPVqdt; diFddt;diFqdt;...
                dCfdt;CfIndt;diLddt;diLqdt;dvTLRddt ; dvTLRqdt];

end
I = sqrt(x(:,7).^2 + x(:,8).^2);
V = sqrt(x(:,5).^2 + x(:,6).^2);
figure(1)
plot(t,I,'b',t,V,'r');
xlabel('Time(in seconds)');
ylabel('in p.u.');
title('PV voltage and current magnitudes');
legend('PV current', 'PV Terminal voltage');

figure(2);
P = x(:,5).*x(:,7) + x(:,6).*x(:,8);
Q = x(:,6).*x(:,7) - x(:,5).*x(:,8);
plot(t,P,t,Q)
xlabel('Time(in seconds)')
ylabel('in p.u.')
title('PV real and reactive power output');
legend('PV real power', 'PV reactive power');
save('PQControlwithVaryingCf.mat')
end