clear all
Rf = 0.0069;
Lf = 0.9425;

Cf = 0.0921;
Cdc = Cf;

Rc = Rf; Lc = Lf;

RL = 3.66815*1.00;
LL = 1.1626*1;
% syms LL real
PPV = 0.875; QPV = 0.5; 
PL = 0.98*PPV; QL = 1.02*QPV;

omega0 = 1; wb = 377;
iPV = 0.9773;
CTL = 0.01;
x0 = [1.0473316
  0.085166
   4.16
  1.066495
   0.34098
 1.491107
   0.042304
  1.031902
   0.0481003
 1.0443183
   0.145673
  0    
  0.911
 -0.0
 0];

  syms iFd iFq vDC vOutd vOutq iOutd iOutq vBd vBq ...
        iLd iLq gammad gammaq PdiffInt VdiffInt delP real

    syms Vc alpha real;
x = [iFd iFq vDC vOutd vOutq iOutd iOutq vBd vBq ...
        iLd iLq gammad gammaq VdiffInt delP];        

    u = [Vc alpha];
        
    Kpvt = 23; Kivt = 0.73;
        
        Kpv = 0.04; Kiv = 0.005;
        Kpp = 1; Kip = 1;
        Pac = vBd*iOutd + vBq*iOutq;
        
        alpha = -Kpp*(Pac - PL) - Kip*delP;
    
        Vt_ref = 1.1;
        Vt = sqrt(vBd^2 + vBq^2);
        Vc = Vt_ref*(1+ Kpvt*(Vt-Vt_ref) + Kivt*VdiffInt);% 
        
        vOutd_ref = Vc*cos(alpha); 
        vOutq_ref = Vc*sin(alpha);
        
        %Outer Voltage control
        iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
        iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
        
        %Inner current control
        ud = (Rf*iFd_ref + 0*vOutd - omega0*Lf*iFq)/vDC;
        uq = (Rf*iFq_ref + 0*vOutq + omega0*Lf*iFd)/vDC;
        
        diFddt = -Rf/Lf*(iFd - iFd_ref) ;
        diFqdt = -Rf/Lf*(iFq - iFq_ref) ;
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
        ddelPdt = Pac - PL;
        
        dx = wb*[diFddt;diFqdt;dvDCdt;dvOutddt;dvOutqdt;diOutddt; diOutqdt;...
            dvBddt; dvBqdt; diLddt;diLqdt; dgammaddt; dgammaqdt;...
            dVdiffdt;ddelPdt];% dphiddt; dphiqdt];
                    
    