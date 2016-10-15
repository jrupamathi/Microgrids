function SimulateOneAxis
%In rotating reference frame (SImulink model)
%Given machine parameters
Rs = 0.01524;
Ll = 0.08;
Lmd = 2.81;
Lmq = 1.64;
Rfd = 0.004319;
Llfd = 0.531;
Rkd = 0.2343;
Llkd = 2.655;
Rkq1 = 0.03365;
Llkq1 = 0.2408;
H = 0.3222;
F = 0.01322;

%Calculated machine parameters
Ld = Ll + Lmd;
Lq = Ll + Lmq;
Lfd = Llfd + Lmd;
Lkd = Llkd + Lmd;
Lkq1 = Llkq1 + Lmq;
Lkq2 = Llkq1 + Lmq;
Rkq2 = Rkq1;%0.03365;
% Rkd = 0.2343;%(Rkd+Rkq1)/2;
% Rkq1 = Rkq2;
% Rkq2 = Rkd;

%Network reference frame stator terminal voltages
% V_d = 1;
% V_q = 0;
RL = 0.5072; LL = 1;
% K11 = 1;%5.81;
% K12 = 10;%35.517;
% K26 = 1;% -9.8039;

K11 = 5.81;
K12 = 35.517;
K26 =  -9.8039;

delta_ref = 0.6192;
iF_ref = -1.484;
Tm_ref = 1;
vf_ref = 6.4e-4;

% Pm = 0.8;%Input mechanical power
% efd = 0.001;%Input field excitation
wb = 377;
omega0 = 1;

xd = Ld;
xdprime = Ld - Lmd^2/Lfd;
Td0 = Lkd/Rkd * (1-Lmd^2/(Lkd*Lfd));

t0 = [0;1];
x0 = zeros(3,1);
x0(3) = 1;
tic
[t,x] = ode45(@SimulateExactSM,t0,x0);
toc
function dx = SimulateExactSM(t,x)
%Rotor reference frame quantities
eqprime = x(1);
delta = x(2);
omega = x(3);
t
Pm = Tm_ref - K11*(delta - delta_ref) - K12*(omega - omega0);

% efd = vf_ref - K26*(eqprime - 1.1*iF_ref);% - K25_G23*(iRd_G23 - iRd_G23_ref) - K27_G23*(iRq_G23 - iRq_G23_ref) - K23_G23*(iSd_G23 - iSd_G23_ref) - K24_G23*(iSq_G23 - iSq_G23_ref) - K22_G23*(omega_G23 - omega_G23_ref);
% iF = efd - eqprime/RF;
efd = (vf_ref - K26*(-eqprime/Rkd-1.1*iF_ref))/(1+K26/Rkd);
r = Rs;
I = 1i*eqprime/(r+ 1i*xdprime+RL);
id = real(I); iq = imag(I);
Te = eqprime*iq;
deqprimedt = (-eqprime-(xd - xdprime)*id+efd)/Td0; 
%Mechanical state spance
ddeltadt = wb*(omega-omega0);
domegadt = (Pm -Te)/(2*H);
dx = [deqprimedt; ddeltadt; domegadt];
end

save('SMDataRotor1.mat')
end