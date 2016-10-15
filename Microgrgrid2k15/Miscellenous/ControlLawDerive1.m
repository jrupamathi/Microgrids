syms i_d i_q I_d I_q V_d V_q theta psi PL dPLdt real
syms Rs Ll Lmd Lmq Rfd Llfd Rkd delta omega i_fd real
syms Llkd Rkq1 Llkq1 H F i_kd i_kq1 i_kq2 real
syms Pm V_fd omega_b omega_s Rkq2 Rkq1 real
syms dV_ddt dV_qdt PL dPL omega_0 real


dInetdt = [ (omega_b^2*sin(delta)*(Llfd*Llkd*V_q*cos(delta) - Llkd*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llkd*Lmd*V_q*cos(delta) + Llfd*Llkd*V_d*sin(delta) + Llfd*Lmd*V_d*sin(delta) + Llkd*Lmd*V_d*sin(delta) - Llfd*Llkd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llfd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llkd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) + Llkd*Lmd*Rfd*i_fd + Llfd*Lmd*Rkd*i_kd - Ll*Llfd*Llkd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llfd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llkd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Llkd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llkd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) + Llfd*Llkd*Lmq*i_kq1*omega + Llfd*Llkd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)) + (omega_b*cos(delta)*(I_q*cos(delta) + I_d*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) - (omega_b*sin(delta)*(I_d*cos(delta) - I_q*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) + (omega_b^2*cos(delta)*(Llkq1*V_d*cos(delta) - 2*Lmq*Rs*(I_d*cos(delta) - I_q*sin(delta)) - Lmq*Rkq1*i_kq1 - Lmq*Rkq2*i_kq2 - Llkq1*Rs*(I_d*cos(delta) - I_q*sin(delta)) + 2*Lmq*V_d*cos(delta) - Llkq1*V_q*sin(delta) - 2*Lmq*V_q*sin(delta) + Ll*Llkq1*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Ll*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Lmd*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*i_fd*omega + Llkq1*Lmd*i_kd*omega + 2*Lmd*Lmq*i_fd*omega + 2*Lmd*Lmq*i_kd*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llkq1 + 2*Ll*Lmq + Llkq1*Lmq))
 (omega_b^2*cos(delta)*(Llfd*Llkd*V_q*cos(delta) - Llkd*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llkd*Lmd*V_q*cos(delta) + Llfd*Llkd*V_d*sin(delta) + Llfd*Lmd*V_d*sin(delta) + Llkd*Lmd*V_d*sin(delta) - Llfd*Llkd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llfd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) - Llkd*Lmd*Rs*(I_q*cos(delta) + I_d*sin(delta)) + Llkd*Lmd*Rfd*i_fd + Llfd*Lmd*Rkd*i_kd - Ll*Llfd*Llkd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llfd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Ll*Llkd*Lmd*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Llkd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llfd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) - Llkd*Lmd*Lmq*omega*(I_d*cos(delta) - I_q*sin(delta)) + Llfd*Llkd*Lmq*i_kq1*omega + Llfd*Llkd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)) - (omega_b^2*sin(delta)*(Llkq1*V_d*cos(delta) - 2*Lmq*Rs*(I_d*cos(delta) - I_q*sin(delta)) - Lmq*Rkq1*i_kq1 - Lmq*Rkq2*i_kq2 - Llkq1*Rs*(I_d*cos(delta) - I_q*sin(delta)) + 2*Lmq*V_d*cos(delta) - Llkq1*V_q*sin(delta) - 2*Lmq*V_q*sin(delta) + Ll*Llkq1*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Ll*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*omega*(I_q*cos(delta) + I_d*sin(delta)) + 2*Lmd*Lmq*omega*(I_q*cos(delta) + I_d*sin(delta)) + Llkq1*Lmd*i_fd*omega + Llkq1*Lmd*i_kd*omega + 2*Lmd*Lmq*i_fd*omega + 2*Lmd*Lmq*i_kd*omega))/((cos(delta)^2 + sin(delta)^2)*(Ll*Llkq1 + 2*Ll*Lmq + Llkq1*Lmq)) - (omega_b*cos(delta)*(I_d*cos(delta) - I_q*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2) - (omega_b*sin(delta)*(I_q*cos(delta) + I_d*sin(delta))*(omega - omega_s))/(cos(delta)^2 + sin(delta)^2)];
domegadt = (i_q*(V_d*cos(delta) - V_q*sin(delta)) - i_d*(V_q*cos(delta) + V_d*sin(delta)) + Pm/omega)/(2*H);
ditempdt = [
 -(omega_b*(Llkd*Lmd*V_q*cos(delta) - Ll*Lmd*V_fd - Llkd*Lmd*V_fd - Ll*Llkd*V_fd + Llkd*Lmd*V_d*sin(delta) + Ll*Llkd*Rfd*i_fd + Ll*Lmd*Rfd*i_fd + Llkd*Lmd*Rfd*i_fd - Ll*Lmd*Rkd*i_kd - Llkd*Lmd*Rs*i_d + Ll*Llkd*Lmd*i_q*omega + Llkd*Lmd*Lmq*i_kq1*omega + Llkd*Lmd*Lmq*i_kq2*omega + Llkd*Lmd*Lmq*i_q*omega))/(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)
                                -(omega_b*(Ll*Lmd*V_fd + Llfd*Lmd*V_q*cos(delta) + Llfd*Lmd*V_d*sin(delta) - Ll*Lmd*Rfd*i_fd + Ll*Llfd*Rkd*i_kd + Ll*Lmd*Rkd*i_kd + Llfd*Lmd*Rkd*i_kd - Llfd*Lmd*Rs*i_d + Ll*Llfd*Lmd*i_q*omega + Llfd*Lmd*Lmq*i_kq1*omega + Llfd*Lmd*Lmq*i_kq2*omega + Llfd*Lmd*Lmq*i_q*omega))/(Ll*Llfd*Llkd + Ll*Llfd*Lmd + Ll*Llkd*Lmd + Llfd*Llkd*Lmd)
                                               (omega_b*(Llkq1*Lmq*V_d*cos(delta) - Llkq1*Lmq*V_q*sin(delta) - Ll*Llkq1*Rkq1*i_kq1 - Ll*Lmq*Rkq1*i_kq1 + Ll*Lmq*Rkq2*i_kq2 - Llkq1*Lmq*Rkq1*i_kq1 + Llkq1*Lmq*Rs*i_q + Ll*Llkq1*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_fd*omega + Llkq1*Lmd*Lmq*i_kd*omega))/(Ll*Llkq1^2 + Llkq1^2*Lmq + 2*Ll*Llkq1*Lmq)
                                               (omega_b*(Llkq1*Lmq*V_d*cos(delta) - Llkq1*Lmq*V_q*sin(delta) - Ll*Llkq1*Rkq2*i_kq2 + Ll*Lmq*Rkq1*i_kq1 - Ll*Lmq*Rkq2*i_kq2 - Llkq1*Lmq*Rkq2*i_kq2 + Llkq1*Lmq*Rs*i_q + Ll*Llkq1*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_d*omega + Llkq1*Lmd*Lmq*i_fd*omega + Llkq1*Lmd*Lmq*i_kd*omega))/(Ll*Llkq1^2 + Llkq1^2*Lmq + 2*Ll*Llkq1*Lmq)
 ];
Tn2m = [sin(delta) cos(delta);
    -cos(delta)  sin(delta)];

imach = Tn2m*[I_d;I_q];
didt =subs(ditempdt,[i_d;i_q],[imach(1);imach(2)]);
%%
syms h V_dk1 V_dk V_qk1 V_qk PL_k1 PL_k omega_k1 omega_k real 
syms deltak1 omegak1 I_dk1 I_qk1 i_fdk1 i_kdk1 i_kq1k1 i_kq2k1 

Vm = sqrt(V_d^2 + V_q^2);
dpsidt = (V_d*dV_qdt - V_q*dV_ddt)/Vm^2;
dI_ddt = dInetdt(1); dI_qdt = dInetdt(2);
f(1) = I_dk1 - (I_d + h*dInetdt(1));
f(2) = I_qk1 - (I_q + h*dInetdt(2));
f(3) = i_fdk1 - (i_fd + h*didt(1));
f(4) = i_kdk1 - (i_kd + h*didt(2));
f(5) = i_kq1k1 - (i_kq1 + h*didt(3));
f(6) = i_kq2k1 - (i_kq2 + h*didt(4));
f(7) = deltak1 - (delta + h*(omega - dpsidt));
f(8) =  omegak1 - (omega + h*((-F*(omega_k1- omega_k-dpsidt) + (Pm - PL))/(2*H)));
% syms dI_ddt dI_qdt real
dV_ddt = (V_dk1-V_d)/h;
dV_qdt = (V_qk1-V_q)/h;
dPL = (PL_k1 - PL)/h;

f(9) = PL - (V_d*I_d + V_q*I_q);
f(10) = dPL - (dV_ddt*I_d + V_d*dI_ddt + dV_qdt*I_q + V_q*dI_qdt);
