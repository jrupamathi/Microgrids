function InterconnSCMicrogridWithPVRLLoadDisconnect
% generator parameters

set(0,'defaultlinelinewidth',1.5)
addpath('../Parameters')

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','RF_G23','H_G23','B_G23','Rkq_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','RF_G22','H_G22','B_G22','Rkq_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');
% tauL_G22_ref = 0.1*tauL_G22_ref;
load('L21.mat', 'RL_L21', 'LL_L21');


Rf = 0.0069;
Lf = 0.9425;

% Rdc = 10*Rf;
Cdc = 0.0921;
Cf = Cdc;
Rc = Rf + 0.275; 
Lc = Lf + 0.0967;
RL = 3.66815*1.00;
LL = 1.1626*1;

PPV = 0.875; QPV = 0.5; 
% PL = 0.98*PPV; QL = 1.02*QPV;
PL = 0.875; QL = 0.066;
Vt_ref = 1.08;
        
omega0 = 1; wb = 377;
iPV = 0.9773;

RL_L21 = 0.5002; LL_L21 = 0.346;

K1_G22 = 0.8808; K2_G22 = 12.8569; K3_G22 = -0.9281;
% K1_G22 = 2.2092; K2_G22 = 24.8318;
% K3_G22 = -5.7645;

load('TL_1_21.mat', 'LTL_TL_1_21', 'RTL_TL_1_21','CTL_TL_1_21');
load('TL_1_22.mat', 'LTL_TL_1_22', 'RTL_TL_1_22','CTL_TL_1_22');
load('TL_1_23.mat', 'LTL_TL_1_23', 'RTL_TL_1_23','CTL_TL_1_23');

RTL_TL_21_23 = 0.0287+0.022;%0.15*(RTL_TL_1_21 + RTL_TL_1_23 + RTL_TL_1_21*RTL_TL_1_23/RTL_TL_1_22);
LTL_TL_21_23 = 0.1104+0.012;%0.15*(LTL_TL_1_21 + LTL_TL_1_23 + LTL_TL_1_21*LTL_TL_1_23/LTL_TL_1_22);
CTL_TL_21_23 = 0.01;%1*CTL_TL_1_21;

dphidt = 1;


x0int = [ -2.31606
    0.0214074
 0.0000116881
  0.000105004
     -2.81147
     -1.73038
      1.00001
     -1.53579
    -0.369139
    -0.630434
     -0.71788
      2.32688
   -0.0292353
    -0.761427
     -0.99942
     0.804863
    -0.405655
     0.833936
      -0.3488
      96009.6
   0.00447919
  -0.00221433
  -0.00154768
   0.00618397
     -2173.34
     -7194.15
    -0.281942
    0.0989658];
  
x0iso = [-0.00636119
   0.0119782
 -3.3896e-11
  1.89179e-7
   -0.563279
    0.488279
         1.0
    0.148641
    0.139219
     0.22495
     1.50523
    -5928.86
    -14420.3
     1.19782
    0.636119
     0.09162
    0.127511
    -1.69729
     4.78255
     96009.2
    0.156725
     1.17995
   0.0744604
 0.000351484
    -23.0357
    -6365.41
    -2.78547
      1.5105];
tic
faulton = 1; faultoff = 2;

[t,x]=ode45(@MilosSmTlWorking,[0,2],x0int);
time  = toc
% x=ode5(@MilosSmTlWorking,[0,0.1],x0);
% for j = 1:numel(t)
% [~,iInd(j,:),iInq(j,:)]=MilosSmTlWorking(t(j),x(j,:)); 
% end

function dx = MilosSmTlWorking(t,x)  
    t
    % States
iSd_G22 = x(1);
iSq_G22 = x(2);
iRd_G22 = x(3);
iRq_G22 = x(4);
iF_G22 = x(5);
delta_G22 = x(6);
omega_G22 = x(7);
iLd_L21 = x(8);
iLq_L21 = x(9);
vTLLd_TL_21_23 = x(10);
vTLLq_TL_21_23 = x(11);
if(t<faulton || t>faultoff)
    iTLMd_TL_21_23 = x(12);
    iTLMq_TL_21_23 = x(13);
else
    iTLMd_TL_21_23 = 0;
    iTLMq_TL_21_23 = 0;
end
vTLRd_TL_21_23 = x(14);
vTLRq_TL_21_23 = x(15);
iLd_PV21 = x(16);
iLq_PV21 = x(17);

iFd = x(18);
iFq = x(19);
vDC = x(20);
vOutd = x(21);
vOutq = x(22);
iOutd = iLd_PV21;
iOutq = iLq_PV21;
vBd = vTLLd_TL_21_23;
vBq = vTLLq_TL_21_23;
gammad = x(23);
gammaq = x(24);
VdiffInt = x(25);
delP = x(26);
phid =x(27);
phiq =x(28);
        %Kivt = 1e-3
        
        if(t<faulton||t>faultoff)
            Kpvt = 1e0; Kivt = 0.1e-3;
            Kpv = 1e0; Kiv = 0.1e0;
            Kpp = 1e3; Kip = 0.1e2;
            Kpc = 0e0;Kic = 1e0;
        else
            Kpvt = -1e1; Kivt = -0.1e0;
            Kpv = 1e0; Kiv = 0.1e0;
            Kpp = 1e2; Kip = 0.1e1;
            Kpc = 0e0;Kic = 1e0;
        end

        P = (vBd*iOutd + vBq*iOutq);
        Q = (vBq*iOutd - vBd*iOutq);
        
        Pref = 0.875;%vBd*iLd_L21 + vBq*iLq_L21; 
        Qref =0.01;%vBq*iLd_L21 - vBd*iLq_L21; 
        alpha_eq = Pref/(Vt_ref^2);
        
        f = 1;% + 1/0.3*(P-PL);
        if (t<faulton||t>faultoff)
            alpha = -Kpp*(P - Pref) - Kip*delP + atan(vBq/vBd) + alpha_eq;
        else
            
            alpha = -Kpp*(f - 1) - 0*Kip*delP + atan(vBq/vBd) + alpha_eq;       
        end
    
        Vt = sqrt(vBd^2 + vBq^2);
        if (t<faulton||t>faultoff)
            Vc = Vt_ref*(1+ Kpvt*(Q-Qref) + Kivt*VdiffInt);% 
            RL_L21 = 0.5002; LL_L21 = 0.346;
        else
            Vc = Vt_ref*(1+ Kpvt*(Vt-Vt_ref) + 1*Kivt*VdiffInt);% 
            Rc = Rf; Lc = Lf;
            RL_L21 = 1*4.9098; LL_L21 = 1*2.8962;
        end
        vOutd_ref = Vc*cos(alpha); 
        vOutq_ref = Vc*sin(alpha);
        %Outer Voltage control
        iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
        iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
        
        %Inner current control
        ud = (Rf*iFd_ref + 1*vOutd - omega0*Lf*iFq)/vDC;
        uq = (Rf*iFq_ref + 1*vOutq + omega0*Lf*iFd)/vDC;
        
        diFddt = -(Rf/Lf + Kpc)*(iFd - iFd_ref) -Kic*phid;
        diFqdt = -(Rf/Lf+ Kpc)*(iFq - iFq_ref) -Kic*phiq;
%         diFddt = -Rf*iFd/Lf + (vDC*ud - vOutd)/Lf + omega0*iFq;
%         diFqdt = -Rf*iFq/Lf + (vDC*uq - vOutq)/Lf - omega0*iFd;
        dvDCdt = (iPV - (iFd*ud + iFq*uq))/Cdc;% - vDCOut/(10*Rf);
        
        dvOutddt = -Kpv*Cf*(vOutd-vOutd_ref)-Kiv*Cf*gammad;%(iFd - iOutd)/CTL + omega0*iFq;% - vTd/(1000*Rf);
        dvOutqdt = -Kpv*Cf*(vOutq-vOutq_ref)-Kiv*Cf*gammaq;%-(-iFq + iLq)/CTL - omega0*iFd;% - vTq/(1000*Rf);

        dgammaddt = (vOutd - vOutd_ref);
        dgammaqdt = (vOutq - vOutq_ref);
        
        if (t<faulton||t>faultoff)
            dVdiffdt = (Q - Qref);
            ddelPdt = P - Pref;
            k1 = 0.1;
            k2 = 5;
        else
            dVdiffdt = (Vt - Vt_ref);
            ddelPdt = f - 1;
            k1 = 1;
            k2 = 1;
        end
        dphiddt = iFd-iFd_ref;
        dphiqdt = iFq-iFq_ref;
        
tauL_G22 = tauL_G22_ref - K1_G22*(delta_G22 - k1*delta_G22_ref) - K2_G22*(omega_G22 - omega_G22_ref);
vR_G22 = vR_G22_ref - K3_G22*(iF_G22 - k2*iF_G22_ref);
diSd_G22dt = 377*vTLRd_TL_21_23*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((Rkd_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iSq_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRq_TL_21_23*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRq_G22*((Laq_G22*Rkq_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*vTLRq_TL_21_23*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + 377*iRd_G22*((Rkd_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iSd_G22*(omega_G22 + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 1) + 377*vTLRd_TL_21_23*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_23*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_23*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*Rkq_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLRd_TL_21_23*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLRq_TL_21_23*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLRq_TL_21_23*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLRd_TL_21_23*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*Rkd_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*(omega_G22-omega0) - tauL_G22 + iSd_G22*vTLRd_TL_21_23 + iSq_G22*vTLRq_TL_21_23)/(2*H_G22);
diLd_L21dt = 377*dphidt*iLq_L21 + (377*(vTLLd_TL_21_23 - RL_L21*iLd_L21))/LL_L21;
diLq_L21dt = (377*(vTLLq_TL_21_23 - RL_L21*iLq_L21))/LL_L21 - 377*dphidt*iLd_L21;
dvTLLd_TL_21_23dt = -377*(iLd_L21-iLd_PV21 + iTLMd_TL_21_23  - CTL_TL_21_23*dphidt*vTLLq_TL_21_23)/(CTL_TL_21_23 );
dvTLLq_TL_21_23dt = -(377*(iLq_L21-iLq_PV21 + iTLMq_TL_21_23  + CTL_TL_21_23*dphidt*vTLLd_TL_21_23 ))/(CTL_TL_21_23 );
diTLMd_TL_21_23dt = 377*dphidt*iTLMq_TL_21_23 - (377*(vTLRd_TL_21_23 - vTLLd_TL_21_23 + RTL_TL_21_23*iTLMd_TL_21_23))/LTL_TL_21_23;
diTLMq_TL_21_23dt = - 377*dphidt*iTLMd_TL_21_23 - (377*(vTLRq_TL_21_23 - vTLLq_TL_21_23 + RTL_TL_21_23*iTLMq_TL_21_23))/LTL_TL_21_23;
dvTLRd_TL_21_23dt = 377*dphidt*vTLRq_TL_21_23 - (377*(- iSd_G22 - iTLMd_TL_21_23))/CTL_TL_21_23;
dvTLRq_TL_21_23dt = - 377*dphidt*vTLRd_TL_21_23 - (377*( - iSq_G22 - iTLMq_TL_21_23))/CTL_TL_21_23;

diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vOutd - vTLLd_TL_21_23 - Rc*iLd_PV21))/Lc;
diLq_PV21dt = (377*(vOutq - vTLLq_TL_21_23 - Rc*iLq_PV21))/Lc - 377*dphidt*iLd_PV21;

dx = [diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diLd_L21dt
diLq_L21dt
dvTLLd_TL_21_23dt
dvTLLq_TL_21_23dt
diTLMd_TL_21_23dt
diTLMq_TL_21_23dt
dvTLRd_TL_21_23dt
dvTLRq_TL_21_23dt
diLd_PV21dt
diLq_PV21dt
377*[diFddt;diFqdt;dvDCdt;dvOutddt;dvOutqdt;...
dgammaddt; dgammaqdt;...
dVdiffdt;ddelPdt; dphiddt; dphiqdt]
];
end

save('DataReducedMicrogrid1.mat')

iSd_G22 = x(:,1);
iSq_G22 = x(:,2);
iRd_G22 = x(:,3);
iRq_G22 = x(:,4);
iF_G22 = x(:,5);
delta_G22 = x(:,6);
omega_G22 = x(:,7);
iLd_L21 = x(:,8);
iLq_L21 = x(:,9);
vTLLd_TL_21_23 = x(:,10);
vTLLq_TL_21_23 = x(:,11);
iTLMd_TL_21_23 = x(:,12);
iTLMq_TL_21_23 = x(:,13);
vTLRd_TL_21_23 = x(:,14);
vTLRq_TL_21_23 = x(:,15);
iLd_PV21 = x(:,16);
iLq_PV21 = x(:,17);

iFd = x(:,18);
iFq = x(:,19);
vDC = x(:,20);
vOutd = x(:,21);
vOutq = x(:,22);
gammad = x(:,23);
gammaq = x(:,24);
VdiffInt = x(:,25);
delP = x(:,26);
phid =x(:,27);
phiq =x(:,28);
        
figure(1);
iS23 = sqrt(iSd_G22.^2 + iSq_G22.^2);
iPV = sqrt(iLd_PV21.^2 + iLq_PV21.^2);

plot(t,iS23,'b',t,iPV,'r');
title('Electrical quantites of G22 (Disconnect from the utility)');
legend('Stator current magnitude of G22','Current magnitude of PV');
xlabel('Time in seconds');
ylabel('Current Magnitude (in p.u)');

figure(2);
plot(t,delta_G22,'b',t,omega_G22,'r');
title('Mechanical quantites of G22 (Disconnect from the utility)');
legend('Rotor relative angle of G22','Angular velocity of G22');
xlabel('Time in seconds');
ylabel('in p.u');

V21 = (vTLLd_TL_21_23.^2 + vTLLq_TL_21_23.^2).^0.5;
V23 = (vTLRd_TL_21_23.^2 + vTLRq_TL_21_23.^2).^0.5;

phi21 = atan(vTLLq_TL_21_23./vTLLd_TL_21_23)*180/pi;
phi23 = atan(vTLRq_TL_21_23./vTLRd_TL_21_23)*180/pi;
Vbefore = [V21(100) V23(100)]

Vshoot = [max(abs(V21)) max(abs(V23))]

Vafter = [V21(end) V23(end)]

figure(3);
subplot(2,1,1)
plot(t,V23,'g',t,V21,'r');
title('Voltages at all the buses(Disconnect from the utility)');
legend('V23','V21');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,phi23,'g',t,phi21,'r');
title('Voltage angles at all the buses');
legend('phi23','phi21');
xlabel('Time in seconds');
ylabel('Voltage angle (in degrees)');

P21 = (vTLLd_TL_21_23.*iLd_PV21 + vTLLq_TL_21_23.*iLq_PV21);
Q21 = (vTLLq_TL_21_23.*iLd_PV21 - vTLLd_TL_21_23.*iLq_PV21);
P23 = vTLRd_TL_21_23.*iSd_G22 + vTLRq_TL_21_23.*iSq_G22;
Q23 = vTLRq_TL_21_23.*iSq_G22 - vTLRd_TL_21_23.*iSq_G22;
PL1 = (vTLLd_TL_21_23.*iLd_L21 + vTLLq_TL_21_23.*iLq_L21);
QL = (vTLLq_TL_21_23.*iLd_L21 - vTLLd_TL_21_23.*iLq_L21);

Pbefore = [P21(100) P23(100) PL1(100)]
Qbefore = [Q21(100) Q23(100) QL(100)]

Pshoot = [max(abs(P21)) max(abs(P23)) max(abs(PL1))]
Qshoot = [max(abs(Q21)) max(abs(Q23)) max(abs(QL))]

Pafter = [P21(end) P23(end) PL1(end)]
Qafter = [Q21(end) Q23(end) QL(end)]

figure(4)
subplot(2,1,1)
plot(t,P23,'g',t,P21,'r',t,PL1,'y');
title('Real power generation (Disconnect from utility)');
legend('P23','P21','PL');
xlabel('Time in seconds');
ylabel('Real Power (in p.u)');

% figure(6);
subplot(2,1,2)
plot(t,Q23,'g',t,Q21,'r',t,QL,'y');
title('Reactive power generation ');
legend('Q23','Q21','QL');
xlabel('Time in seconds');
ylabel('Reactive Power (in p.u)');

save('data2.mat')
end
