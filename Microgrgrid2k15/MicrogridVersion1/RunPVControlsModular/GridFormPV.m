function GridFeedPV
Rf = 0.0069;
Lf = 0.9425;

% Rdc = 10*Rf;
Cdc = 0.0921;
Cf = Cdc;
Rc = Rf; 
Lc = Lf;
RL = 3.66815*1.00;
LL = 1.1626*1;

PPV = 0.875; QPV = 0.5; 
% PL = 0.98*PPV; QL = 1.02*QPV;
PL = 0.21; QL = 0.066;

omega0 = 1; wb = 377;
iPV = 0.9773;
CTL = 0.01*1;

x0 = [-0.0422004
   0.245508
    44004.4
  -0.299947
    1.12275
  0.0576901
   0.268528
 -0.0480858
    1.09305
  0.0822977
   0.276756
   0.053908
   0.397907
   -50.1987
    506.567
  0.0716435
   0.346827];

% x0 = randn(13,1);
tic
[t,x] = ode45(@RunPVLoad,[0,1],x0);
time = toc

    function dx = RunPVLoad(t,x)
        iFd = x(1);
        iFq = x(2);
        vDC = x(3);
        vOutd = x(4);
        vOutq = x(5);
        iOutd = x(6);
        iOutq = x(7);
        vBd = x(8);
        vBq = x(9);
        iLd = x(10);
        iLq = x(11);
        gammad = x(12);
        gammaq = x(13);
        VdiffInt = x(14);
        delP = x(15);
        phid =x(16);
        phiq =x(17);
        
        %Kpvt = 1e-3; Kpp = 1e-3; Kic = 1e-3;Kip = 0.1e-3;Kiv = 0.1e-3;
        Kpvt = 1e0; Kivt = 0.1e0;
        Kpv = 1e0; Kiv = 0.1e0;
%         Kpv = 1e-3; Kiv = 0.1e0;
        Kpp = 1e0; Kip = 0.1e-3;
        Kpc = 0;Kic = 1e-2;
        
        alpha_eq = PL/(1.1^2);
        
        P = vBd*iOutd + vBq*iOutq;
        f = 1 + 1/0.3 * (P-PL);
%         Pdc = iPV*vDC;
%         alpha1 = (P-Pdc);
        alpha2 = -Kpp*(f - 1) - Kip*delP + atan(vBq/vBd) + alpha_eq;
        alpha = (alpha2);
        t
        Vt_ref = 1.1;
        Vt = sqrt(vBd^2 + vBq^2);
        Vc = Vt_ref*(1+ Kpvt*(Vt-Vt_ref) + Kivt*VdiffInt);% 
%         alpha = 0.01;
        
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

        diOutddt = -Rc/Lc *iOutd+ (vOutd-vBd)/Lc + omega0*iOutq;
        diOutqdt = -Rc/Lc *iOutq+ (vOutq-vBq)/Lc - omega0*iOutd;
        
        dvBddt = (iOutd - iLd)/CTL + omega0*vBq;
        dvBqdt = (iOutq - iLq)/CTL - omega0*vBd;
        
%         vT2 = vBd^2 + vBq^2;
%         RL = PL*vT2/(PL^2 + QL^2); LL = QL*vT2/(PL^2 + QL^2);
        diLddt = -RL*iLd/LL + vBd/LL + omega0*iLq;
        diLqdt = -RL*iLq/LL + vBq/LL - omega0*iLd;
        
        dgammaddt = (vOutd - vOutd_ref);
        dgammaqdt = (vOutq - vOutq_ref);
        
        dVdiffdt = (Vt - Vt_ref);
        ddelPdt = f - 1;
        dphiddt = iFd-iFd_ref;
        dphiqdt = iFq-iFq_ref;
        
        dx = wb*[diFddt;diFqdt;dvDCdt;dvOutddt;dvOutqdt;diOutddt; diOutqdt;...
            dvBddt; dvBqdt; diLddt;diLqdt; dgammaddt; dgammaqdt;...
            dVdiffdt;ddelPdt; dphiddt; dphiqdt];
      
    end

iFd = x(:,1);
iFq = x(:,2);
vDC = x(:,3);
vOutd = x(:,4);
vOutq = x(:,5);
iOutd = x(:,6);
iOutq = x(:,7);
vBd = x(:,8);
vBq = x(:,9);
iLd = x(:,10);
iLq = x(:,11);        
save('PVLoad.mat')
V = sqrt(vOutd.^2+vOutq.^2);
figure(1)
plot(t,V)

figure(2)
plot(t,iFd,t,iFq)

figure(3)
plot(t,iOutd,t,iOutq)
end
