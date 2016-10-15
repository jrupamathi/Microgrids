%SolveReducedPowerFlow for four bus uktimatley
syms V2d V2q V3d V3q Vmag2 Vmag3 real
V4d = 1; V4q = 0;

V2 = V2d + 1i*V2q;
V3 = V3d + 1i*V3q;
V4 = V4d + 1i*V4q;

Z23 = -0.0036 + 1i*0.2966;
P23 = 3*real(V2*conj((V2-V3)/Z23));
Q23 = 3*imag(V2*conj((V2-V3)/Z23));
P32 = 3*real(V3*conj((V3-V2)/Z23));
Q32 = 3*imag(V3*conj((V3-V2)/Z23));

PLoss23 = P23 + P32;
QLoss23 = Q23 + Q32;

Z24 = 0.0005 + 1i*0.3109;
P24 = 3*real(V2*conj((V2-V4)/Z24));
Q24 = 3*imag(V2*conj((V2-V4)/Z24));
P42 = 3*real(V4*conj((V4-V2)/Z24));
Q42 = 3*imag(V4*conj((V4-V2)/Z24));

PLoss24 = P24 + P42;
QLoss24 = Q24 + Q42;

Z34 = 0.0005 + 1i*0.3109;
P34 = 3*real(V3*conj((V3-V4)/Z34));
Q34 = 3*imag(V3*conj((V3-V4)/Z34));
P43 = 3*real(V4*conj((V4-V3)/Z34));
Q43 = 3*imag(V4*conj((V4-V3)/Z34));

PLoss34 = P34 + P43;
QLoss34 = Q34 + Q43;

ZL2 = (4.3709 + 1i*2.2458);%*0.01;
ZL3 = (4.2986 + 1i*2.0362);%*0.01;
ZL4 = (4.9832 + 1i*3.3582);%*0.01;


Psh2 = 3*real(V2*conj(V2/ZL2));
Qsh2 = 3*imag(V2*conj(V2/ZL2));

Psh3 = 3*real(V3*conj(V3/ZL3));
Qsh3 = 3*imag(V3*conj(V3/ZL3));

Psh4 = 3*real(V4*conj(V4/ZL4));
Qsh4 = 3*imag(V4*conj(V4/ZL4));



syms PG1 PG2 PPV QPV real
PG1 = 0.25; PPV = 3.5/4; QPV = 0;
%%
%bus 2
eqn1(1) = P23 + Psh2 + P24 - PG1;
eqn1(2) = V2d^2 + V2q^2 - 1;%Vmag2^2;

% %bus 4 
% eqn1(3) = P24 + P34 - Psh4 + PG2;

%bus 3 
eqn1(3) = P23 - Psh3 + PPV - P34;
eqn1(4) = Q23 - Qsh3 + QPV - Q34;
% eqn1(4) = V3d^2 + V3q^2 - 1;%Vmag3^2;
%%
Zeq = Z23*Z34/(Z23+Z34);

Ptrans = 3*real(V4*conj((V4-V3)/Zeq));
Qtrans = 3*imag(V4*conj((V4-V3)/Zeq));
PtransPrime = 3*real(V3*conj(-(V4-V3)/Z34));
QtransPrime = 3*imag(V3*conj(-(V4-V3)/Z34));

PLoss = Ptrans + PtransPrime;
QLoss = Qtrans + QtransPrime;

%bus 3 
eqn1(1) = Ptrans - Psh3 + PPV;
eqn1(2) = Qtrans - Qsh3 + QPV;
% eqn1(6) = V3d^2 + V3q^2 - 1;%Vmag3;
