%SolveReducedPowerFlow
V1d=1.0;
V1q=0.0; 
V2d=1.0;
V2q=0.0; 
syms V3d V3q real

V1 = V1d + 1i*V1q;
V2 = V2d + 1i*V2q;
V3 = V3d + 1i*V3q;

Z12 = 0.0005 + 1i*0.3098;
P12 = 3*real(V1*conj((V1-V2)/Z12));
Q12 = 3*imag(V1*conj((V1-V2)/Z12));
P21 = 3*real(V2*conj(-(V1-V2)/Z12));
Q21 = 3*imag(V2*conj(-(V1-V2)/Z12));

PLoss12 = P12 + P21;
QLoss12 = Q12 + Q21;

Z13 = -0.0037 + 1i*0.2956;
P13 = 3*real(V1*conj((V1-V3)/Z13));
Q13 = 3*imag(V1*conj((V1-V3)/Z13));
P31 = 3*real(V3*conj(-(V1-V3)/Z13));
Q31 = 3*imag(V3*conj(-(V1-V3)/Z13));
PLoss13 = P13 + P31;
QLoss13 = Q13 + Q31;

Z23 = 0.0005 + 1i*0.3098;
P23 = 3*real(V2*conj((V2-V3)/Z23));
Q23 = 3*imag(V2*conj((V2-V3)/Z23));
P32 = 3*real(V3*conj(-(V2-V3)/Z23));
Q32 = 3*imag(V3*conj(-(V2-V3)/Z23));
PLoss23 = P23 + P32;
QLoss23 = Q23 + Q32;

ZL1 = 4.3709 + 1i*2.2458;%5.151 + 1i*1.3302;
ZL2 = 4.3161 + 1i*2.0218;%6.4643 + 1i*2.2485;
ZL3 = 4.9832 + 1i*3.3582;%4.8212 - 1i*1.4135;

Psh1 = 3*real(V1*conj(V1/ZL1));
Qsh1 = 3*imag(V1*conj(V1/ZL1));

Psh2 = 3*real(V2*conj(V2/ZL2));
Qsh2 = 3*imag(V2*conj(V2/ZL2));

Psh3 = 3*real(V3*conj(V3/ZL3));
Qsh3 = 3*imag(V3*conj(V3/ZL3));

Ppv = 3.5/4; Qpv = 0;
eqn(1) = P13 + P23 - Psh3 + Ppv;
eqn(2) = Q13 + Q23 - Qsh3 + Qpv;

Fin = solve(eqn,[V3d;V3q]);
%%
%SolveReducedPowerFlow for C = 1e-4
% 
% % syms V1d V1q V2d V2q V3d V3q
% V1d=1.02;
% V1q=0.01; 
% V2d=1.02;
% V2q=0.01; 
% syms V3d V3q real
% 
% V1 = V1d + 1i*V1q;
% V2 = V2d + 1i*V2q;
% V3 = V3d + 1i*V3q;
% 
% Z12 = 0.0005 + 1i*0.31098;
% P12 = real(V1*conj((V1-V2)/Z12));
% Q12 = imag(V1*conj((V1-V2)/Z12));
% 
% Z13 = -0.0036 + 1i*0.2966;
% P13 = real(V1*conj((V1-V3)/Z13));
% Q13 = imag(V1*conj((V1-V3)/Z13));
% 
% Z23 = 0.0005 + 1i*0.31098;
% P23 = real(V2*conj((V2-V3)/Z23));
% Q23 = imag(V2*conj((V2-V3)/Z23));
% 
% ZL1 = 0.9834 + 1i*3.2502;
% ZL2 = 4.9832 + 1i*3.3582;
% ZL3 = 4.3161 + 1i*2.0281;
% 
% Psh1 = real(V1*conj(V1/ZL1));
% Qsh1 = imag(V1*conj(V1/ZL1));
% 
% Psh2 = real(V2*conj(V2/ZL2));
% Qsh2 = imag(V2*conj(V2/ZL2));
% 
% Psh3 = real(V3*conj(V3/ZL3));
% Qsh3 = imag(V3*conj(V3/ZL3));
% 
% Ppv = 3.5/4; Qpv = 0;
% eqn(1) = P13 + P23 - Psh3 + Ppv;
% eqn(2) = Q13 + Q23 - Qsh3 + Qpv;
% 
% Fin = solve(eqn,[V3d;V3q]);
