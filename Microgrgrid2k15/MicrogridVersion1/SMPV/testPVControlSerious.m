function testPVControl
omega0=1;
CTL = 0.01;
RTL = 1e-2;
LTL = 0.1;
x0= [1;0;1;0;1;0];
tspan = [0 0.5];
[t,x] = ode45(@(t,x)PVDynamics(t,x),tspan,x0);
toc

function [dx] = PVDynamics(t,x,vTLRd)
iTLMd = x(1);
iTLMq = x(2);
vTLRd = x(3);
vTLRq = x(4);
id = x(5);
iq = x(6);

t
dphidt = omega0;
vTLLd = 1; vTLLq = 0;
iInRd = -id; iInRq = -iq;
Vs = 1; id_star = 1; iq_star = 0;
R = 0.002; L=0.01;
% iInLd = iRd; iInLq = iRq; 
%             dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
%             dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
            diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
            diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);
            dvTLRddt = (iInRd + iTLMd)/CTL + dphidt*vTLRq;
            dvTLRqdt = (iInRq + iTLMq)/CTL - dphidt*vTLRd;

            ud = -(2*(R*id_star - L*iq_star*dphidt))/Vs;
            uq = -(2*(R*iq_star + L*id_star*dphidt))/Vs;
            
            %Transmission Line Dynamics
            diddt = dphidt*iq - (R*id + (Vs*ud)/2)/L;
            diqdt = -dphidt*id - (R*iq + (Vs*uq)/2)/L;
            
            dx = 377*[...%dvTLLddt ; dvTLLqdt ;...
                diTLMddt ; diTLMqdt;dvTLRddt ; dvTLRqdt;...
                diddt;diqdt]; 

end
save('dataPV.mat')
plot(t,x(:,5),t,x(:,6));
end