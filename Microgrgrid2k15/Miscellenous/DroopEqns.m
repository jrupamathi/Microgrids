syms ISd ISq IFd IRd IRq omega VSd VSq efd P Q 
syms Rs RF Rr Ld Lad LD Lq Laq LQ LF Laf Ldf 
syms Ka Vref Ke Se
% L = [Ld Lad Laf 0 0; Lad LD Ldf 0 0; Laf Ldf LF 0 0; 0 0 0 Lq Laq; 0 0 0 Laq LQ];
L = [Ld 0 Laf;
    0 Lq 0;
    Laf 0 LF];

Vt = sqrt(VSd^2 + VSq^2);
efd = Ka*(Vref-Vt)/(Ke+Se);
%R = diag([Rs;Rs;RF;Rr;Rr]);
R = diag([Rs;Rs;RF]);
%I = [ISd;ISq;IFd;IRd;IRq];
I = [ISd;ISq;IFd];
% V = [VSd; VSq; efd; 0;0];
V = [VSd; VSq; efd];
%  ohm = [0 omega 0 0 0;
%      -omega 0 -omega -omega 0;
%      0 omega 0 0 omega;
%      0 omega 0 0 omega;
%      -omega 0 -omega -omega 0];
  ohm = [0 omega 0; -omega 0 -omega; 0 omega 0];
% P = 1.5*(VSd*ISd + VSq*ISq);
% Q = 1.5*(VSq*ISd - VSd*ISq);
ConvMat = [VSd VSq; -VSq VSd];
Isubs = ConvMat\[P;Q];

eqn = (V - R*I - ohm*L*I);
eqn1 = subs(eqn,[ISd;ISq],[Isubs(1)/1.5;Isubs(2)/1.5]);
%RotorCurr = solve(eqn1(3:5),[IFd;IRd;IRq]);
States = solve(eqn1(1:2),[IFd;omega]);
iF = States.IFd;
omegasubs = States.omega;
%iD = RotorCurr.IRd;
%iQ = RotorCurr.IRq;

%eqn2 = subs(eqn1(1:2),[IFd;IRd;IRq],[iF;iD;iQ])
eqn2 = subs(eqn1(3),[IFd;omega],[iF;omegasubs]);
disp(eqn2==0)
