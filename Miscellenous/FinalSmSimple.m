function FinalSmSimple
%In rotating reference frame (SImulink model)
%Given machine parameters
rs = 0.01524;
Ll = 0.08;
Lmd = 2.81;
Laf = Lmd;
Lad = Lmd;
Ldf = Lmd;
Lmq = 1.64;
Laq = Lmq;
rf = 0.004319;
Llfd = 0.531;
rr = 0.2343;
Llkd = 2.655;
rq = 0.03365;
Llkq1 = 0.2408;
H = 0.3222;
F = 0.01322;

%Calculated machine parameters
Ld = Ll + Lmd;
Lq = Ll + Lmq;
LF = Llfd + Lmd;
LD = Llkd + Lmd;
LQ = Llkq1 + Lmq;
Lkq2 = Llkq1 + Lmq;
Rkq2 = 0.03365;
rr = 0.2343;%(Rkd+Rkq1)/2;
Rkq1 = Rkq2;
% Rkq2 = Rkd;

%Network reference frame stator terminal voltages
vds = 1;
vqs = 0;
RL = 1; LL = 1;
Tm = 0.8;%Input mechanical power
vf = 0.001;%Input field excitation
wb = 377;
omega0 = 1;

t0 = [0;5];
x0 = zeros(7,1);
x0(7) = 1;
tic
[t,x] = ode45(@SimulateExactSM,t0,x0);
toc
function dx = SimulateExactSM(t,x)
%Rotor reference frame quantities
Id = x(1);
Iq = x(2);
iD  = x(3);
iQ = x(4);
iF = x(5);
delta = x(6);
omega = x(7);
            
%Transformation matrix (from network to machine)
t
%Mechanical state spance
wb=377; omega0 = 1;
dIddt=-wb*(iF*((rf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Laf*omega*cos(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Lad*omega*cos(delta))/(Laq^2 - LQ*Lq)) - vds*(LQ/(2*(Laq^2 - LQ*Lq)) + cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Iq*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + iQ*((Laq*rq*cos(delta))/(Laq^2 - LQ*Lq) - (Laq*omega*sin(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*(rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - vqs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
dIqdt=wb*(iF*((rf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Laf*omega*sin(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Lad*omega*sin(delta))/(Laq^2 - LQ*Lq)) - vqs*(cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Id*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - iQ*((Laq*rq*sin(delta))/(Laq^2 - LQ*Lq) + (Laq*omega*cos(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*(rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + vds*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diDdt=wb*(Iq*((rs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*((rs*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vqs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vds*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Laf^2 - LF*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Laq*iQ*omega*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diFdt=-wb*(Id*((rs*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*((rs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vqs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vds*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iF*rf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Laq*iQ*omega*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
diQdt=-wb*(Id*((Laq*rs*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*Ld*omega*sin(delta))/(Laq^2 - LQ*Lq)) + Iq*((Laq*rs*sin(delta))/(Laq^2 - LQ*Lq) - (Laq*Ld*omega*cos(delta))/(Laq^2 - LQ*Lq)) + (Laq*vds*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*vqs*sin(delta))/(Laq^2 - LQ*Lq) - (Lq*iQ*rq)/(Laq^2 - LQ*Lq) + (Lad*Laq*iD*omega)/(Laq^2 - LQ*Lq) + (Laf*Laq*iF*omega)/(Laq^2 - LQ*Lq));
ddeltadt=wb*(omega - 1);
domegadt=-(Id*vds - Tm +F*omega + Iq*vqs)/(2*H);

dx = [dIddt ; dIqdt ; diDdt ; diQdt; diFdt; ddeltadt; domegadt];
end

save('SMDataRotor1.mat')
end