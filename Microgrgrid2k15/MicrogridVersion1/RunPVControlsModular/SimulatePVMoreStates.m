function SimulatePVMoreStates
Rf = 0.0069;
Lf = 0.9425;

Cf = 0.0921;
Cdc = Cf;

Rc = Rf; Lc = Lf;

RL = 3.66815*1.00;
LL = 20;

PPV = 0.875; QPV = 0.5; 
PL = 0.98*PPV; QL = 1.02*QPV;

omega0 = 1; wb = 377;
iPV = 0.9773;
CTL = 0.01;
x0 = randn(17,1);
x0 = [0.0847043
    1.42649
    12006.8
    1.11178
   -1.21282
 -0.0319973
 -0.0546715
    1.09819
   -1.13938
    46.9994
    364.983
 -0.0478067
 -0.0616154];
%    -209.898
%    -1.53414
%    -4947.95
%   -0.127711];
tic
[t,x] = ode45(@RunPVLoad,[0,3],x0);
time = toc

    function dx = RunPVLoad(t,x)
        iFd = x(1);
        iFq = x(2);
        vDC = x(3);
        vOutd = x(4);
        vOutq = x(5);
        iOutd = x(6);
        iOutq = x(7);
        vBD = x(8);
        vBQ = x(9);
        phid = x(10);
        phiq = x(11);
%         gammad = x(12);
%         gammaq = x(13);
        iLD = x(12);
        iLQ = x(13);
%         dVInt = x(14);
%         omegaInt = x(15);
%         PInt = x(16);
%         delta = x(17);
        
        t
        
        delta = 0;
        Ts = [cos(delta) -sin(delta); 
            sin(delta) cos(delta)];
        Tsinv = inv(Ts);
        vLocal = Tsinv*[vBD;vBQ];
        
        vBd = vLocal(1); vBq = vLocal(2);
        iGlobal = Ts*[iOutd;iOutq];
        iOutD = iGlobal(1); iOutQ = iGlobal(2);
        
        P = vBD*iOutD+vBQ*iOutQ;
        Q = vBQ*iOutQ-vBQ*iOutQ;
        
        PL = vBD*iLD+vBQ*iLQ;
        Pdc = vDC*iPV;
        
%         omega = 1;
%         omega_ref = 1-0.2*(P-PL);
%         alpha1 = (omega-omega_ref)+omegaInt;
%         alpha2 = (1.0*P - Pdc)+PInt;
%         alpha_ref = (1*alpha1+ 1*alpha2)/2;
%         
%         Vt = sqrt(vOutd^2 + vOutq^2);
%         Vt_ref = 1.1;
        
%         Vc_ref =( (Vt_ref-Vt)+dVInt+1)*Vt;
        Vc_ref = 1.1; alpha_ref = 0.01;
        vOutd_ref = Vc_ref*cos(alpha_ref);
        vOutq_ref = Vc_ref*sin(alpha_ref);
        
%         Kpc = 0.04; Kic = 0.5;
        Kpv = 400; Kiv = 0.00000001;
%             Kpc = 1; Kic = 1; Kpv = 1; Kiv = 1;
%         vOutd_ref = 1.1; vOutq_ref = 0;
        
%         %Outer Voltage control
%         iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) + Kiv*(phid);
%         iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) + Kiv*(phiq);
%         % Current control
%         vInd_ref = 0*vOutd-omega0*Lf*iFq + Kpc*(iFd_ref-iFd) + Kic*gammad;
%         vInq_ref = 0*vOutq+omega0*Lf*iFd + Kpc*(iFq_ref-iFq) + Kic*gammaq;
%         
        %Outer Voltage control
        iFd_ref = iOutd - omega0*Cf*vOutq + Kpv*(vOutd_ref - vOutd) + Kiv*(phid);
        iFq_ref = iOutq + omega0*Cf*vOutd + Kpv*(vOutq_ref - vOutq) + Kiv*(phiq);
        % Current control
        vInd_ref = vOutd-omega0*Lf*iFq + Rf/Lf*(iFd_ref);% + Kic*gammad;
        vInq_ref = vOutq+omega0*Lf*iFd + Rf/Lf*(iFq_ref);% + Kic*gammaq;
        

%Physical switches input
        ud = vInd_ref/vDC; uq = vInq_ref/vDC;
        vInd = vDC*ud; vInq = vDC*uq;
%         vInd = vInd_ref; vInq = vInq_ref;
        %PV inverter filter dynamics
        diFddt = -Rf/Lf*(iFd-iFd_ref);%-Rf*iFd/Lf + (vInd - vOutd)/Lf + omega0*iFq;
        diFqdt = -Rf/Lf*(iFd-iFd_ref);%-Rf*iFq/Lf + (vInq - vOutq)/Lf - omega0*iFd;
        dvDCdt = (iPV - (iFd*ud + iFq*uq))/Cdc;% - vDC/(100*Rf);
        
        %Coupling capacitor dynamics
        dvOutddt = Kpv*Cf*(vOutd_ref - vOutd) + Kiv*Cf*(phid);%omega0*vOutq + (iFd-iOutd)/Cf;
        dvOutqdt = Kpv*Cf*(vOutd_ref - vOutd) + Kiv*Cf*(phiq);%-omega0*vOutd + (iFq-iOutq)/Cf;

        %Coupling inductor dynamics
        diOutddt = -Rc*iOutd/Lc + (vOutd-vBd)/Lc + omega0*iOutq;
        diOutqdt = -Rc*iOutq/Lc + (vOutq-vBq)/Lc - omega0*iOutd;
        
        %Integral gain equations
        dphiddt = vOutd_ref-vOutd;
        dphiqdt = vOutq_ref-vOutq;
        
%         dgammaddt = iFd_ref - iFd;
%         dgammaqdt = iFq_ref - iFq;
        %Transmission line bus dynamics
        dvBDdt = omega0*vBQ + (iOutD-iLD)/CTL;
        dvBQdt = -omega0*vBD + (iOutQ-iLQ)/CTL;

%         RL = PL*vT2/(PL^2 + QL^2); LL = QL*vT2/(PL^2 + QL^2);
        diLDdt = -RL*iLD/LL + vBD/LL + omega0*iLQ;
        diLQdt = -RL*iLQ/LL + vBQ/LL - omega0*iLD;
        
%         dVIntdt = Vt-Vt_ref;
%         domegaIntdt = omega-omega_ref;
%         dPIntdt = P-Pdc;
%         ddeltadt = omega-omega_ref;
        
        dx = wb*[diFddt; diFqdt;dvDCdt;dvOutddt;dvOutqdt;...
        diOutddt; diOutqdt; dvBDdt; dvBQdt; dphiddt; dphiqdt;...
        ...%dgammaddt; dgammaqdt; 
        diLDdt; diLQdt];%dVIntdt;...
%         domegaIntdt; dPIntdt; ddeltadt];
        
    end

        iFd = x(:,1);
        iFq = x(:,2);
        vDC = x(:,3);
        vOutd = x(:,4);
        vOutq = x(:,5);
        iOutd = x(:,6);
        iOutq = x(:,7);
        vBD = x(:,8);
        vBQ = x(:,9);
        phid = x(:,10);
        phiq = x(:,11);
        iLD = x(:,12);
        iLQ = x(:,13);
                
save('PVLoad.mat')
V = sqrt(vBD.^2+vBQ.^2);
figure(1)
plot(t,V)

figure(2)
plot(t,iFd,t,iFq)

figure(3)
plot(t,iLD,t,iLQ)
end
