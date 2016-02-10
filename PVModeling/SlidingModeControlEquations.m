syms iRd iRq vTLLd vTLLq Pref Vref...
    CTL RTL LTL LR RR Vc alpha Pref Qref Vref...
    dvTLLddt dvTLLqdt c1 c2 vRLd vRLq iRdref iRqref diRdrefdt diRqrefdt
dphidt = 1; omega0 = 1;
%RTL = 1e-4; LTL = 0.1; RR = 1e-3; LR = 0.1; CTL = 0.1;
%iInLd = iRd; iInLq = iRq; vTLRd = 1; vTLRq = 0;
% dvTLLddt = (iInLd - iTLMd)/CTL + dphidt*vTLLq;
% dvTLLqdt = (iInLq - iTLMq)/CTL - dphidt*vTLLd;
% diTLMddt = dphidt*iTLMq - (vTLRd - vTLLd + RTL*iTLMd)/(LTL);
% diTLMqdt = - dphidt*iTLMd - (vTLRq - vTLLq + RTL*iTLMq)/(LTL);

convMat = [vTLLd vTLLq;
             -vTLLq vTLLd];
% %convMat = eye(2);
I = convMat\[Pref;Qref];
 iRdref = I(1)/1.5; iRqref = I(2)/1.5;         
 
vRRd = vTLLd; vRRq = vTLLq;
%vRLd = Vc*cos(alpha); vRLq = Vc*sin(alpha);
diRddt = (vRLd - RR*iRd - vRRd)/LR + omega0*iRq;
diRqdt = (vRLq - RR*iRq - vRRq)/LR - omega0*iRd;
          
VTL = sqrt(vTLLd^2 + vTLLq^2);
%delta = atan(vTLLq/vTLLd);
dVTLdt = (vTLLd*dvTLLddt + vTLLq*dvTLLqdt)/(VTL);
%ddeltadt = 1/VTL^2 * (vTLLd*dvTLLqdt - vTLLq*dvTLLddt);

% slide1 = Pref - 1.5*(vTLLd*iRd +vTLLq*iRq);%(VTL*Vc*sin(alpha-delta)/LR);
% slide2 = Qref - 1.5*(-vTLLq*iRd + vTLLd*iRq);
%slide2 = Vref^2 - (VTL^2);

%dslide1dt = diff(iRdref,vTLLd)*dvTLLddt + diff(iRdref,vTLLq)*dvTLLqdt - diRddt + c1*(iRdref - iRd);
%dslide2dt = diff(iRqref,vTLLd)*dvTLLddt + diff(iRqref,vTLLq)*dvTLLqdt - diRqdt + c2*(iRqref - iRq);
dslide1dt = diRdrefdt - diRddt + c1*(iRdref - iRd);
dslide2dt = diRqrefdt - diRqdt + c2*(iRqref - iRq);
% dslide1dt = -Vc/LR * (VTL*cos(alpha-delta)*(-ddeltadt) + sin(alpha - delta)*dVTLdt)+...
%     c1*slide1;
% dslide1dt = -1.5*(dvTLLddt*iRd + vTLLd*diRddt + dvTLLqdt*iRq + vTLLq*diRqdt)+...
%     c1*slide1;
% dslide2dt = -1.5*(-dvTLLqdt*iRd - vTLLq*diRddt + dvTLLddt*iRq + vTLLd*diRqdt)+...
%     c2*slide2;

%dslide2dt = -2*VTL*dVTLdt + c2*(slide2);

dx = [dslide1dt; dslide2dt];

x = [vRLd;vRLq];
solve(dx,x)