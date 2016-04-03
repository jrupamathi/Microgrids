%SolveReducedPowerFlow for four bus uktimatley
syms V1d V1q V2d V2q V3d V3q Vmag2 Vmag3 real
V4d = 1; V4q = 0;
V1 = V1d + 1i*V1q;
V2 = V2d + 1i*V2q;
V3 = V3d + 1i*V3q;
V4 = V4d + 1i*V4q;

Z12 = 0.0001 + 1i*0.1;
P12 = 3*real(V1*conj((V1-V2)/Z12));
Q12 = 3*imag(V1*conj((V1-V2)/Z12));
P21 = 3*real(V2*conj(-(V1-V2)/Z12));
Q21 = 3*imag(V2*conj(-(V1-V2)/Z12));

PLoss12 = P12 + P21;
QLoss12 = Q12 + Q21;

Z13 = 0.0001 + 1i*0.1;
P13 = 3*real(V1*conj((V1-V3)/Z13));
Q13 = 3*imag(V1*conj((V1-V3)/Z13));
P31 = 3*real(V3*conj(-(V1-V3)/Z13));
Q31 = 3*imag(V3*conj(-(V1-V3)/Z13));
PLoss13 = P13 + P31;
QLoss13 = Q13 + Q31;

Z14 = 0.0015 + 1i*0.1048;
P14 = 3*real(V1*conj((V1-V4)/Z14));
Q14 = 3*imag(V1*conj((V1-V4)/Z14));
P41 = 3*real(V4*conj(-(V1-V4)/Z14));
Q41 = 3*imag(V4*conj(-(V1-V4)/Z14));
PLoss14 = P14 + P41;
QLoss14 = Q14 + Q41;

ZL1 =  3.2626 + 1i*1.6180;
ZL2 = 8.0295 + 1i*4.1786;
ZL3 = 7.7801 + 1i*3.4901;
ZL4 = 9.3958 + 1i*8.5858;

Psh1 = 3*real(V1*conj(V1/ZL1));
Qsh1 = 3*imag(V1*conj(V1/ZL1));

Psh2 = 3*real(V2*conj(V2/ZL2));
Qsh2 = 3*imag(V2*conj(V2/ZL2));

Psh3 = 3*real(V3*conj(V3/ZL3));
Qsh3 = 3*imag(V3*conj(V3/ZL3));

Psh4 = 3*real(V4*conj(V4/ZL4));
Qsh4 = 3*imag(V4*conj(V4/ZL4));

syms PG1 PG2 PPV QPV real
%Ppv = 3.5/4; Qpv = 0; 

%%
%Bus 1
eqn1(1) = P12 + P13 + P14 + Psh1;
eqn1(2) = Q12 + Q13 + Q14 + Qsh1;

%bus 2
eqn1(3) = P12 - Psh2 + PG1;
eqn1(4) = V2d^2 + V2q^2 - 1;%Vmag2;

%bus 3 
eqn1(5) = P13 - Psh3 + PPV;
% eqn1(6) = Q13 - Qsh3 + QPV;
eqn1(6) = V3d^2 + V3q^2 - 1;%Vmag3;
%%
%Eliminate bus 4
%Bus 1
eqn2(1) = P14 + P13 + Psh1;
eqn2(2) = Q14 + Q13 + Qsh1;

%bus 3 
eqn2(3) = P13 - Psh3 + PPV;
% eqn2(4) = Q13 - Qsh3 + QPV;
eqn2(4) = V3d^2 + V3q^2 - Vmag3^2;
%%
%Eliminate bus 1
% syms Peq Qeq real
%bus 1
eqn3(1) = P12 + Peq + P14 + Peq;
eqn3(2) = Q12 + Qeq + Q14 + Qeq;

%bus 2
eqn3(3) = P12 - Psh2 + PG1;
eqn3(4) = V2d^2 + V2q^2 - Vmag2;
%%

