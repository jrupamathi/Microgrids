%Getting two bus equivalent
%Power flow solutions
V = [1.001
0.988
1.002
1
0.996
0.997
1
0.998
0.996
0.995
0.992
0.994
0.993
0.986
0.978
0.997
0.995
0.986
0.961
0.995
1.008
1
1.02
];

S23 = (1-1i*0.36)/4;
S22 = (1.86 + 1i*3.98)/4;

%%
%Results from Kron's reduction to four bus

R = [ -0.0045    0.0237    0.0048    0.1657
    0.0237   -0.0251         0         0
    0.0048         0   -0.0048         0
    0.1657         0         0   -0.1651];
L = [   -0.0012    0.1092    0.0010    0.1067
    0.1092   -0.1076         0         0
    0.0010         0   -0.0011         0
    0.1067         0         0   -0.1033];
Z_tr = R + 1i*L;

Z1_21 = Z_tr(1,2);
Z1_22 = Z_tr(1,3);
Z1_23 = Z_tr(1,4);

Zsh = [   1.6396 + 0.9318i   5.2658 + 2.3663i   0.8353 + 0.5241i  10.7434 - 2.8402i];

ZL1 = Zsh(1);
ZL21 = Zsh(2);
ZL22 = Zsh(3);
ZL23 = Zsh(4);

Zg22 = -V(22)^2/conj(S22);
Zg23 = -V(23)^2/conj(S23);

%%
%Removing generator at bus 22

% Z_22 = ZL22*Zg22/(ZL22+Zg22);
% Z1_tr22 = Z_22 + Z1_22;
% Z1eq = ZL1 * Z1_tr22/(ZL1 + Z1_tr22);
% 
% %
% Z21_N = (ZL21*Z1_21)/(ZL21 + Z1_21 + Z1eq);
% Z1_N = (Z1eq*Z1_21)/(ZL21 + Z1_21 + Z1eq);
% Z0_N = (Z1eq*ZL21)/(ZL21 + Z1_21 + Z1eq);
% 
% Z23_N = Z1_23 + Z1_N;
% 
% Z21_23 = Z23_N + Z21_N + Z23_N*Z21_N/Z0_N;
% Z0_23 = Z23_N + Z0_N + Z23_N*Z0_N/Z21_N;
% Z0_21 = Z21_N + Z0_N + Z21_N*Z0_N/Z23_N;
% 
% Z23eq = Z0_23*ZL23/(Z0_23+ZL23);
% Z21eq = Z0_21;
%%
%Removing generator at bus 23

Z_23 = ZL23*Zg23/(ZL23+Zg23);
Z1_tr23 = Z_23 + Z1_23;
Z1eq = ZL1 * Z1_tr23/(ZL1 + Z1_tr23);

%
Z21_N = (ZL21*Z1_21)/(ZL21 + Z1_21 + Z1eq);
Z1_N = (Z1eq*Z1_21)/(ZL21 + Z1_21 + Z1eq);
Z0_N = (Z1eq*ZL21)/(ZL21 + Z1_21 + Z1eq);

Z22_N = Z1_22 + Z1_N;


Z21_22 = Z22_N + Z21_N + Z22_N*Z21_N/Z0_N;
Z0_22 = Z22_N + Z0_N + Z22_N*Z0_N/Z21_N;
Z0_21 = Z21_N + Z0_N + Z21_N*Z0_N/Z22_N;

Z22eq = Z0_22*ZL22/(Z0_22+ZL22);
Z21eq = Z0_21;
