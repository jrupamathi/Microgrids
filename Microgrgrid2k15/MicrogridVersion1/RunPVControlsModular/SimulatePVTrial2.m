function SimulatePV
Rf = 0.0069;
Lf = 0.9425;

% Rdc = 10*Rf;
Cdc = 0.0921;
Cf = Cdc;
Rc = Rf; Lc = Lf;
RL = 3.66815*1.00;
LL = 1.1626*1;

PPV = 0.875; QPV = 0.5; 
% PL = 0.98*PPV; QL = 1.02*QPV;
PL = 0.21; QL = 0.1;%0.066;

omega0 = 1; wb = 377;
iPV = 0.9773;
CTL = 0.01*1;

x0 = [1.00556973
    0.000412645
        -1.0584
   1.031983
    0.16522
    1.031983
    0.16522
   1.031983
    0.16522
   1.031983
    0.16522
    2.43245e-7
    8.45104e-13
   -1.11708e-12
    -0.00525839
        9.54
       -4.41];
%     107.461
%    -0.43178];
% x0 = randn(13,1);

Kpv = 1e-2; Kiv = 0.1e-2;%vTerm
% Kp = 1; Ki = 1;
Kp = 1; Ki = 0.1e0; %vOut
Kpp = 1;Kip =0.1; %Power      
Kpc = 1; Kic = 0.1; %Field
        
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
        phid = x(14);
        phiq = x(15);
        delP = x(16);
        delVt = x(17);
        
        t
        Kpc = 0.4; 
        Pref = 1.02*PL;
        P = vBd*iOutd+vBq*iOutq;
        Vt = sqrt(vOutd^2 + vOutq^2); Vt_ref = 1.05;
        vB = sqrt(vBd.^2 + vBq.^2);
%         Kpp =Lc/(Vt*vB) * mult; 
        
        alpha_eq = Lf*Pref/(Vt_ref^2);
        alpha = -Kpp*(P - Pref) - Kip*(delP)+ angle(vBd+1i*vBq) + alpha_eq;
        Vc = Vt*(1-Kp*(Vt-Vt_ref) -Ki*delVt);
        vOutd_ref = Vc*cos(alpha); vOutq_ref = Vc*sin(alpha);
        %Outer Voltage control
        iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
        iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
        % Current control
%         vInd_ref = vOutd-omega0*Lf*iFq + Kpc*(iFd_ref-iFd) + Kic*gammad;
%         vInq_ref = vOutq+omega0*Lf*iFd + Kpc*(iFq_ref-iFq) + Kic*gammaq;
        
        
        ud = (Rf*iFd_ref + vOutd - omega0*Lf*iFq)/vDC;
        uq = (Rf*iFq_ref + vOutq + omega0*Lf*iFd)/vDC;
        
        diFddt = -(Rf+Kpc)/Lf*(iFd - iFd_ref) -Kic*phid;
        diFqdt = -(Rf+Kpc)/Lf*(iFq - iFq_ref) -Kic*phiq;
%         diFddt = -Rf*iFd/Lf + (vDC*ud - vOutd)/Lf + omega0*iFq;
%         diFqdt = -Rf*iFq/Lf + (vDC*uq - vOutq)/Lf - omega0*iFd;
        dvDCdt = 0;%(iPV - (iFd*ud + iFq*uq))/Cdc;% - vDC/(Rdc);
        
        dvOutddt = -Kpv*Cf*(vOutd-vOutd_ref)-Kiv*Cf*gammad;%(iFd - iOutd)/CTL + omega0*iFq;% - vTd/(1000*Rf);
        dvOutqdt = -Kpv*Cf*(vOutq-vOutq_ref)-Kiv*Cf*gammaq;%-(-iFq + iLq)/CTL - omega0*iFd;% - vTq/(1000*Rf);

%         dvOutddt = (iFd - iOutd)/CTL + omega0*iFq;% - vTd/(1000*Rf);
%         dvOutqdt = (iFq - iOutq)/CTL - omega0*iFd;% - vTq/(1000*Rf);
        
%         iLd = iOutd; iLq = iOutq;
%         vB = (RL + 1i*omega0*LL)*(iLd + 1i*iLq);
%         vBd = real(vB); vBq = imag(vB); 
        diOutddt = -Rc/Lc *iOutd+ (vOutd-vBd)/Lc + omega0*iOutq;
        diOutqdt = -Rc/Lc *iOutq+ (vOutq-vBq)/Lc - omega0*iOutd;
        
        dvBddt = (iOutd - iLd)/CTL + omega0*vBq;
        dvBqdt = (iOutq - iLq)/CTL - omega0*vBd;
        
        vT2 = vBd^2 + vBq^2;
        RL = PL*vT2/(PL^2 + QL^2); LL = QL*vT2/(PL^2 + QL^2);
        diLddt = -RL*iLd/LL + vBd/LL + omega0*iLq;
        diLqdt = -RL*iLq/LL + vBq/LL - omega0*iLd;
        
        dgammaddt = (vOutd - vOutd_ref);
        dgammaqdt = (vOutq - vOutq_ref);
        dphiddt = (iFd - iFd_ref);
        dphiqdt = (iFq - iFq_ref);
        ddelPdt = (P - Pref);
        ddelVtdt = Vt - Vt_ref;
%     figure(4)
        
        dx = wb*[diFddt;diFqdt;dvDCdt;dvOutddt;dvOutqdt;diOutddt; diOutqdt;...
            dvBddt; dvBqdt; diLddt;diLqdt; dgammaddt; dgammaqdt; dphiddt; dphiqdt;...
            ddelPdt;ddelVtdt];
      
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
gammad = x(:,12);
gammaq = x(:,13);
delP = x(:,16);
delVt = x(:,17);
%       
        
save('PVLoad.mat')

        Pref = PL;
        P = vBd.*iOutd+vBq.*iOutq;
        Vt = sqrt(vOutd.^2 + vOutq.^2); Vt_ref = 1.5;
        vB = sqrt(vBd.^2 + vBq.^2);
        
alpha_eq = Lf*Pref./(Vt_ref.^2);
        
alpha = -Kpp.*(P-Pref) - Kip.*(delP)+ angle(vBd+1i*vBq) + alpha_eq;
                Vc = Vt.*(1-Kp.*(Vt-Vt_ref) -Ki*delVt);
        
        vOutd_ref = Vc.*cos(alpha); vOutq_ref = Vc.*sin(alpha);
        
iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) - Kiv*(gammad);
iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) - Kiv*(gammaq);
            
% figure(1)
% plot(t,iFd,'b',t,iFd_ref,'g',t,iFq,'r',t,iFq_ref,'y');
% figure(2)
% plot(t,Vt,'k',t,Vc,'b',t,alpha,'y');
figure(1)
plot(t,iFd,t,iFq)
figure(2)
plot(t,vOutd,'b',t,vOutq)
figure(3)
plot(t,Vt,t,P)

end
