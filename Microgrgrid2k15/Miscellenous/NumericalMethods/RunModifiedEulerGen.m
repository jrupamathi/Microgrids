function RunModifiedEulerGen
%stable for hmin = 1e-3
%Given machine parameters
Rs = 0.01524;
Ll = 0.01524;
Lmd = 2.81;
Lmq = 1.64;
Rfd = 0.004319;
Llfd = 0.531;
Rkd = 0.2343;
Llkd = 2.655;
Rkq1 = 0.03365;
Llkq1 = 0.2408;
H = 0.3222;
Rkq2 = 0.03365;


%Network reference frame stator terminal voltages
V_d = 1;
V_q = 0;
Pm = 0.8;%Input mechanical power
V_fd = 0.001;%Input field excitation
omega_b = 377;
omega_s = 1;

%needs h = 1e-4 
tspan = [0,2]; x0 = [zeros(7,1);1];
[t1,x1] = ode45(@RunDynamics,tspan,x0);

%Explicit method starts
t0 = tspan(1);tend = tspan(2);
x=[x0];t = t0; h=1e-3;
while t<=tend
    xnew = x(:,end) + h*RunDynamics(t,x(:,end));
    Fin = x(:,end) + (h/2)*(RunDynamics(t,x(:,end)) + RunDynamics(t,xnew));
    x = [x Fin];
    t = t+h
end
    
function dx = RunDynamics(t,x)
i_d=x(1); i_q = x(2); i_fd = x(3);
i_kd=x(4); i_kq1 = x(5); i_kq2 = x(6);
delta = x(7); omega = x(8);

dx = [ (omega_b*(Llfd*Llkd*V_q*cos(delta) - Llkd*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llkd*Lmd*V_q*cos(delta) + Llfd*Llkd*V_d*sin(delta) + Llfd*Lmd*V_d*sin(delta) + Llkd*Lmd*V_d*sin(delta) + Llkd*Lmd*Rfd*i_fd + Llfd*Lmd*Rkd*i_kd - Llfd*Llkd*Rs*i_d - Llfd*Lmd*Rs*i_d - Llkd*Lmd*Rs*i_d + Ll*Llfd*Llkd*i_q*omega + Ll*Llfd*Lmd*i_q*omega + Ll*Llkd*Lmd*i_q*omega + Llfd*Llkd*Lmq*i_kq1*omega + Llfd*Llkd*Lmq*i_kq2*omega + Llfd*Llkd*Lmq*i_q*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_q*omega + Llkd*Lmd*Lmq*i_q*omega))/(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd);
                                                                                                                                                                                                                                                                                 -(omega_b*(Llkq1*Rs*i_q - Lmq*Rkq2*i_kq2 - Lmq*Rkq1*i_kq1 + 2*Lmq*Rs*i_q + Llkq1*V_d*cos(delta) + 2*Lmq*V_d*cos(delta) - Llkq1*V_q*sin(delta) - 2*Lmq*V_q*sin(delta) + Ll*Llkq1*i_d*omega + 2*Ll*Lmq*i_d*omega + Llkq1*Lmd*i_d*omega + Llkq1*Lmd*i_fd*omega + Llkq1*Lmd*i_kd*omega + 2*Lmd*Lmq*i_d*omega + 2*Lmd*Lmq*i_fd*omega + 2*Lmd*Lmq*i_kd*omega))/(Ll*Llkq1 + 2*Ll*Lmq + Llkq1*Lmq);
                                                                                                                                                                                                                                                                                                 -(omega_b*(Llkd*Lmd*V_q*cos(delta) - Ll*Lmd*V_fd - Llkd*Lmd*V_fd - Ll*Llkd*V_fd + Llkd*Lmd*V_d*sin(delta) + Ll*Llkd*Rfd*i_fd + Ll*Lmd*Rfd*i_fd + Llkd*Lmd*Rfd*i_fd - Ll*Lmd*Rkd*i_kd - Llkd*Lmd*Rs*i_d + Ll*Llkd*Lmd*i_q*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_q*omega))/(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd);
                                                                                                                                                                                                                                                                                                                                -(omega_b*(Ll*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llfd*Lmd*V_d*sin(delta) - Ll*Lmd*Rfd*i_fd + Ll*Llfd*Rkd*i_kd + Ll*Lmd*Rkd*i_kd + Llfd*Lmd*Rkd*i_kd - Llfd*Lmd*Rs*i_d + Ll*Llfd*Lmd*i_q*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_q*omega))/(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd);
                                                                                                                                                                                                                                                                                                                                               (omega_b*(Llkq1*Lmq*V_d*cos(delta) - Llkq1*Lmq*V_q*sin(delta) - Ll*Llkq1*Rkq1*i_kq1 - Ll*Lmq*Rkq1*i_kq1 + Ll*Lmq*Rkq2*i_kq2 - Llkq1*Lmq*Rkq1*i_kq1 + Llkq1*Lmq*Rs*i_q + Ll*Llkq1*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_fd*omega + Llkq1*Lmd*Lmq*i_kd*omega))/(Ll*Llkq1^2 + Llkq1^2*Lmq + 2*Ll*Llkq1*Lmq);
                                                                                                                                                                                                                                                                                                                                               (omega_b*(Llkq1*Lmq*V_d*cos(delta) - Llkq1*Lmq*V_q*sin(delta) - Ll*Llkq1*Rkq2*i_kq2 + Ll*Lmq*Rkq1*i_kq1 - Ll*Lmq*Rkq2*i_kq2 - Llkq1*Lmq*Rkq2*i_kq2 + Llkq1*Lmq*Rs*i_q + Ll*Llkq1*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_fd*omega + Llkq1*Lmd*Lmq*i_kd*omega))/(Ll*Llkq1^2 + Llkq1^2*Lmq + 2*Ll*Llkq1*Lmq);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  omega_b*(omega - omega_s);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           (i_q*(V_d*cos(delta) - V_q*sin(delta)) - i_d*(V_q*cos(delta) + V_d*sin(delta)) + Pm/omega)/(2*H)];

end
t = linspace(t0,tend,size(x,2));
plot(t,x(2,:),'b--','linewidth',2);hold on;
plot(t1,x1(:,2),'g-.')
end