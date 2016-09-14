syms I_d I_q V_d V_q theta psi PL dPLdt real
syms Rs Ll Lmd Lmq Rfd Llfd Rkd delta omega i_fd real
syms Llkd Rkq1 Llkq1 H F i_kd i_kq1 i_kq2 real
syms Pm V_fd omega_b omega_s Rkq2 Rkq1 real
syms dV_ddt dV_qdt PL dPL omega_0 real
% Rs = 0.01524;
% Ll = 0.01524;
% Lmd = 2.81;
% Lmq = 1.64;
% Rfd = 0.004319;
% Llfd = 0.531;
% Rkd = 0.2343;
% Llkd = 2.655;
% Rkq1 = 0.03365;
% Llkq1 = 0.2408;
% H = 0.3222;

dInetdt = [ (omega_b^2*sin(delta)*(Llfd*Llkd*V_q*cos(delta) - Llkd*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llkd*Lmd*V_q*cos(delta) + Llfd*Llkd*V_d*sin(delta) + Llfd*Lmd*V_d*sin(delta) + Llkd*Lmd*V_d*sin(delta) - Llfd*Llkd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llfd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llkd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) + Llkd*Lmd*Rfd*i_fd + Llfd*Lmd*Rkd*i_kd - Ll*Llfd*Llkd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llfd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llkd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Llkd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llkd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) + Llfd*Llkd*Lmq*i_kq1*omega + Llfd*Llkd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)) + (omega_b*cos(delta)*(I_q*cos(delta) + I_d*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) - (omega_b*sin(delta)*(I_d*cos(delta) - I_q*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) + (omega_b^2*cos(delta)*(Llkq1*V_d*cos(delta) - 2*Lmq*Rs*(I_d*cos(delta) - I_q*sin(delta)) - Lmq*Rkq1*i_kq1 - Lmq*Rkq2*i_kq2 - Llkq1*Rs*(I_d*cos(delta) - I_q*sin(delta)) + 2*Lmq*V_d*cos(delta) - Llkq1*V_q*sin(delta) - 2*Lmq*V_q*sin(delta) + Ll*Llkq1*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Ll*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Lmd*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*i_fd*omega + Llkq1*Lmd*i_kd*omega + 2*Lmd*Lmq*i_fd*omega + 2*Lmd*Lmq*i_kd*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llkq1 + 2*Ll*Lmq + Llkq1*Lmq))
 (omega_b^2*cos(delta)*(Llfd*Llkd*V_q*cos(delta) - Llkd*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llkd*Lmd*V_q*cos(delta) + Llfd*Llkd*V_d*sin(delta) + Llfd*Lmd*V_d*sin(delta) + Llkd*Lmd*V_d*sin(delta) - Llfd*Llkd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llfd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llkd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) + Llkd*Lmd*Rfd*i_fd + Llfd*Lmd*Rkd*i_kd - Ll*Llfd*Llkd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llfd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llkd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Llkd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llkd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) + Llfd*Llkd*Lmq*i_kq1*omega + Llfd*Llkd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)) - (omega_b^2*sin(delta)*(Llkq1*V_d*cos(delta) - 2*Lmq*Rs*(I_d*cos(delta) - I_q*sin(delta)) - Lmq*Rkq1*i_kq1 - Lmq*Rkq2*i_kq2 - Llkq1*Rs*(I_d*cos(delta) - I_q*sin(delta)) + 2*Lmq*V_d*cos(delta) - Llkq1*V_q*sin(delta) - 2*Lmq*V_q*sin(delta) + Ll*Llkq1*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Ll*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Lmd*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*i_fd*omega + Llkq1*Lmd*i_kd*omega + 2*Lmd*Lmq*i_fd*omega + 2*Lmd*Lmq*i_kd*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llkq1 + 2*Ll*Lmq + Llkq1*Lmq)) - (omega_b*cos(delta)*(I_d*cos(delta) - I_q*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) - (omega_b*sin(delta)*(I_q*cos(delta) + I_d*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2)];

dI_ddt = dInetdt(1);
dI_qdt = dInetdt(2);
% Vm = sqrt(V_d^2 + V_q^2);
% theta = atan(V_q/V_d);
% Im = sqrt(I_d^2 + I_q^2);
% psi = atan(I_q/I_d);

% dVm = (V_d*dV_ddt + V_q*dV_qdt)/Vm;
% dtheta = (V_d*dV_qdt - V_q*dV_ddt)/Vm^2;
% syms dVm dtheta
% 
% dIm = (I_d*dI_ddt + I_q*dI_qdt)/Im;
% dpsi = (I_d*dI_qdt - I_q*dI_ddt)/Im^2;
%%
% Vm = sqrt(V_d^2 + V_q^2);
% syms dI_ddt dI_qdt real
% syms h V_dk1 V_dk V_qk1 V_qk PL_k1 PL_k omega_k1 omega_k real 
% dV_ddt = (V_dk1-V_d)/h;
% dV_qdt = (V_qk1-V_q)/h;
% dPL = (PL_k1 - PL)/h;
% dpsidt = (V_d*dV_qdt - V_q*dV_ddt)/Vm^2;

f(1) = PL - (V_d*I_d + V_q*I_q);
f(2) = dPL - (dV_ddt*I_d + V_d*dI_ddt + dV_qdt*I_q + V_q*dI_qdt);
% f(3) = (-F*(omega_k1- omega_k-dpsidt) + (Pm - PL))/(2*H);
%%
syms Vd(t) Vq(t) 
eqn1 = PL == (V_d*I_d + V_q*I_q);
eqn2 = dPL == (dV_ddt*I_d + V_d*dI_ddt + dV_qdt*I_q + V_q*dI_qdt);
eqn3 = diff(V_d) == dV_ddt;
eqn4 = diff(V_q) == dV_qdt;
