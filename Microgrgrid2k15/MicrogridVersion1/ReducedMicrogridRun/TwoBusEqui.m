function TwoBusEqui
% generator parameters

set(0,'defaultlinelinewidth',1.5)
addpath('../Parameters')

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','RF_G23','H_G23','B_G23','Rkq_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','RF_G22','H_G22','B_G22','Rkq_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

% delta_G22_ref = 0.1*delta_G22_ref;
% iF_G22_ref = 3*iF_G22_ref;

tauL_G22_ref = 0.47423;
vR_G22_ref = 0.003126;
delta_G22_ref = 0.2863;
iF_G22_ref = -1.518;
K1_G22 = 2.2092; K2_G22 = 24.8318;
K3_G22 = -5.7645;
% K1_G22 = 0.8808; K2_G22 = 12.8569; K3_G22 = -0.9281;

%Load Parameters
RL_L21 = 4.9098; LL_L21 = 2.8962;
RL_L22 = 0.5587; LL_L22 = 0.4054;

%Line Parameters
RTL_TL_21_22 = 0.0287; LTL_TL_21_22 = 0.1104;
CTL_TL_21_22 = 0.01;

%PV Parameters
iPV = 0.9773;
Rf = 0.0069;
Lf = 0.9425;
% Rdc = 10*Rf;
Cdc = 0.0921;
Cf = Cdc;
RL_PV21 = Rf; 
LL_PV21 = Lf;

PPV_ref = 0.875; QPV_ref = 0.01; 
V21_ref = 1.008;
alpha_eq = PPV_ref/(V21_ref^2);

omega0 = 1; wb = 377; dphidt = 1;
%Control gains
Kpvt = 1e0; Kivt = 0.1e-3;
Kpv = 1e0; Kiv = 0.1e0;
Kpp = 1e3; Kip = 0.1e2;
Kpc = 0e0;Kic = 1e0;

tic
faulton = 2; faultoff = 2;

x0 = [0.00145828
    -1.14761
  0.00320423
   0.0189337
    -1.68292
  -0.0471212
    0.999797
    0.156849
  -0.0991625
  10*0.15
  10*(-0.099)
      1.0618
   -0.152938
 0.000278978
     1.15964
     1.18911
   -0.184807
    0.157954
     1.07048
    0.941944
      1.3887
     88008.6
   0.0509373
  -0.0119794
   -0.130376
  -0.0446055
    -1540.88
    -6365.41
    -3.91106
     1.68318];
[t,x]=ode45(@MilosSmTlWorking,[0,0.03],x0);
time  = toc

function dx = MilosSmTlWorking(t,x)  
iSd_G22 = x(1);
iSq_G22 = x(2);
iRd_G22 = x(3);
iRq_G22 = x(4);
iF_G22 = x(5);
delta_G22 = x(6);
omega_G22 = x(7);
iLd_L21 = x(8);
iLq_L21 = x(9);
iLd_L22 = x(10);
iLq_L22 = x(11);
vTLLd_TL_21_22 = x(12);
vTLLq_TL_21_22 = x(13);
if(t<faulton || t>faultoff)
    iTLMd_TL_21_22 = x(14);
    iTLMq_TL_21_22 = x(15);
else
    iTLMd_TL_21_22 = 0;
    iTLMq_TL_21_22 = 0;
end
vTLRd_TL_21_22 = x(16);
vTLRq_TL_21_22 = x(17);
iLd_PV21 = x(18);
iLq_PV21 = x(19);

iFd = x(20);
iFq = x(21);
vDC = x(22);
vOutd = x(23);
vOutq = x(24);
gammad = x(25);
gammaq = x(26);
VdiffInt = x(27);
delP = x(28);
phid =x(29);
phiq =x(30);

t
% Vt23 = sqrt(vTLRd_TL_21_22^2 + vTLRq_TL_21_22^2);

tauL_G22 = tauL_G22_ref - K1_G22*(delta_G22 - delta_G22_ref) - K2_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K3_G22*(iF_G22 - iF_G22_ref);
diSd_G22dt = 377*vTLRd_TL_21_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_21_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_21_22*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_21_22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_21_22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_21_22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*(omega_G22-omega0) - tauL_G22 + iSd_G22*vTLRd_TL_21_22 + iSq_G22*vTLRq_TL_21_22)/(2*H_G22);
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLLd_TL_21_22 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLLq_TL_21_22 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
diLd_L22dt = 377*dphidt*iLq_L22 + (377*(vTLRd_TL_21_22 - RL_L22*iLd_L22))/LL_L22;
diLq_L22dt = (377*(vTLRq_TL_21_22 - RL_L22*iLq_L22))/LL_L22 - 377*dphidt*iLd_L22;
dvTLLd_TL_21_22dt = 377*dphidt*vTLLq_TL_21_22 - (377*(iLd_L21 - iLd_PV21 + iTLMd_TL_21_22))/CTL_TL_21_22;
dvTLLq_TL_21_22dt = - 377*dphidt*vTLLd_TL_21_22 - (377*(iLq_L21 - iLq_PV21 + iTLMq_TL_21_22))/CTL_TL_21_22;
if (t<faulton||t>faultoff)
    diTLMd_TL_21_22dt = 377*dphidt*iTLMq_TL_21_22 - (377*(vTLRd_TL_21_22 - vTLLd_TL_21_22 + RTL_TL_21_22*iTLMd_TL_21_22))/LTL_TL_21_22;
    diTLMq_TL_21_22dt = - 377*dphidt*iTLMd_TL_21_22 - (377*(vTLRq_TL_21_22 - vTLLq_TL_21_22 + RTL_TL_21_22*iTLMq_TL_21_22))/LTL_TL_21_22;
else
    diTLMd_TL_21_22dt = 0;
    diTLMq_TL_21_22dt = 0;
end
dvTLRd_TL_21_22dt = 377*dphidt*vTLRq_TL_21_22 + (377*(iSd_G22 - iLd_L22 + iTLMd_TL_21_22))/CTL_TL_21_22;
dvTLRq_TL_21_22dt = (377*(iSq_G22 - iLq_L22 + iTLMq_TL_21_22))/CTL_TL_21_22 - 377*dphidt*vTLRd_TL_21_22;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLLd_TL_21_22 - RL_PV21*iLd_PV21))/LL_PV21;
diLq_PV21dt = (377*(vTLLq_TL_21_22 - RL_PV21*iLq_PV21))/LL_PV21 - 377*dphidt*iLd_PV21;

%PV internal dynamics
iOutd = iLd_PV21;
iOutq = iLq_PV21;
vBd = vTLLd_TL_21_22;
vBq = vTLLq_TL_21_22;
P = vBd*iOutd + vBq*iOutq;
Q = vBq*iOutd - vBd*iOutq;

%PQ control mode
if (t<faulton||t>faultoff)
    alpha = -Kpp*(P - PPV_ref) + atan(vBq/vBd) + alpha_eq - Kip*delP;
    Vc = V21_ref*(1+ Kpvt*(Q-QPV_ref) + Kivt*VdiffInt); 
    dVdiffdt = (Q - QPV_ref);
    ddelPdt = P - PPV_ref;        
%Vf mode    
else
    Vt = sqrt(vBd^2 + vBq^2);
    f = 1 +1/0.3*(P-PPV_ref);
    alpha = -Kpp*(f - 1)+ atan(vBq/vBd) + alpha_eq - Kip*delP ;
    Vc = V21_ref*(1+ Kpvt*(Vt-V21_ref) + 1*Kivt*VdiffInt);
    dVdiffdt = (Vt - V21_ref);
    ddelPdt = f - 1;        
end

%Voltage Reference points
vOutd_ref = Vc*cos(alpha);
vOutq_ref = Vc*sin(alpha);
%Outer Voltage control
iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
        
%Inner current control
ud = (Rf*iFd_ref + 1*vOutd - omega0*Lf*iFq)/vDC;
uq = (Rf*iFq_ref + 1*vOutq + omega0*Lf*iFd)/vDC;
        
diFddt = -(Rf/Lf + 1*Kpc)*(iFd - iFd_ref) -Kic*phid;
diFqdt = -(Rf/Lf+ 1*Kpc)*(iFq - iFq_ref) -Kic*phiq;
% diFddt = -Rf*iFd/Lf + (vDC*ud - vOutd)/Lf + omega0*iFq;
% diFqdt = -Rf*iFq/Lf + (vDC*uq - vOutq)/Lf - omega0*iFd;
dvDCdt = (iPV - (iFd*ud + iFq*uq))/Cdc;% - vDCOut/(10*Rf);
        
dvOutddt = -Kpv*Cf*(vOutd-vOutd_ref)-Kiv*Cf*gammad;%(iFd - iOutd)/CTL + omega0*iFq;% - vTd/(1000*Rf);
dvOutqdt = -Kpv*Cf*(vOutq-vOutq_ref)-Kiv*Cf*gammaq;%-(-iFq + iLq)/CTL - omega0*iFd;% - vTq/(1000*Rf);

dgammaddt = vOutd-vOutd_ref;
dgammaqdt = vOutq-vOutq_ref;

dphiddt = iFd - iFd_ref;
dphiqdt = iFq - iFq_ref;

dx = [diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diLd_L21dt
diLq_L21dt
diLd_L22dt
diLq_L22dt
dvTLLd_TL_21_22dt
dvTLLq_TL_21_22dt
diTLMd_TL_21_22dt
diTLMq_TL_21_22dt
dvTLRd_TL_21_22dt
dvTLRq_TL_21_22dt
diLd_PV21dt
diLq_PV21dt
377*[diFddt;
diFqdt;
dvDCdt;
dvOutddt;
dvOutqdt;dgammaddt; dgammaqdt;...
dVdiffdt;ddelPdt; dphiddt; dphiqdt];
];    
end

iSd_G22 = x(:,1);
iSq_G22 = x(:,2);
iRd_G22 = x(:,3);
iRq_G22 = x(:,4);
iF_G22 = x(:,5);
delta_G22 = x(:,6);
omega_G22 = x(:,7);
iLd_L21 = x(:,8);
iLq_L21 = x(:,9);
iLd_L22 = x(:,10);
iLq_L22 = x(:,11);
vTLLd_TL_21_22 = x(:,12);
vTLLq_TL_21_22 = x(:,13);
iTLMd_TL_21_22 = x(:,14);
iTLMq_TL_21_22 = x(:,15);
vTLRd_TL_21_22 = x(:,16);
vTLRq_TL_21_22 = x(:,17);
iLd_PV21 = x(:,18);
iLq_PV21 = x(:,19);

iFd = x(:,20);
iFq = x(:,21);
vDC = x(:,22);
vOutd = x(:,23);
vOutq = x(:,24);

figure(1);
iS22 = sqrt(iSd_G22.^2 + iSq_G22.^2);
iPV = sqrt(iLd_PV21.^2 + iLq_PV21.^2);

plot(t,iS22,'b',t,iPV,'r');
title('Electrical quantites of G22 (Disconnect from the utility)');
legend('Stator current magnitude of G23','Current magnitude of PV');
xlabel('Time in seconds');
ylabel('Current Magnitude (in p.u)');

figure(2);
plot(t,delta_G22,'b',t,omega_G22,'r');
title('Mechanical quantites of G22 (Disconnect from the utility)');
legend('Rotor relative angle of G22','Angular velocity of G22');
xlabel('Time in seconds');
ylabel('in p.u');

V21 = (vTLLd_TL_21_22.^2 + vTLLq_TL_21_22.^2).^0.5;
V22 = (vTLRd_TL_21_22.^2 + vTLRq_TL_21_22.^2).^0.5;

phi21 = atan(vTLLq_TL_21_22./vTLLd_TL_21_22)*180/pi;
phi22 = atan(vTLRq_TL_21_22./vTLRd_TL_21_22)*180/pi;

% Vbefore = [V21(100) V22(100)]
% 
% Vshoot = [max(abs(V21)) max(abs(V22))]

Vafter = [V21(end) V22(end)]

figure(3);
subplot(2,1,1)
plot(t,V22,'g',t,V21,'r');
title('Voltages at all the buses(Disconnect from the utility)');
legend('V22','V21');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,phi22,'g',t,phi21,'r');
title('Voltage angles at all the buses');
legend('phi22','phi21');
xlabel('Time in seconds');
ylabel('Voltage angle (in degrees)');

P21 = (vTLLd_TL_21_22.*iLd_PV21 + vTLLq_TL_21_22.*iLq_PV21);
Q21 = (vTLLq_TL_21_22.*iLd_PV21 - vTLLd_TL_21_22.*iLq_PV21);
P22 = vTLRd_TL_21_22.*iSd_G22 + vTLRq_TL_21_22.*iSq_G22;
Q22 = vTLRq_TL_21_22.*iSq_G22 - vTLRd_TL_21_22.*iSq_G22;

PL21 = (vTLLd_TL_21_22.*iLd_L21 + vTLLq_TL_21_22.*iLq_L21);
QL21 = (vTLLq_TL_21_22.*iLd_L21 - vTLLd_TL_21_22.*iLq_L21);
PL22 = vTLRd_TL_21_22.*iLd_L22 + vTLRq_TL_21_22.*iLq_L22;
QL22 = vTLRq_TL_21_22.*iLq_L22 - vTLRd_TL_21_22.*iLq_L22;

% Pbefore = [P21(100) P22(100) PL21(100) PL22(100)]
% Qbefore = [Q21(100) Q22(100) QL21(100) QL22(100)]
% 
% Pshoot = [max(abs(P21)) max(abs(P22)) max(abs(PL21)) max(abs(PL22))]
% Qshoot = [max(abs(Q21)) max(abs(Q22)) max(abs(QL21)) max(abs(QL22))]

Pafter = [P21(end) P22(end) PL21(end) PL22(end)]
Qafter = [Q21(end) Q22(end) QL21(end) QL22(end)]

figure(4)
subplot(2,1,1)
plot(t,P22,'b',t,P21,'r',t,PL22,'y', t,PL21,'g');
title('Real power generation (Disconnect from utility)');
legend('P22','P21','PL22','PL21');
xlabel('Time in seconds');
ylabel('Real Power (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,Q22,'b',t,Q21,'r',t,QL22,'y', t,QL21,'g');
title('Reactive power generation ');
legend('Q22','Q21','QL22','QL21');
xlabel('Time in seconds');
ylabel('Reactive Power (in p.u)');

save('data2.mat')
end



