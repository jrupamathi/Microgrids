function SimulatePV
Rf = 0.0069;
Lf = 0.9425;

Cdc = 0.0921;

RL = 3.66815*1.00;
LL = 1.1626*1;

PPV = 0.875; QPV = 0.5; 
PL = 0.98*PPV; QL = 1.02*QPV;

omega0 = 1; wb = 377;
iPV = 0.9773;
CTL = 0.01*1;
x0 = [-0.0916682
  -0.222845
    43986.6
  -0.169521
  -0.916295
  -0.113977
   -0.21372];
tic
[t,x] = ode45(@RunPVLoad,[0,2],x0);
time = toc

    function dx = RunPVLoad(t,x)
        iFd = x(1);
        iFq = x(2);
        vDC = x(3);
        vTd = x(4);
        vTq = x(5);
        iLd = x(6);
        iLq = x(7);
        
        t
        vT2 = (vTd^2 + vTq^2);
        vTd1 = 1.1; vTq1 = 0.1;
        vT21 = (vTd1^2 + vTq1^2);
        id_ref = (PPV*vTd1 + QPV*vTq1)/vT21;
        iq_ref = (PPV*vTq1 - QPV*vTd1)/vT21;

%         Kp1 = 0.0004; Kp2 = 0.0004;
%         vTd_ref = 1.1; vTq_ref = 0.1;
%         id_ref = Kp1*(vTd_ref - vTd) + omega0*vTq + id_ref1;
%         iq_ref = Kp2*(vTq_ref - vTq) - omega0*vTd + iq_ref1;

        ud = (Rf*id_ref + vTd - omega0*Lf*iFq)/vDC;
        uq = (Rf*iq_ref + vTq + omega0*Lf*iFd)/vDC;
        
%         diFddt = -Rf/Lf*(iFd - id_ref);
%         diFqdt = -Rf/Lf*(iFq - iq_ref);
        diFddt = -Rf*iFd/Lf + (vDC*ud - vTd)/Lf + omega0*iFq;
        diFqdt = -Rf*iFq/Lf + (vDC*uq - vTq)/Lf - omega0*iFd;
        dvDCdt = (iPV - (iFd*ud + iFq*uq))/Cdc;% - vDC/(Rf);
        
        dvTddt = -(-iFd + iLd)/CTL + omega0*vTq;% - vTd/(1000*Rf);
        dvTqdt = -(-iFq + iLq)/CTL - omega0*vTd;% - vTq/(1000*Rf);
        
%         RL = PL*vT2/(PL^2 + QL^2); LL = QL*vT2/(PL^2 + QL^2);
        diLddt = -RL*iLd/LL + vTd/LL + omega0*iLq;
        diLqdt = -RL*iLq/LL + vTq/LL - omega0*iLd;
        
        dx = wb*[diFddt;diFqdt;dvDCdt;dvTddt;dvTqdt;diLddt;diLqdt];
      
    end

iFd = x(:,1);
iFq = x(:,2);
vDC = x(:,3);
vTd = x(:,4);
vTq = x(:,5);
iLd = x(:,6);
iLq = x(:,7);
        
save('PVLoad.mat')
V = sqrt(vTd.^2+vTq.^2);
figure(1)
plot(t,V)

figure(2)
plot(t,iFd,t,iFq)

figure(3)
plot(t,iLd,t,iLq)
end
