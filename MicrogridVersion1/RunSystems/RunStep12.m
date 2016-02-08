function RunStep8

clear all
close all

set(0,'defaultlinelinewidth',1.5)


addpath('../Parameters')
            
load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22');

load('L2.mat', 'PL_L2', 'QL_L2');
load('L16.mat', 'PL_L16', 'QL_L16');
load('L17.mat', 'PL_L17', 'QL_L17');
load('L18.mat', 'PL_L18', 'QL_L18');
load('L19.mat', 'PL_L19', 'QL_L19');
load('L14.mat', 'PL_L14', 'QL_L14');
load('L12.mat', 'PL_L12', 'QL_L12');
load('L13.mat', 'PL_L13', 'QL_L13');
load('L15.mat', 'PL_L15', 'QL_L15');
load('L11.mat', 'PL_L11', 'QL_L11');
load('PV21.mat', 'PL_PV21', 'QL_PV21');
load('IM2.mat','LR_IM2','LRR_IM2','LS_IM2','LSS_IM2','M_IM2','RR_IM2','RS_IM2','J_IM2','tauL_IM2','B_IM2');
load('IM14.mat','LR_IM14','LRR_IM14','LS_IM14','LSS_IM14','M_IM14','RR_IM14','RS_IM14','J_IM14','tauL_IM14','B_IM14');
%load('TL_2_23.mat', 'LTL_TL_2_23', 'RTL_TL_2_23','CTL_TL_2_23');
load('TL_1_2.mat', 'LTL_TL_1_2', 'RTL_TL_1_2','CTL_TL_1_2');
load('TL_1_5.mat', 'LTL_TL_1_5', 'RTL_TL_1_5','CTL_TL_1_5');
load('TL_1_14.mat', 'LTL_TL_1_14', 'RTL_TL_1_14','CTL_TL_1_14');
load('TL_1_12.mat', 'LTL_TL_1_12', 'RTL_TL_1_12','CTL_TL_1_12');
load('TL_1_13.mat', 'LTL_TL_1_13', 'RTL_TL_1_13','CTL_TL_1_13');
load('TL_1_11.mat', 'LTL_TL_1_11', 'RTL_TL_1_11','CTL_TL_1_11');
load('TL_1_15.mat', 'LTL_TL_1_15', 'RTL_TL_1_15','CTL_TL_1_15');
load('TL_5_16.mat', 'LTL_TL_5_16', 'RTL_TL_5_16','CTL_TL_5_16');
load('TL_5_17.mat', 'LTL_TL_5_17', 'RTL_TL_5_17','CTL_TL_5_17');
load('TL_5_18.mat', 'LTL_TL_5_18', 'RTL_TL_5_18','CTL_TL_5_18');
load('TL_5_19.mat', 'LTL_TL_5_19', 'RTL_TL_5_19','CTL_TL_5_19');
load('TL_5_21.mat', 'LTL_TL_5_21', 'RTL_TL_5_21','CTL_TL_5_21');

%LTL_TL_2_23=0.1;
%PL_L16=0.0005; QL_L16=0.0002;
%PL_L17=0.0005; QL_L17=0.0002;
%PL_L18=0.0005; QL_L18=0.0002;
%PL_L19=0.0005; QL_L19=0.0002;
%PL_L11=0.0005; QL_L11=0.0002;
%PL_PV21=-0.1875; QL_PV21=-0.05;

x0 = [0.579995
    -0.404142
 -0.000982396
  -0.00523254
     -1.30639
     0.639569
      1.00004
     0.544676
    -0.323042
 -3.43038e-15
   7.1085e-14
     -1.23302
     0.656733
          1.0
      0.33498
    -0.143463
    0.0199489
  -0.00895325
    0.0397475
    0.0293635
  0.000922158
  -0.00139451
     0.159834
    -0.131463
     0.167419
    -0.210419
     0.625656
    -0.357929
    0.0349652
   -0.0226541
    0.0399603
   -0.0226926
    0.0838212
  -0.00525794
    0.0342557
   -0.0102242
     0.988567
  -0.00725062
   0.00907795
      -0.1651
      1.16613
   -0.0922763
     0.071757
    -0.156522
     0.171939
     0.108232
    -0.569711
      1.02307
      4.22431
      2.07617
    0.0850257
    -0.234002
     0.101197
    -0.245333
    0.0531244
    -0.423944
    -0.104327
    0.0563588
     0.997672
      5275.76
    0.0330457
    -0.413893
    -0.105284
    0.0795059
     0.992407
      5273.26
   -0.0764963
     -1.63375
     0.196366
   -0.0193384
     0.497929
    -0.636573
     0.866004
    -0.181492
     0.490238
    -0.371897
      1.71819
    -0.208618
   0.00262535
    -0.140497
      1.71169
     0.024374
    0.0350008
   -0.0126673
     0.998689
  -0.00355947
    0.0400009
   -0.0127059
      0.99868
  -0.00407051
     0.342407
   -0.0676388
      0.45036
    -0.399062
     0.732451
    -0.460896];

% base frequency
wb = 377;
omega0 = 1;


tic
tArray = [4 4.2 5 8];% 8 10 12 14 16 18 20];


Options =  odeset('RelTol',1e-4,'AbsTol',1e-3');

t = [];
x = [];
%for i = 1:numel(tArray)-1
    tspan = [6,6.37];%tArray(i+1)];
    %tauL_IM2 = tauL_IM2Array(1);
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%,Options,tauL_IM2);
   % t = [t tStep'];
   % x = [x xStep'];
   % x0 = x(:,end);
%end
    toc


function [dx] = LLMicrogridDynamics(t,x)%,tauL_IM2)
    t
iSd_G23 = x(1);
iSq_G23 = x(2);
iRd_G23 = x(3);
iRq_G23 = x(4);
iF_G23 = x(5);
delta_G23 = x(6);
omega_G23 = x(7);
iSd_G22 = x(8);
iSq_G22 = x(9);
iRd_G22 = x(10);
iRq_G22 = x(11);
iF_G22 = x(12);
delta_G22 = x(13);
omega_G22 = x(14);
iLd_L2 = x(15);
iLq_L2 = x(16);
iLd_L16 = x(17);
iLq_L16 = x(18);
iLd_L17 = x(19);
iLq_L17 = x(20);
iLd_L18 = x(21);
iLq_L18 = x(22);
iLd_L19 = x(23);
iLq_L19 = x(24);
iLd_L14 = x(25);
iLq_L14 = x(26);
iLd_L15 = x(27);
iLq_L15 = x(28);
iLd_L12 = x(29);
iLq_L12 = x(30);
iLd_L13 = x(31);
iLq_L13 = x(32);
iLd_L11 = x(33);
iLq_L11 = x(34);
iLd_PV21 = x(35);
iLq_PV21 = x(36);
iSd_IM2 = x(37);
iSq_IM2 = x(38);
iRd_IM2 = x(39);
iRq_IM2 = x(40);
omega_IM2 = x(41);
theta_IM2 = x(42);
iSd_IM14 = x(43);
iSq_IM14 = x(44);
iRd_IM14 = x(45);
iRq_IM14 = x(46);
omega_IM14 = x(47);
theta_IM14 = x(48);
vTLLd_TL_5_16 = x(49);
vTLLq_TL_5_16 = x(50);
iTLMd_TL_5_16 = x(51);
iTLMq_TL_5_16 = x(52);
vTLRd_TL_5_16 = x(53);
vTLRq_TL_5_16 = x(54);
iTLMd_TL_5_17 = x(55);
iTLMq_TL_5_17 = x(56);
vTLRd_TL_5_17 = x(57);
vTLRq_TL_5_17 = x(58);
iTLMd_TL_5_18 = x(59);
iTLMq_TL_5_18 = x(60);
vTLRd_TL_5_18 = x(61);
vTLRq_TL_5_18 = x(62);
iTLMd_TL_5_19 = x(63);
iTLMq_TL_5_19 = x(64);
vTLRd_TL_5_19 = x(65);
vTLRq_TL_5_19 = x(66);
vTLRd_TL_5_21 = x(67);
vTLRq_TL_5_21 = x(68);
vTLLd_TL_1_5 = 1;%x(67);
vTLLq_TL_1_5 = 0;%x(68);
iTLMd_TL_1_5 = x(69);
iTLMq_TL_1_5 = x(70);
iTLMd_TL_1_14 = x(71);
iTLMq_TL_1_14 = x(72);
vTLRd_TL_1_14 = x(73);
vTLRq_TL_1_14 = x(74);
iTLMd_TL_1_15 = x(75);
iTLMq_TL_1_15 = x(76);
vTLRd_TL_1_15 = x(77);
vTLRq_TL_1_15 = x(78);
iTLMd_TL_1_2 = x(79);
iTLMq_TL_1_2 = x(80);
vTLRd_TL_1_2 = x(81);
vTLRq_TL_1_2 = x(82);
iTLMd_TL_1_12 = x(83);
iTLMq_TL_1_12 = x(84);
vTLRd_TL_1_12 = x(85);
vTLRq_TL_1_12 = x(86);
iTLMd_TL_1_13 = x(87);
iTLMq_TL_1_13 = x(88);
vTLRd_TL_1_13 = x(89);
vTLRq_TL_1_13 = x(90);
iTLMd_TL_1_11 = x(91);
iTLMq_TL_1_11 = x(92);
vTLRd_TL_1_11 = x(93);
vTLRq_TL_1_11 = x(94);
iTLMd_TL_5_21 = x(95);
iTLMq_TL_5_21 = x(96);

dphidt = 1; 
k=[5.8125   35.5171   -1.1682   -2.5449    1.3147    1.3279   -2.3964
   -3.5568   -9.1728   -3.9072    8.0164   -8.7656   -9.8039    1.4338];
reqd=[0.6192, 1.0, 0.8426, -0.5012, 1.19e-13, -1.484, 9.292e-14]';
Tm_G23=-(k(1,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+1.00;
    vR_G23=-(k(2,:)*([delta_G23;omega_G23;iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23]-reqd))+0.000641;
reqd1 = [ 0.7241, 1.0, 0.8426, -0.5012, 2.558e-16, -1.81, -5.773e-16]';
k1  =[2.3522   33.1838    0.3140   -0.2362    0.5317    0.3897    0.2586
   -1.0142  -10.7170   -0.5415    0.9354   -1.0996   -1.9404    0.0550];

Tm_G22=-(k1(1,:)*([delta_G22;omega_G22;iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22]-reqd1))+1.00;
    vR_G22=-(k1(2,:)*([delta_G22;omega_G22;iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22]-reqd1))+0.0037;

diSd_G23dt = 377*vTLRd_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iRq_G23*((Laq_G23*RR_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (Laq_G23*omega_G23*sin(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iSd_G23*(RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iF_G23*((RF_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Laf_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - 377*iRd_G23*((RR_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LRQ_G23*Lad_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRq_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diSq_G23dt = 377*iSd_G23*(omega_G23 - dphidt + omega_G23*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - omega_G23*cos(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) - 377*iRq_G23*((Laq_G23*RR_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (Laq_G23*omega_G23*cos(delta_G23)*(Ldf_G23^2 - LF_G23*LRD_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*vTLRq_TL_1_2*(cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSq_G23*(omega_G23*sin(2*delta_G23)*((LRQ_G23*LSd_G23)/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (LSq_G23*(Ldf_G23^2 - LF_G23*LRD_G23))/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) - RS_G23*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) - (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + RS_G23*cos(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23))) + 377*iF_G23*((RF_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Laf_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*iRd_G23*((RR_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LRQ_G23*Lad_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) + 377*vTLRd_TL_1_2*sin(2*delta_G23)*(LRQ_G23/(2*Laq_G23^2 - 2*LRQ_G23*LSq_G23) + (Ldf_G23^2 - LF_G23*LRD_G23)/(2*LF_G23*Lad_G23^2 + 2*LRD_G23*Laf_G23^2 + 2*LSd_G23*Ldf_G23^2 - 2*LF_G23*LRD_G23*LSd_G23 - 4*Lad_G23*Laf_G23*Ldf_G23)) + (377*vR_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRd_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(Laf_G23^2 - LF_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LF_G23*Lad_G23 - Laf_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
diRq_G23dt = (377*LSq_G23*RR_G23*iRq_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSq_G23*((Laq_G23*RS_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (LSd_G23*Laq_G23*omega_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laq_G23*vTLRd_TL_1_2*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Laq_G23*vTLRq_TL_1_2*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) - 377*iSd_G23*((Laq_G23*RS_G23*cos(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23) + (LSd_G23*Laq_G23*omega_G23*sin(delta_G23))/(Laq_G23^2 - LRQ_G23*LSq_G23)) - (377*Laf_G23*Laq_G23*iF_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23) - (377*Lad_G23*Laq_G23*iRd_G23*omega_G23)/(Laq_G23^2 - LRQ_G23*LSq_G23);
diF_G23dt = 377*iSq_G23*((RS_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (LSq_G23*omega_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - 377*iSd_G23*((RS_G23*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (LSq_G23*omega_G23*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23)) - (377*vR_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*vTLRq_TL_1_2*cos(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*vTLRd_TL_1_2*sin(delta_G23)*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RF_G23*iF_G23*(Lad_G23^2 - LRD_G23*LSd_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) - (377*RR_G23*iRd_G23*(LSd_G23*Ldf_G23 - Lad_G23*Laf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23) + (377*Laq_G23*iRq_G23*omega_G23*(LRD_G23*Laf_G23 - Lad_G23*Ldf_G23))/(LF_G23*Lad_G23^2 + LRD_G23*Laf_G23^2 + LSd_G23*Ldf_G23^2 - LF_G23*LRD_G23*LSd_G23 - 2*Lad_G23*Laf_G23*Ldf_G23);
ddelta_G23dt = 377*omega_G23 - 377;
domega_G23dt = -(B_G23*omega_G23 - Tm_G23 + iSd_G23*vTLRd_TL_1_2 + iSq_G23*vTLRq_TL_1_2)/(2*H_G23);
diSd_G22dt = 377*vTLLd_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iRq_G22*((Laq_G22*RR_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (Laq_G22*omega_G22*sin(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iSd_G22*(RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iF_G22*((RF_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Laf_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - 377*iRd_G22*((RR_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LRQ_G22*Lad_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLLq_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diSq_G22dt = 377*iSd_G22*(omega_G22 - dphidt + omega_G22*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - omega_G22*cos(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) - 377*iRq_G22*((Laq_G22*RR_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (Laq_G22*omega_G22*cos(delta_G22)*(Ldf_G22^2 - LF_G22*LRD_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*vTLLq_TL_1_5*(cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSq_G22*(omega_G22*sin(2*delta_G22)*((LRQ_G22*LSd_G22)/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (LSq_G22*(Ldf_G22^2 - LF_G22*LRD_G22))/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) - RS_G22*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) - (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + RS_G22*cos(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22))) + 377*iF_G22*((RF_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Laf_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*iRd_G22*((RR_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LRQ_G22*Lad_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) + 377*vTLLd_TL_1_5*sin(2*delta_G22)*(LRQ_G22/(2*Laq_G22^2 - 2*LRQ_G22*LSq_G22) + (Ldf_G22^2 - LF_G22*LRD_G22)/(2*LF_G22*Lad_G22^2 + 2*LRD_G22*Laf_G22^2 + 2*LSd_G22*Ldf_G22^2 - 2*LF_G22*LRD_G22*LSd_G22 - 4*Lad_G22*Laf_G22*Ldf_G22)) + (377*vR_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRd_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(Laf_G22^2 - LF_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LF_G22*Lad_G22 - Laf_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
diRq_G22dt = (377*LSq_G22*RR_G22*iRq_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSq_G22*((Laq_G22*RS_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (LSd_G22*Laq_G22*omega_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laq_G22*vTLLd_TL_1_5*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Laq_G22*vTLLq_TL_1_5*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) - 377*iSd_G22*((Laq_G22*RS_G22*cos(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22) + (LSd_G22*Laq_G22*omega_G22*sin(delta_G22))/(Laq_G22^2 - LRQ_G22*LSq_G22)) - (377*Laf_G22*Laq_G22*iF_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22) - (377*Lad_G22*Laq_G22*iRd_G22*omega_G22)/(Laq_G22^2 - LRQ_G22*LSq_G22);
diF_G22dt = 377*iSq_G22*((RS_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (LSq_G22*omega_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - 377*iSd_G22*((RS_G22*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (LSq_G22*omega_G22*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22)) - (377*vR_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*vTLLq_TL_1_5*cos(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*vTLLd_TL_1_5*sin(delta_G22)*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RF_G22*iF_G22*(Lad_G22^2 - LRD_G22*LSd_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) - (377*RR_G22*iRd_G22*(LSd_G22*Ldf_G22 - Lad_G22*Laf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22) + (377*Laq_G22*iRq_G22*omega_G22*(LRD_G22*Laf_G22 - Lad_G22*Ldf_G22))/(LF_G22*Lad_G22^2 + LRD_G22*Laf_G22^2 + LSd_G22*Ldf_G22^2 - LF_G22*LRD_G22*LSd_G22 - 2*Lad_G22*Laf_G22*Ldf_G22);
ddelta_G22dt = 377*omega_G22 - 377;
domega_G22dt = -(B_G22*omega_G22 - Tm_G22 + iSd_G22*vTLLd_TL_1_5 + iSq_G22*vTLLq_TL_1_5)/(2*H_G22);
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - (PL_L2*iLd_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2)/(PL_L2^2 + QL_L2^2))*(PL_L2^2 + QL_L2^2))/(QL_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2);
diLq_L2dt = (377*(vTLRq_TL_1_2 - (PL_L2*iLq_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2)/(PL_L2^2 + QL_L2^2))*(PL_L2^2 + QL_L2^2))/(QL_L2*abs(vTLRd_TL_1_2 + vTLRq_TL_1_2*1i)^2) - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - (PL_L16*iLd_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2)/(PL_L16^2 + QL_L16^2))*(PL_L16^2 + QL_L16^2))/(QL_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2);
diLq_L16dt = (377*(vTLRq_TL_5_16 - (PL_L16*iLq_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2)/(PL_L16^2 + QL_L16^2))*(PL_L16^2 + QL_L16^2))/(QL_L16*abs(vTLRd_TL_5_16 + vTLRq_TL_5_16*1i)^2) - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_5_17 - (PL_L17*iLd_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2)/(PL_L17^2 + QL_L17^2))*(PL_L17^2 + QL_L17^2))/(QL_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2);
diLq_L17dt = (377*(vTLRq_TL_5_17 - (PL_L17*iLq_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2)/(PL_L17^2 + QL_L17^2))*(PL_L17^2 + QL_L17^2))/(QL_L17*abs(vTLRd_TL_5_17 + vTLRq_TL_5_17*1i)^2) - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_5_18 - (PL_L18*iLd_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2)/(PL_L18^2 + QL_L18^2))*(PL_L18^2 + QL_L18^2))/(QL_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2);
diLq_L18dt = (377*(vTLRq_TL_5_18 - (PL_L18*iLq_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2)/(PL_L18^2 + QL_L18^2))*(PL_L18^2 + QL_L18^2))/(QL_L18*abs(vTLRd_TL_5_18 + vTLRq_TL_5_18*1i)^2) - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_5_19 - (PL_L19*iLd_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2)/(PL_L19^2 + QL_L19^2))*(PL_L19^2 + QL_L19^2))/(QL_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2);
diLq_L19dt = (377*(vTLRq_TL_5_19 - (PL_L19*iLq_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2)/(PL_L19^2 + QL_L19^2))*(PL_L19^2 + QL_L19^2))/(QL_L19*abs(vTLRd_TL_5_19 + vTLRq_TL_5_19*1i)^2) - 377*dphidt*iLd_L19;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_1_14 - (PL_L14*iLd_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2)/(PL_L14^2 + QL_L14^2))*(PL_L14^2 + QL_L14^2))/(QL_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2);
diLq_L14dt = (377*(vTLRq_TL_1_14 - (PL_L14*iLq_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2)/(PL_L14^2 + QL_L14^2))*(PL_L14^2 + QL_L14^2))/(QL_L14*abs(vTLRd_TL_1_14 + vTLRq_TL_1_14*1i)^2) - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_1_15 - (PL_L15*iLd_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2)/(PL_L15^2 + QL_L15^2))*(PL_L15^2 + QL_L15^2))/(QL_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2);
diLq_L15dt = (377*(vTLRq_TL_1_15 - (PL_L15*iLq_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2)/(PL_L15^2 + QL_L15^2))*(PL_L15^2 + QL_L15^2))/(QL_L15*abs(vTLRd_TL_1_15 + vTLRq_TL_1_15*1i)^2) - 377*dphidt*iLd_L15;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_1_12 - (PL_L12*iLd_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2)/(PL_L12^2 + QL_L12^2))*(PL_L12^2 + QL_L12^2))/(QL_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2);
diLq_L12dt = (377*(vTLRq_TL_1_12 - (PL_L12*iLq_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2)/(PL_L12^2 + QL_L12^2))*(PL_L12^2 + QL_L12^2))/(QL_L12*abs(vTLRd_TL_1_12 + vTLRq_TL_1_12*1i)^2) - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_1_13 - (PL_L13*iLd_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2)/(PL_L13^2 + QL_L13^2))*(PL_L13^2 + QL_L13^2))/(QL_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2);
diLq_L13dt = (377*(vTLRq_TL_1_13 - (PL_L13*iLq_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2)/(PL_L13^2 + QL_L13^2))*(PL_L13^2 + QL_L13^2))/(QL_L13*abs(vTLRd_TL_1_13 + vTLRq_TL_1_13*1i)^2) - 377*dphidt*iLd_L13;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_1_11 - (PL_L11*iLd_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2)/(PL_L11^2 + QL_L11^2))*(PL_L11^2 + QL_L11^2))/(QL_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2);
diLq_L11dt = (377*(vTLRq_TL_1_11 - (PL_L11*iLq_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2)/(PL_L11^2 + QL_L11^2))*(PL_L11^2 + QL_L11^2))/(QL_L11*abs(vTLRd_TL_1_11 + vTLRq_TL_1_11*1i)^2) - 377*dphidt*iLd_L11;
diLd_PV21dt = 377*dphidt*iLq_PV21 + (377*(vTLRd_TL_5_21 - (PL_PV21*iLd_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2)/(PL_PV21^2 + QL_PV21^2))*(PL_PV21^2 + QL_PV21^2))/(QL_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2);
diLq_PV21dt = (377*(vTLRq_TL_5_21 - (PL_PV21*iLq_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2)/(PL_PV21^2 + QL_PV21^2))*(PL_PV21^2 + QL_PV21^2))/(QL_PV21*abs(vTLRd_TL_5_21 + vTLRq_TL_5_21*1i)^2) - 377*dphidt*iLd_PV21;
diSd_IM2dt = -(377*(9*M_IM2^3*RR_IM2*iRd_IM2 - 64*LRR_IM2^2*LSS_IM2*vTLRd_TL_1_2 + 32*LRR_IM2^2*LS_IM2*vTLRd_TL_1_2 + 32*LR_IM2^2*LSS_IM2*vTLRd_TL_1_2 - 16*LR_IM2^2*LS_IM2*vTLRd_TL_1_2 + 72*LRR_IM2*M_IM2^2*vTLRd_TL_1_2 + 72*LR_IM2*M_IM2^2*vTLRd_TL_1_2 - 162*M_IM2^4*dphidt*iSq_IM2 + 3*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2) - 6*M_IM2^3*RR_IM2*iRd_IM2*sin(theta_IM2)^2 + 64*LRR_IM2^2*LSS_IM2*RS_IM2*iSd_IM2 - 32*LRR_IM2^2*LS_IM2*RS_IM2*iSd_IM2 - 32*LR_IM2^2*LSS_IM2*RS_IM2*iSd_IM2 + 16*LR_IM2^2*LS_IM2*RS_IM2*iSd_IM2 - 72*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2 - 72*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2 - 48*LRR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2)^2 - 48*LR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2)^2 + 3*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) + 3*M_IM2^3*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 6*M_IM2^3*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 6*M_IM2^3*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 108*M_IM2^4*dphidt*iSq_IM2*sin(theta_IM2)^2 - 32*LRR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2 - pi/3)^2 - 32*LRR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LRR_IM2*M_IM2^2*vTLRd_TL_1_2*sin((2*pi)/3 + theta_IM2)^2 - 32*LR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2 - pi/3)^2 - 32*LR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2*M_IM2^2*vTLRd_TL_1_2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LR_IM2*M_IM2^2*vTLRd_TL_1_2*sin((2*pi)/3 + theta_IM2)^2 - 3*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2 + 72*M_IM2^4*dphidt*iSq_IM2*sin(theta_IM2 - pi/3)^2 + 72*M_IM2^4*dphidt*iSq_IM2*sin(pi/3 + theta_IM2)^2 + 36*M_IM2^4*dphidt*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 36*M_IM2^4*dphidt*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 + 3*M_IM2^4*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 3*M_IM2^4*iSd_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) + 3*M_IM2^4*iSd_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 3*M_IM2^4*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) - 3*M_IM2^4*iSd_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) - 3*M_IM2^4*iSd_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) - 64*LRR_IM2^2*LSS_IM2^2*dphidt*iSq_IM2 + 32*LRR_IM2^2*LS_IM2^2*dphidt*iSq_IM2 + 32*LR_IM2^2*LSS_IM2^2*dphidt*iSq_IM2 - 16*LR_IM2^2*LS_IM2^2*dphidt*iSq_IM2 - 8*M_IM2^4*dphidt*iSq_IM2*sin(2*theta_IM2 - pi/3)^2 - 8*M_IM2^4*dphidt*iSq_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*M_IM2^4*dphidt*iSq_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 + 4*M_IM2^4*dphidt*iSq_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 + 4*M_IM2^4*dphidt*iSq_IM2*sin(2*theta_IM2 - (4*pi)/3)^2 + 4*M_IM2^4*dphidt*iSq_IM2*sin((4*pi)/3 + 2*theta_IM2)^2 - 32*LRR_IM2*LR_IM2*LSS_IM2*vTLRd_TL_1_2 + 16*LRR_IM2*LR_IM2*LS_IM2*vTLRd_TL_1_2 + 32*LRR_IM2*LR_IM2*LSS_IM2*RS_IM2*iSd_IM2 - 16*LRR_IM2*LR_IM2*LS_IM2*RS_IM2*iSd_IM2 - 96*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2 + 48*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2 + 48*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2 - 24*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2 + 48*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2)^2 + 48*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2)^2 + 32*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LRR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 + 32*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2 - pi/3)^2 + 32*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LR_IM2*M_IM2^2*RS_IM2*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 + 3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(theta_IM2)^2 - 32*LRR_IM2*LR_IM2*LSS_IM2^2*dphidt*iSq_IM2 + 16*LRR_IM2*LR_IM2*LS_IM2^2*dphidt*iSq_IM2 - 32*LRR_IM2^2*LSS_IM2*LS_IM2*dphidt*iSq_IM2 + 16*LR_IM2^2*LSS_IM2*LS_IM2*dphidt*iSq_IM2 + 216*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2 + 108*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2 - 96*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2 + 48*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2 + 48*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2 - 24*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2 - 144*LRR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2 + 72*LRR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2 + 72*LR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2 - 36*LR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2 - 3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 3*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(4*theta_IM2 - (2*pi)/3) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((2*pi)/3 + 4*theta_IM2) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((4*pi)/3 + 2*theta_IM2) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(4*theta_IM2 - (4*pi)/3) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((4*pi)/3 + 4*theta_IM2) + 6*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 - 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 2*3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 3*3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) - 3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 3*3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) - 3^(1/2)*M_IM2^4*iSq_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) + 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2 - pi/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - pi/3)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 + 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - pi/3)^2 - 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 - 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2) + 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2) + 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2) - 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2) + 64*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2)^2 - 32*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2)^2 - 32*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2)^2 + 16*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2)^2 + 16*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 + 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 + 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 - 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LR_IM2*LSS_IM2*LS_IM2*dphidt*iSq_IM2 - 48*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2 + 24*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2 - 48*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2)^2 - 48*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2)^2 - 48*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2)^2 - 48*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2)^2 - 32*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) + 16*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) + 16*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) - 8*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) - 64*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 - 16*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(pi/3 + theta_IM2)^2 - 80*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 80*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 64*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - pi/3)^2 - 64*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 64*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - pi/3)^2 - 64*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(pi/3 + theta_IM2)^2 + 16*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 16*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - pi/3)^2 - 16*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(pi/3 + theta_IM2)^2 - 32*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 32*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 + 16*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*LRR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 32*LRR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 32*LRR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 32*LRR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 16*LRR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*LRR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 16*LRR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) - 16*LRR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 16*LR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*LR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 16*LR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) - 16*LR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 8*LR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 8*LR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 8*LR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 32*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 8*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) + 2*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) + 2*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) + 16*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 4*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 32*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 8*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 8*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) + 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2) - 32*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 + 16*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2)^2 - 16*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 8*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 8*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) - 4*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 + 32*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 - 8*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 + 8*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 8*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 4*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 4*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 4*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 16*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 16*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 8*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2))/(162*M_IM2^4 - 72*M_IM2^4*sin(theta_IM2 - pi/3)^2 - 72*M_IM2^4*sin(pi/3 + theta_IM2)^2 - 36*M_IM2^4*sin(theta_IM2 - (2*pi)/3)^2 - 36*M_IM2^4*sin((2*pi)/3 + theta_IM2)^2 - 108*M_IM2^4*sin(theta_IM2)^2 + 64*LRR_IM2^2*LSS_IM2^2 - 32*LRR_IM2^2*LS_IM2^2 - 32*LR_IM2^2*LSS_IM2^2 + 16*LR_IM2^2*LS_IM2^2 + 8*M_IM2^4*sin(2*theta_IM2 - pi/3)^2 + 8*M_IM2^4*sin(pi/3 + 2*theta_IM2)^2 - 4*M_IM2^4*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*M_IM2^4*sin((2*pi)/3 + 2*theta_IM2)^2 - 4*M_IM2^4*sin(2*theta_IM2 - (4*pi)/3)^2 - 4*M_IM2^4*sin((4*pi)/3 + 2*theta_IM2)^2 + 32*LRR_IM2*LR_IM2*LSS_IM2^2 - 16*LRR_IM2*LR_IM2*LS_IM2^2 + 32*LRR_IM2^2*LSS_IM2*LS_IM2 - 16*LR_IM2^2*LSS_IM2*LS_IM2 - 216*LRR_IM2*LSS_IM2*M_IM2^2 - 108*LR_IM2*LS_IM2*M_IM2^2 + 16*LRR_IM2*LR_IM2*LSS_IM2*LS_IM2 + 48*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2)^2 - 32*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 - 32*LRR_IM2*LSS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 + 80*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 + 80*LRR_IM2*LSS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 64*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 64*LRR_IM2*LS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LRR_IM2*LS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 64*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 64*LR_IM2*LSS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LR_IM2*LSS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 16*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 16*LR_IM2*LS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 + 32*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 + 32*LR_IM2*LS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2);
diSq_IM2dt = (377*(64*LRR_IM2^2*LSS_IM2*vTLRq_TL_1_2 - 9*M_IM2^3*RR_IM2*iRq_IM2 - 32*LRR_IM2^2*LS_IM2*vTLRq_TL_1_2 - 32*LR_IM2^2*LSS_IM2*vTLRq_TL_1_2 + 16*LR_IM2^2*LS_IM2*vTLRq_TL_1_2 - 72*LRR_IM2*M_IM2^2*vTLRq_TL_1_2 - 72*LR_IM2*M_IM2^2*vTLRq_TL_1_2 - 162*M_IM2^4*dphidt*iSd_IM2 + 3*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2) + 6*M_IM2^3*RR_IM2*iRq_IM2*sin(theta_IM2)^2 - 64*LRR_IM2^2*LSS_IM2*RS_IM2*iSq_IM2 + 32*LRR_IM2^2*LS_IM2*RS_IM2*iSq_IM2 + 32*LR_IM2^2*LSS_IM2*RS_IM2*iSq_IM2 - 16*LR_IM2^2*LS_IM2*RS_IM2*iSq_IM2 + 72*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2 + 72*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2 + 48*LRR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2)^2 + 48*LR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2)^2 + 3*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 3*M_IM2^3*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 6*M_IM2^3*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 + 6*M_IM2^3*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 108*M_IM2^4*dphidt*iSd_IM2*sin(theta_IM2)^2 + 32*LRR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LRR_IM2*M_IM2^2*vTLRq_TL_1_2*sin((2*pi)/3 + theta_IM2)^2 + 32*LR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2 - pi/3)^2 + 32*LR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(pi/3 + theta_IM2)^2 + 16*LR_IM2*M_IM2^2*vTLRq_TL_1_2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LR_IM2*M_IM2^2*vTLRq_TL_1_2*sin((2*pi)/3 + theta_IM2)^2 - 3*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2 + 72*M_IM2^4*dphidt*iSd_IM2*sin(theta_IM2 - pi/3)^2 + 72*M_IM2^4*dphidt*iSd_IM2*sin(pi/3 + theta_IM2)^2 + 36*M_IM2^4*dphidt*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 36*M_IM2^4*dphidt*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 3*M_IM2^4*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 3*M_IM2^4*iSq_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) - 3*M_IM2^4*iSq_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) + 3*M_IM2^4*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 3*M_IM2^4*iSq_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) + 3*M_IM2^4*iSq_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) - 64*LRR_IM2^2*LSS_IM2^2*dphidt*iSd_IM2 + 32*LRR_IM2^2*LS_IM2^2*dphidt*iSd_IM2 + 32*LR_IM2^2*LSS_IM2^2*dphidt*iSd_IM2 - 16*LR_IM2^2*LS_IM2^2*dphidt*iSd_IM2 - 8*M_IM2^4*dphidt*iSd_IM2*sin(2*theta_IM2 - pi/3)^2 - 8*M_IM2^4*dphidt*iSd_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*M_IM2^4*dphidt*iSd_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 + 4*M_IM2^4*dphidt*iSd_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 + 4*M_IM2^4*dphidt*iSd_IM2*sin(2*theta_IM2 - (4*pi)/3)^2 + 4*M_IM2^4*dphidt*iSd_IM2*sin((4*pi)/3 + 2*theta_IM2)^2 + 32*LRR_IM2*LR_IM2*LSS_IM2*vTLRq_TL_1_2 - 16*LRR_IM2*LR_IM2*LS_IM2*vTLRq_TL_1_2 - 32*LRR_IM2*LR_IM2*LSS_IM2*RS_IM2*iSq_IM2 + 16*LRR_IM2*LR_IM2*LS_IM2*RS_IM2*iSq_IM2 + 96*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2 - 48*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2 - 48*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2 + 24*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2 - 48*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2)^2 - 48*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2)^2 - 32*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2 - pi/3)^2 - 32*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LRR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 32*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2 - pi/3)^2 - 32*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LR_IM2*M_IM2^2*RS_IM2*iSq_IM2*sin((2*pi)/3 + theta_IM2)^2 - 3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(theta_IM2)^2 - 32*LRR_IM2*LR_IM2*LSS_IM2^2*dphidt*iSd_IM2 + 16*LRR_IM2*LR_IM2*LS_IM2^2*dphidt*iSd_IM2 - 32*LRR_IM2^2*LSS_IM2*LS_IM2*dphidt*iSd_IM2 + 16*LR_IM2^2*LSS_IM2*LS_IM2*dphidt*iSd_IM2 + 216*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2 + 108*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2 - 96*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2 + 48*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2 + 48*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2 - 24*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2 - 144*LRR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2 + 72*LRR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2 + 72*LR_IM2*LSS_IM2*M_IM2^2*iSd_IM2*omega_IM2 - 36*LR_IM2*LS_IM2*M_IM2^2*iSd_IM2*omega_IM2 + 3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) - 3*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(4*theta_IM2 - (2*pi)/3) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((2*pi)/3 + 4*theta_IM2) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (4*pi)/3) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((4*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin(4*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*M_IM2^3*RR_IM2*iRq_IM2*sin((4*pi)/3 + 4*theta_IM2) + 6*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 2*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 2*3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 3*3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) - 3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 3*3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) - 3^(1/2)*M_IM2^4*iSd_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) + 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2 - pi/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(pi/3 + 2*theta_IM2)^2 + 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM2^3*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - pi/3)^2 + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(pi/3 + 2*theta_IM2)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 - 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - pi/3)^2 + 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(pi/3 + 2*theta_IM2)^2 - 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3)^2 + 4*3^(1/2)*LR_IM2*M_IM2^3*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2)^2 - 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2) + 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2) + 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2) - 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2) - 64*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2)^2 + 32*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2)^2 + 32*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2)^2 - 16*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2)^2 + 16*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 16*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin((2*pi)/3 + 2*theta_IM2) + 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 - 16*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 - 16*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 + 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(theta_IM2 - pi/3)^2 + 8*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LR_IM2*LSS_IM2*LS_IM2*dphidt*iSd_IM2 - 48*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2 + 24*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2 - 48*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2)^2 - 48*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2)^2 - 48*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2)^2 - 48*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2)^2 + 32*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) - 16*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) - 16*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) + 8*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) - 64*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 - 16*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 + 32*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(pi/3 + theta_IM2)^2 - 80*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 80*LRR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 64*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - pi/3)^2 - 64*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LRR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 64*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - pi/3)^2 - 64*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(pi/3 + theta_IM2)^2 + 16*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 + 16*LR_IM2*LSS_IM2*M_IM2^2*dphidt*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 16*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - pi/3)^2 - 16*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(pi/3 + theta_IM2)^2 - 32*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin(theta_IM2 - (2*pi)/3)^2 - 32*LR_IM2*LS_IM2*M_IM2^2*dphidt*iSd_IM2*sin((2*pi)/3 + theta_IM2)^2 - 16*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 8*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 8*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 4*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 4*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 32*LRR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 32*LRR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*LRR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) - 32*LRR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 16*LRR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*LRR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 16*LRR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 16*LRR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 16*LR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*LR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 16*LR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 16*LR_IM2*LSS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 8*LR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*LR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*LR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) - 8*LR_IM2*LS_IM2*M_IM2^2*iSq_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) + 32*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 32*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 8*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) + 2*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 4*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*LRR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(4*theta_IM2 - (2*pi)/3) + 2*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((2*pi)/3 + 4*theta_IM2) - 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (4*pi)/3) + 4*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((4*pi)/3 + 2*theta_IM2) - 2*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin(4*theta_IM2 - (4*pi)/3) + 2*3^(1/2)*LR_IM2*M_IM2^3*iRd_IM2*omega_IM2*sin((4*pi)/3 + 4*theta_IM2) + 16*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 4*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 32*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 32*3^(1/2)*LRR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 16*3^(1/2)*LRR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 16*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 16*3^(1/2)*LR_IM2^2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 8*3^(1/2)*LR_IM2^2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) - 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2) - 32*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 + 16*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2)^2 + 16*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) - 16*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 8*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) + 8*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin(2*theta_IM2 - (2*pi)/3) - 4*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRq_IM2*sin((2*pi)/3 + 2*theta_IM2) - 32*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 + 32*3^(1/2)*LRR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LRR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 + 16*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LR_IM2*LSS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 - 8*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(theta_IM2 - pi/3)^2 + 8*3^(1/2)*LR_IM2*LS_IM2*M_IM2*RR_IM2*iRd_IM2*sin(pi/3 + theta_IM2)^2 - 8*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 4*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 16*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 8*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 + 8*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) - 8*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) - 4*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin(2*theta_IM2 - (2*pi)/3) + 4*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRd_IM2*omega_IM2*sin((2*pi)/3 + 2*theta_IM2) + 16*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 - 16*3^(1/2)*LRR_IM2*LR_IM2*LSS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2 - 8*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(theta_IM2 - pi/3)^2 + 8*3^(1/2)*LRR_IM2*LR_IM2*LS_IM2*M_IM2*iRq_IM2*omega_IM2*sin(pi/3 + theta_IM2)^2))/(162*M_IM2^4 - 72*M_IM2^4*sin(theta_IM2 - pi/3)^2 - 72*M_IM2^4*sin(pi/3 + theta_IM2)^2 - 36*M_IM2^4*sin(theta_IM2 - (2*pi)/3)^2 - 36*M_IM2^4*sin((2*pi)/3 + theta_IM2)^2 - 108*M_IM2^4*sin(theta_IM2)^2 + 64*LRR_IM2^2*LSS_IM2^2 - 32*LRR_IM2^2*LS_IM2^2 - 32*LR_IM2^2*LSS_IM2^2 + 16*LR_IM2^2*LS_IM2^2 + 8*M_IM2^4*sin(2*theta_IM2 - pi/3)^2 + 8*M_IM2^4*sin(pi/3 + 2*theta_IM2)^2 - 4*M_IM2^4*sin(2*theta_IM2 - (2*pi)/3)^2 - 4*M_IM2^4*sin((2*pi)/3 + 2*theta_IM2)^2 - 4*M_IM2^4*sin(2*theta_IM2 - (4*pi)/3)^2 - 4*M_IM2^4*sin((4*pi)/3 + 2*theta_IM2)^2 + 32*LRR_IM2*LR_IM2*LSS_IM2^2 - 16*LRR_IM2*LR_IM2*LS_IM2^2 + 32*LRR_IM2^2*LSS_IM2*LS_IM2 - 16*LR_IM2^2*LSS_IM2*LS_IM2 - 216*LRR_IM2*LSS_IM2*M_IM2^2 - 108*LR_IM2*LS_IM2*M_IM2^2 + 16*LRR_IM2*LR_IM2*LSS_IM2*LS_IM2 + 48*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2)^2 + 48*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2)^2 - 32*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 - 32*LRR_IM2*LSS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 + 80*LRR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 + 80*LRR_IM2*LSS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 64*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 64*LRR_IM2*LS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 - 16*LRR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LRR_IM2*LS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 64*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 64*LR_IM2*LSS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 - 16*LR_IM2*LSS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 - 16*LR_IM2*LSS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2 + 16*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - pi/3)^2 + 16*LR_IM2*LS_IM2*M_IM2^2*sin(pi/3 + theta_IM2)^2 + 32*LR_IM2*LS_IM2*M_IM2^2*sin(theta_IM2 - (2*pi)/3)^2 + 32*LR_IM2*LS_IM2*M_IM2^2*sin((2*pi)/3 + theta_IM2)^2);
diRd_IM2dt = 377*dphidt*iRq_IM2 - (377*(M_IM2*(6*vTLRd_TL_1_2 - 6*RS_IM2*iSd_IM2 + 6*LSS_IM2*iSq_IM2*omega_IM2 + 6*LS_IM2*iSq_IM2*omega_IM2) + 4*LSS_IM2*RR_IM2*iRd_IM2 + 4*LS_IM2*RR_IM2*iRd_IM2 + 4*LRR_IM2*LSS_IM2*iRq_IM2*omega_IM2 + 4*LRR_IM2*LS_IM2*iRq_IM2*omega_IM2 + 4*LR_IM2*LSS_IM2*iRq_IM2*omega_IM2 + 4*LR_IM2*LS_IM2*iRq_IM2*omega_IM2))/(4*LRR_IM2*LSS_IM2 - 9*M_IM2^2 + 4*LRR_IM2*LS_IM2 + 4*LR_IM2*LSS_IM2 + 4*LR_IM2*LS_IM2);
diRq_IM2dt = (377*(M_IM2*(6*RS_IM2*iSq_IM2 - 6*vTLRq_TL_1_2 + 6*LSS_IM2*iSd_IM2*omega_IM2 + 6*LS_IM2*iSd_IM2*omega_IM2) - 4*LSS_IM2*RR_IM2*iRq_IM2 - 4*LS_IM2*RR_IM2*iRq_IM2 + 4*LRR_IM2*LSS_IM2*iRd_IM2*omega_IM2 + 4*LRR_IM2*LS_IM2*iRd_IM2*omega_IM2 + 4*LR_IM2*LSS_IM2*iRd_IM2*omega_IM2 + 4*LR_IM2*LS_IM2*iRd_IM2*omega_IM2))/(4*LRR_IM2*LSS_IM2 - 9*M_IM2^2 + 4*LRR_IM2*LS_IM2 + 4*LR_IM2*LSS_IM2 + 4*LR_IM2*LS_IM2) - 377*dphidt*iRd_IM2;
domega_IM2dt = -(377*(tauL_IM2 + B_IM2*omega_IM2 - (3*M_IM2*iRd_IM2*iSq_IM2)/2 + (3*M_IM2*iRq_IM2*iSd_IM2)/2))/J_IM2;
dtheta_IM2dt = 377*omega_IM2;
diSd_IM14dt = -(377*(9*M_IM14^3*RR_IM14*iRd_IM14 - 64*LRR_IM14^2*LSS_IM14*vTLRd_TL_1_14 + 32*LRR_IM14^2*LS_IM14*vTLRd_TL_1_14 + 32*LR_IM14^2*LSS_IM14*vTLRd_TL_1_14 - 16*LR_IM14^2*LS_IM14*vTLRd_TL_1_14 + 72*LRR_IM14*M_IM14^2*vTLRd_TL_1_14 + 72*LR_IM14*M_IM14^2*vTLRd_TL_1_14 - 162*M_IM14^4*dphidt*iSq_IM14 + 3*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14) - 6*M_IM14^3*RR_IM14*iRd_IM14*sin(theta_IM14)^2 + 64*LRR_IM14^2*LSS_IM14*RS_IM14*iSd_IM14 - 32*LRR_IM14^2*LS_IM14*RS_IM14*iSd_IM14 - 32*LR_IM14^2*LSS_IM14*RS_IM14*iSd_IM14 + 16*LR_IM14^2*LS_IM14*RS_IM14*iSd_IM14 - 72*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14 - 72*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14 - 48*LRR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14)^2 - 48*LR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14)^2 + 3*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) + 3*M_IM14^3*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 6*M_IM14^3*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 6*M_IM14^3*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 108*M_IM14^4*dphidt*iSq_IM14*sin(theta_IM14)^2 - 32*LRR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14 - pi/3)^2 - 32*LRR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14 - (2*pi)/3)^2 - 16*LRR_IM14*M_IM14^2*vTLRd_TL_1_14*sin((2*pi)/3 + theta_IM14)^2 - 32*LR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14 - pi/3)^2 - 32*LR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14*M_IM14^2*vTLRd_TL_1_14*sin(theta_IM14 - (2*pi)/3)^2 - 16*LR_IM14*M_IM14^2*vTLRd_TL_1_14*sin((2*pi)/3 + theta_IM14)^2 - 3*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14 + 72*M_IM14^4*dphidt*iSq_IM14*sin(theta_IM14 - pi/3)^2 + 72*M_IM14^4*dphidt*iSq_IM14*sin(pi/3 + theta_IM14)^2 + 36*M_IM14^4*dphidt*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 36*M_IM14^4*dphidt*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 + 3*M_IM14^4*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 3*M_IM14^4*iSd_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) + 3*M_IM14^4*iSd_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 3*M_IM14^4*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) - 3*M_IM14^4*iSd_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) - 3*M_IM14^4*iSd_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) - 64*LRR_IM14^2*LSS_IM14^2*dphidt*iSq_IM14 + 32*LRR_IM14^2*LS_IM14^2*dphidt*iSq_IM14 + 32*LR_IM14^2*LSS_IM14^2*dphidt*iSq_IM14 - 16*LR_IM14^2*LS_IM14^2*dphidt*iSq_IM14 - 8*M_IM14^4*dphidt*iSq_IM14*sin(2*theta_IM14 - pi/3)^2 - 8*M_IM14^4*dphidt*iSq_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*M_IM14^4*dphidt*iSq_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 + 4*M_IM14^4*dphidt*iSq_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 + 4*M_IM14^4*dphidt*iSq_IM14*sin(2*theta_IM14 - (4*pi)/3)^2 + 4*M_IM14^4*dphidt*iSq_IM14*sin((4*pi)/3 + 2*theta_IM14)^2 - 32*LRR_IM14*LR_IM14*LSS_IM14*vTLRd_TL_1_14 + 16*LRR_IM14*LR_IM14*LS_IM14*vTLRd_TL_1_14 + 32*LRR_IM14*LR_IM14*LSS_IM14*RS_IM14*iSd_IM14 - 16*LRR_IM14*LR_IM14*LS_IM14*RS_IM14*iSd_IM14 - 96*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14 + 48*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14 + 48*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14 - 24*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14 + 48*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14)^2 + 48*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14)^2 + 32*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LRR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 + 32*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14 - pi/3)^2 + 32*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LR_IM14*M_IM14^2*RS_IM14*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 + 3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(theta_IM14)^2 - 32*LRR_IM14*LR_IM14*LSS_IM14^2*dphidt*iSq_IM14 + 16*LRR_IM14*LR_IM14*LS_IM14^2*dphidt*iSq_IM14 - 32*LRR_IM14^2*LSS_IM14*LS_IM14*dphidt*iSq_IM14 + 16*LR_IM14^2*LSS_IM14*LS_IM14*dphidt*iSq_IM14 + 216*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14 + 108*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14 - 96*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14 + 48*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14 + 48*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14 - 24*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14 - 144*LRR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14 + 72*LRR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14 + 72*LR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14 - 36*LR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14 - 3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 3*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(4*theta_IM14 - (2*pi)/3) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((2*pi)/3 + 4*theta_IM14) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((4*pi)/3 + 2*theta_IM14) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(4*theta_IM14 - (4*pi)/3) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((4*pi)/3 + 4*theta_IM14) + 6*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 - 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 2*3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 3*3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) - 3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 3*3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) - 3^(1/2)*M_IM14^4*iSq_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) + 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14 - pi/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - pi/3)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 + 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - pi/3)^2 - 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 - 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14) + 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14) + 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14) - 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14) + 64*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14)^2 - 32*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14)^2 - 32*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14)^2 + 16*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14)^2 + 16*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 + 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 + 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 - 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LR_IM14*LSS_IM14*LS_IM14*dphidt*iSq_IM14 - 48*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14 + 24*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14 - 48*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14)^2 - 48*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14)^2 - 48*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14)^2 - 48*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14)^2 - 32*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) + 16*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) + 16*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) - 8*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) - 64*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 - 16*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(pi/3 + theta_IM14)^2 - 80*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 80*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 64*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - pi/3)^2 - 64*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 64*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - pi/3)^2 - 64*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(pi/3 + theta_IM14)^2 + 16*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 16*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - pi/3)^2 - 16*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(pi/3 + theta_IM14)^2 - 32*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 32*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 + 16*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*LRR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 32*LRR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 32*LRR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 32*LRR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 16*LRR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*LRR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 16*LRR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) - 16*LRR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 16*LR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*LR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 16*LR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) - 16*LR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 8*LR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 8*LR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 8*LR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 32*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 8*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) + 2*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) + 2*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) + 16*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 4*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 32*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 8*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 8*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) + 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14) - 32*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 + 16*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14)^2 - 16*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 8*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 8*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) - 4*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 + 32*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 - 8*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 + 8*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 8*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 4*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 4*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 4*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 16*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 16*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 8*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2))/(162*M_IM14^4 - 72*M_IM14^4*sin(theta_IM14 - pi/3)^2 - 72*M_IM14^4*sin(pi/3 + theta_IM14)^2 - 36*M_IM14^4*sin(theta_IM14 - (2*pi)/3)^2 - 36*M_IM14^4*sin((2*pi)/3 + theta_IM14)^2 - 108*M_IM14^4*sin(theta_IM14)^2 + 64*LRR_IM14^2*LSS_IM14^2 - 32*LRR_IM14^2*LS_IM14^2 - 32*LR_IM14^2*LSS_IM14^2 + 16*LR_IM14^2*LS_IM14^2 + 8*M_IM14^4*sin(2*theta_IM14 - pi/3)^2 + 8*M_IM14^4*sin(pi/3 + 2*theta_IM14)^2 - 4*M_IM14^4*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*M_IM14^4*sin((2*pi)/3 + 2*theta_IM14)^2 - 4*M_IM14^4*sin(2*theta_IM14 - (4*pi)/3)^2 - 4*M_IM14^4*sin((4*pi)/3 + 2*theta_IM14)^2 + 32*LRR_IM14*LR_IM14*LSS_IM14^2 - 16*LRR_IM14*LR_IM14*LS_IM14^2 + 32*LRR_IM14^2*LSS_IM14*LS_IM14 - 16*LR_IM14^2*LSS_IM14*LS_IM14 - 216*LRR_IM14*LSS_IM14*M_IM14^2 - 108*LR_IM14*LS_IM14*M_IM14^2 + 16*LRR_IM14*LR_IM14*LSS_IM14*LS_IM14 + 48*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14)^2 - 32*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 - 32*LRR_IM14*LSS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 + 80*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 + 80*LRR_IM14*LSS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 64*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 64*LRR_IM14*LS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 - 16*LRR_IM14*LS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 64*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 64*LR_IM14*LSS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 - 16*LR_IM14*LSS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 16*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 16*LR_IM14*LS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 + 32*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 + 32*LR_IM14*LS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2);
diSq_IM14dt = (377*(64*LRR_IM14^2*LSS_IM14*vTLRq_TL_1_14 - 9*M_IM14^3*RR_IM14*iRq_IM14 - 32*LRR_IM14^2*LS_IM14*vTLRq_TL_1_14 - 32*LR_IM14^2*LSS_IM14*vTLRq_TL_1_14 + 16*LR_IM14^2*LS_IM14*vTLRq_TL_1_14 - 72*LRR_IM14*M_IM14^2*vTLRq_TL_1_14 - 72*LR_IM14*M_IM14^2*vTLRq_TL_1_14 - 162*M_IM14^4*dphidt*iSd_IM14 + 3*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14) + 6*M_IM14^3*RR_IM14*iRq_IM14*sin(theta_IM14)^2 - 64*LRR_IM14^2*LSS_IM14*RS_IM14*iSq_IM14 + 32*LRR_IM14^2*LS_IM14*RS_IM14*iSq_IM14 + 32*LR_IM14^2*LSS_IM14*RS_IM14*iSq_IM14 - 16*LR_IM14^2*LS_IM14*RS_IM14*iSq_IM14 + 72*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14 + 72*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14 + 48*LRR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14)^2 + 48*LR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14)^2 + 3*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 3*M_IM14^3*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 6*M_IM14^3*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 + 6*M_IM14^3*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 108*M_IM14^4*dphidt*iSd_IM14*sin(theta_IM14)^2 + 32*LRR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LRR_IM14*M_IM14^2*vTLRq_TL_1_14*sin((2*pi)/3 + theta_IM14)^2 + 32*LR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14 - pi/3)^2 + 32*LR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(pi/3 + theta_IM14)^2 + 16*LR_IM14*M_IM14^2*vTLRq_TL_1_14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LR_IM14*M_IM14^2*vTLRq_TL_1_14*sin((2*pi)/3 + theta_IM14)^2 - 3*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14 + 72*M_IM14^4*dphidt*iSd_IM14*sin(theta_IM14 - pi/3)^2 + 72*M_IM14^4*dphidt*iSd_IM14*sin(pi/3 + theta_IM14)^2 + 36*M_IM14^4*dphidt*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 36*M_IM14^4*dphidt*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 3*M_IM14^4*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 3*M_IM14^4*iSq_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) - 3*M_IM14^4*iSq_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) + 3*M_IM14^4*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 3*M_IM14^4*iSq_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) + 3*M_IM14^4*iSq_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) - 64*LRR_IM14^2*LSS_IM14^2*dphidt*iSd_IM14 + 32*LRR_IM14^2*LS_IM14^2*dphidt*iSd_IM14 + 32*LR_IM14^2*LSS_IM14^2*dphidt*iSd_IM14 - 16*LR_IM14^2*LS_IM14^2*dphidt*iSd_IM14 - 8*M_IM14^4*dphidt*iSd_IM14*sin(2*theta_IM14 - pi/3)^2 - 8*M_IM14^4*dphidt*iSd_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*M_IM14^4*dphidt*iSd_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 + 4*M_IM14^4*dphidt*iSd_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 + 4*M_IM14^4*dphidt*iSd_IM14*sin(2*theta_IM14 - (4*pi)/3)^2 + 4*M_IM14^4*dphidt*iSd_IM14*sin((4*pi)/3 + 2*theta_IM14)^2 + 32*LRR_IM14*LR_IM14*LSS_IM14*vTLRq_TL_1_14 - 16*LRR_IM14*LR_IM14*LS_IM14*vTLRq_TL_1_14 - 32*LRR_IM14*LR_IM14*LSS_IM14*RS_IM14*iSq_IM14 + 16*LRR_IM14*LR_IM14*LS_IM14*RS_IM14*iSq_IM14 + 96*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14 - 48*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14 - 48*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14 + 24*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14 - 48*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14)^2 - 48*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14)^2 - 32*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14 - pi/3)^2 - 32*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 16*LRR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 32*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14 - pi/3)^2 - 32*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 16*LR_IM14*M_IM14^2*RS_IM14*iSq_IM14*sin((2*pi)/3 + theta_IM14)^2 - 3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(theta_IM14)^2 - 32*LRR_IM14*LR_IM14*LSS_IM14^2*dphidt*iSd_IM14 + 16*LRR_IM14*LR_IM14*LS_IM14^2*dphidt*iSd_IM14 - 32*LRR_IM14^2*LSS_IM14*LS_IM14*dphidt*iSd_IM14 + 16*LR_IM14^2*LSS_IM14*LS_IM14*dphidt*iSd_IM14 + 216*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14 + 108*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14 - 96*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14 + 48*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14 + 48*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14 - 24*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14 - 144*LRR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14 + 72*LRR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14 + 72*LR_IM14*LSS_IM14*M_IM14^2*iSd_IM14*omega_IM14 - 36*LR_IM14*LS_IM14*M_IM14^2*iSd_IM14*omega_IM14 + 3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) - 3*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(4*theta_IM14 - (2*pi)/3) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((2*pi)/3 + 4*theta_IM14) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (4*pi)/3) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((4*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin(4*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*M_IM14^3*RR_IM14*iRq_IM14*sin((4*pi)/3 + 4*theta_IM14) + 6*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 2*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 2*3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 3*3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) - 3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 3*3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) - 3^(1/2)*M_IM14^4*iSd_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) + 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14 - pi/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(pi/3 + 2*theta_IM14)^2 + 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*3^(1/2)*M_IM14^3*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - pi/3)^2 + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(pi/3 + 2*theta_IM14)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 - 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - pi/3)^2 + 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(pi/3 + 2*theta_IM14)^2 - 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3)^2 + 4*3^(1/2)*LR_IM14*M_IM14^3*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14)^2 - 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14) + 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14) + 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14) - 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14) - 64*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14)^2 + 32*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14)^2 + 32*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14)^2 - 16*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14)^2 + 16*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 16*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin((2*pi)/3 + 2*theta_IM14) + 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 - 16*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 - 16*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 + 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(theta_IM14 - pi/3)^2 + 8*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LR_IM14*LSS_IM14*LS_IM14*dphidt*iSd_IM14 - 48*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14 + 24*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14 - 48*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14)^2 - 48*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14)^2 - 48*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14)^2 - 48*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14)^2 + 32*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) - 16*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) - 16*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) + 8*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) - 64*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 - 16*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 + 32*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(pi/3 + theta_IM14)^2 - 80*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 80*LRR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 64*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - pi/3)^2 - 64*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LRR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 64*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - pi/3)^2 - 64*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(pi/3 + theta_IM14)^2 + 16*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 + 16*LR_IM14*LSS_IM14*M_IM14^2*dphidt*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 16*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - pi/3)^2 - 16*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(pi/3 + theta_IM14)^2 - 32*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin(theta_IM14 - (2*pi)/3)^2 - 32*LR_IM14*LS_IM14*M_IM14^2*dphidt*iSd_IM14*sin((2*pi)/3 + theta_IM14)^2 - 16*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 8*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 8*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 4*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 4*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 32*LRR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 32*LRR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*LRR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) - 32*LRR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 16*LRR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*LRR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 16*LRR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 16*LRR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 16*LR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*LR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 16*LR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 16*LR_IM14*LSS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 8*LR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*LR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*LR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) - 8*LR_IM14*LS_IM14*M_IM14^2*iSq_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) + 32*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 32*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 8*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) + 2*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 4*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*LRR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(4*theta_IM14 - (2*pi)/3) + 2*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((2*pi)/3 + 4*theta_IM14) - 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (4*pi)/3) + 4*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((4*pi)/3 + 2*theta_IM14) - 2*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin(4*theta_IM14 - (4*pi)/3) + 2*3^(1/2)*LR_IM14*M_IM14^3*iRd_IM14*omega_IM14*sin((4*pi)/3 + 4*theta_IM14) + 16*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 4*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 32*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 32*3^(1/2)*LRR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 16*3^(1/2)*LRR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 16*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 16*3^(1/2)*LR_IM14^2*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 8*3^(1/2)*LR_IM14^2*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) - 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14) - 32*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 + 16*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14)^2 + 16*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) - 16*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 8*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) + 8*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin(2*theta_IM14 - (2*pi)/3) - 4*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRq_IM14*sin((2*pi)/3 + 2*theta_IM14) - 32*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 + 32*3^(1/2)*LRR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LRR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 + 16*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LR_IM14*LSS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 - 8*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(theta_IM14 - pi/3)^2 + 8*3^(1/2)*LR_IM14*LS_IM14*M_IM14*RR_IM14*iRd_IM14*sin(pi/3 + theta_IM14)^2 - 8*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 4*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 16*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 8*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 + 8*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) - 8*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) - 4*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin(2*theta_IM14 - (2*pi)/3) + 4*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRd_IM14*omega_IM14*sin((2*pi)/3 + 2*theta_IM14) + 16*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 - 16*3^(1/2)*LRR_IM14*LR_IM14*LSS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2 - 8*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(theta_IM14 - pi/3)^2 + 8*3^(1/2)*LRR_IM14*LR_IM14*LS_IM14*M_IM14*iRq_IM14*omega_IM14*sin(pi/3 + theta_IM14)^2))/(162*M_IM14^4 - 72*M_IM14^4*sin(theta_IM14 - pi/3)^2 - 72*M_IM14^4*sin(pi/3 + theta_IM14)^2 - 36*M_IM14^4*sin(theta_IM14 - (2*pi)/3)^2 - 36*M_IM14^4*sin((2*pi)/3 + theta_IM14)^2 - 108*M_IM14^4*sin(theta_IM14)^2 + 64*LRR_IM14^2*LSS_IM14^2 - 32*LRR_IM14^2*LS_IM14^2 - 32*LR_IM14^2*LSS_IM14^2 + 16*LR_IM14^2*LS_IM14^2 + 8*M_IM14^4*sin(2*theta_IM14 - pi/3)^2 + 8*M_IM14^4*sin(pi/3 + 2*theta_IM14)^2 - 4*M_IM14^4*sin(2*theta_IM14 - (2*pi)/3)^2 - 4*M_IM14^4*sin((2*pi)/3 + 2*theta_IM14)^2 - 4*M_IM14^4*sin(2*theta_IM14 - (4*pi)/3)^2 - 4*M_IM14^4*sin((4*pi)/3 + 2*theta_IM14)^2 + 32*LRR_IM14*LR_IM14*LSS_IM14^2 - 16*LRR_IM14*LR_IM14*LS_IM14^2 + 32*LRR_IM14^2*LSS_IM14*LS_IM14 - 16*LR_IM14^2*LSS_IM14*LS_IM14 - 216*LRR_IM14*LSS_IM14*M_IM14^2 - 108*LR_IM14*LS_IM14*M_IM14^2 + 16*LRR_IM14*LR_IM14*LSS_IM14*LS_IM14 + 48*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14)^2 + 48*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14)^2 - 32*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 - 32*LRR_IM14*LSS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 + 80*LRR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 + 80*LRR_IM14*LSS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 64*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 64*LRR_IM14*LS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 - 16*LRR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 - 16*LRR_IM14*LS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 64*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 64*LR_IM14*LSS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 - 16*LR_IM14*LSS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 - 16*LR_IM14*LSS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2 + 16*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - pi/3)^2 + 16*LR_IM14*LS_IM14*M_IM14^2*sin(pi/3 + theta_IM14)^2 + 32*LR_IM14*LS_IM14*M_IM14^2*sin(theta_IM14 - (2*pi)/3)^2 + 32*LR_IM14*LS_IM14*M_IM14^2*sin((2*pi)/3 + theta_IM14)^2);
diRd_IM14dt = 377*dphidt*iRq_IM14 - (377*(M_IM14*(6*vTLRd_TL_1_14 - 6*RS_IM14*iSd_IM14 + 6*LSS_IM14*iSq_IM14*omega_IM14 + 6*LS_IM14*iSq_IM14*omega_IM14) + 4*LSS_IM14*RR_IM14*iRd_IM14 + 4*LS_IM14*RR_IM14*iRd_IM14 + 4*LRR_IM14*LSS_IM14*iRq_IM14*omega_IM14 + 4*LRR_IM14*LS_IM14*iRq_IM14*omega_IM14 + 4*LR_IM14*LSS_IM14*iRq_IM14*omega_IM14 + 4*LR_IM14*LS_IM14*iRq_IM14*omega_IM14))/(4*LRR_IM14*LSS_IM14 - 9*M_IM14^2 + 4*LRR_IM14*LS_IM14 + 4*LR_IM14*LSS_IM14 + 4*LR_IM14*LS_IM14);
diRq_IM14dt = (377*(M_IM14*(6*RS_IM14*iSq_IM14 - 6*vTLRq_TL_1_14 + 6*LSS_IM14*iSd_IM14*omega_IM14 + 6*LS_IM14*iSd_IM14*omega_IM14) - 4*LSS_IM14*RR_IM14*iRq_IM14 - 4*LS_IM14*RR_IM14*iRq_IM14 + 4*LRR_IM14*LSS_IM14*iRd_IM14*omega_IM14 + 4*LRR_IM14*LS_IM14*iRd_IM14*omega_IM14 + 4*LR_IM14*LSS_IM14*iRd_IM14*omega_IM14 + 4*LR_IM14*LS_IM14*iRd_IM14*omega_IM14))/(4*LRR_IM14*LSS_IM14 - 9*M_IM14^2 + 4*LRR_IM14*LS_IM14 + 4*LR_IM14*LSS_IM14 + 4*LR_IM14*LS_IM14) - 377*dphidt*iRd_IM14;
domega_IM14dt = -(377*(tauL_IM14 + B_IM14*omega_IM14 - (3*M_IM14*iRd_IM14*iSq_IM14)/2 + (3*M_IM14*iRq_IM14*iSd_IM14)/2))/J_IM14;
dtheta_IM14dt = 377*omega_IM14;
dvTLLd_TL_5_16dt = (377*(iTLMd_TL_1_5 - iTLMd_TL_5_16 - iTLMd_TL_5_17 - iTLMd_TL_5_18 - iTLMd_TL_5_19 - iTLMd_TL_5_21 + CTL_TL_1_5*dphidt*vTLLq_TL_5_16 + CTL_TL_5_16*dphidt*vTLLq_TL_5_16 + CTL_TL_5_17*dphidt*vTLLq_TL_5_16 + CTL_TL_5_18*dphidt*vTLLq_TL_5_16 + CTL_TL_5_19*dphidt*vTLLq_TL_5_16 + CTL_TL_5_21*dphidt*vTLLq_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
dvTLLq_TL_5_16dt = -(377*(iTLMq_TL_5_16 - iTLMq_TL_1_5 + iTLMq_TL_5_17 + iTLMq_TL_5_18 + iTLMq_TL_5_19 + iTLMq_TL_5_21 + CTL_TL_1_5*dphidt*vTLLd_TL_5_16 + CTL_TL_5_16*dphidt*vTLLd_TL_5_16 + CTL_TL_5_17*dphidt*vTLLd_TL_5_16 + CTL_TL_5_18*dphidt*vTLLd_TL_5_16 + CTL_TL_5_19*dphidt*vTLLd_TL_5_16 + CTL_TL_5_21*dphidt*vTLLd_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19 + CTL_TL_5_21);
diTLMd_TL_5_16dt = 377*dphidt*iTLMq_TL_5_16 - (377*(vTLRd_TL_5_16 - vTLLd_TL_5_16 + RTL_TL_5_16*iTLMd_TL_5_16))/LTL_TL_5_16;
diTLMq_TL_5_16dt = - 377*dphidt*iTLMd_TL_5_16 - (377*(vTLRq_TL_5_16 - vTLLq_TL_5_16 + RTL_TL_5_16*iTLMq_TL_5_16))/LTL_TL_5_16;
dvTLRd_TL_5_16dt = 377*dphidt*vTLRq_TL_5_16 - (377*(iLd_L16 - iTLMd_TL_5_16))/CTL_TL_5_16;
dvTLRq_TL_5_16dt = - 377*dphidt*vTLRd_TL_5_16 - (377*(iLq_L16 - iTLMq_TL_5_16))/CTL_TL_5_16;
diTLMd_TL_5_17dt = 377*dphidt*iTLMq_TL_5_17 - (377*(vTLRd_TL_5_17 - vTLLd_TL_5_16 + RTL_TL_5_17*iTLMd_TL_5_17))/LTL_TL_5_17;
diTLMq_TL_5_17dt = - 377*dphidt*iTLMd_TL_5_17 - (377*(vTLRq_TL_5_17 - vTLLq_TL_5_16 + RTL_TL_5_17*iTLMq_TL_5_17))/LTL_TL_5_17;
dvTLRd_TL_5_17dt = 377*dphidt*vTLRq_TL_5_17 - (377*(iLd_L17 - iTLMd_TL_5_17))/CTL_TL_5_17;
dvTLRq_TL_5_17dt = - 377*dphidt*vTLRd_TL_5_17 - (377*(iLq_L17 - iTLMq_TL_5_17))/CTL_TL_5_17;
diTLMd_TL_5_18dt = 377*dphidt*iTLMq_TL_5_18 - (377*(vTLRd_TL_5_18 - vTLLd_TL_5_16 + RTL_TL_5_18*iTLMd_TL_5_18))/LTL_TL_5_18;
diTLMq_TL_5_18dt = - 377*dphidt*iTLMd_TL_5_18 - (377*(vTLRq_TL_5_18 - vTLLq_TL_5_16 + RTL_TL_5_18*iTLMq_TL_5_18))/LTL_TL_5_18;
dvTLRd_TL_5_18dt = 377*dphidt*vTLRq_TL_5_18 - (377*(iLd_L18 - iTLMd_TL_5_18))/CTL_TL_5_18;
dvTLRq_TL_5_18dt = - 377*dphidt*vTLRd_TL_5_18 - (377*(iLq_L18 - iTLMq_TL_5_18))/CTL_TL_5_18;
diTLMd_TL_5_19dt = 377*dphidt*iTLMq_TL_5_19 - (377*(vTLRd_TL_5_19 - vTLLd_TL_5_16 + RTL_TL_5_19*iTLMd_TL_5_19))/LTL_TL_5_19;
diTLMq_TL_5_19dt = - 377*dphidt*iTLMd_TL_5_19 - (377*(vTLRq_TL_5_19 - vTLLq_TL_5_16 + RTL_TL_5_19*iTLMq_TL_5_19))/LTL_TL_5_19;
dvTLRd_TL_5_19dt = 377*dphidt*vTLRq_TL_5_19 - (377*(iLd_L19 - iTLMd_TL_5_19))/CTL_TL_5_19;
dvTLRq_TL_5_19dt = - 377*dphidt*vTLRd_TL_5_19 - (377*(iLq_L19 - iTLMq_TL_5_19))/CTL_TL_5_19;
dvTLRd_TL_5_21dt = 377*dphidt*vTLRq_TL_5_21 - (377*(iLd_PV21 - iTLMd_TL_5_21))/CTL_TL_5_21;
dvTLRq_TL_5_21dt = - 377*dphidt*vTLRd_TL_5_21 - (377*(iLq_PV21 - iTLMq_TL_5_21))/CTL_TL_5_21;
%dvTLLd_TL_1_5dt = (377*(iSd_G22 - iTLMd_TL_1_2 - iTLMd_TL_1_5 - iTLMd_TL_1_11 - iTLMd_TL_1_12 - iTLMd_TL_1_13 - iTLMd_TL_1_14 - iTLMd_TL_1_15 + CTL_TL_1_2*dphidt*vTLLq_TL_1_5 + CTL_TL_1_5*dphidt*vTLLq_TL_1_5 + CTL_TL_1_11*dphidt*vTLLq_TL_1_5 + CTL_TL_1_12*dphidt*vTLLq_TL_1_5 + CTL_TL_1_13*dphidt*vTLLq_TL_1_5 + CTL_TL_1_14*dphidt*vTLLq_TL_1_5 + CTL_TL_1_15*dphidt*vTLLq_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
%dvTLLq_TL_1_5dt = -(377*(iTLMq_TL_1_2 - iSq_G22 + iTLMq_TL_1_5 + iTLMq_TL_1_11 + iTLMq_TL_1_12 + iTLMq_TL_1_13 + iTLMq_TL_1_14 + iTLMq_TL_1_15 + CTL_TL_1_2*dphidt*vTLLd_TL_1_5 + CTL_TL_1_5*dphidt*vTLLd_TL_1_5 + CTL_TL_1_11*dphidt*vTLLd_TL_1_5 + CTL_TL_1_12*dphidt*vTLLd_TL_1_5 + CTL_TL_1_13*dphidt*vTLLd_TL_1_5 + CTL_TL_1_14*dphidt*vTLLd_TL_1_5 + CTL_TL_1_15*dphidt*vTLLd_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
diTLMd_TL_1_5dt = 377*dphidt*iTLMq_TL_1_5 - (377*(vTLLd_TL_5_16 - vTLLd_TL_1_5 + RTL_TL_1_5*iTLMd_TL_1_5))/LTL_TL_1_5;
diTLMq_TL_1_5dt = - 377*dphidt*iTLMd_TL_1_5 - (377*(vTLLq_TL_5_16 - vTLLq_TL_1_5 + RTL_TL_1_5*iTLMq_TL_1_5))/LTL_TL_1_5;
diTLMd_TL_1_14dt = 377*dphidt*iTLMq_TL_1_14 - (377*(vTLRd_TL_1_14 - vTLLd_TL_1_5 + RTL_TL_1_14*iTLMd_TL_1_14))/LTL_TL_1_14;
diTLMq_TL_1_14dt = - 377*dphidt*iTLMd_TL_1_14 - (377*(vTLRq_TL_1_14 - vTLLq_TL_1_5 + RTL_TL_1_14*iTLMq_TL_1_14))/LTL_TL_1_14;
dvTLRd_TL_1_14dt = 377*dphidt*vTLRq_TL_1_14 - (377*(iLd_L14 + iSd_IM14 - iTLMd_TL_1_14))/CTL_TL_1_14;
dvTLRq_TL_1_14dt = - 377*dphidt*vTLRd_TL_1_14 - (377*(iLq_L14 + iSq_IM14 - iTLMq_TL_1_14))/CTL_TL_1_14;
diTLMd_TL_1_15dt = 377*dphidt*iTLMq_TL_1_15 - (377*(vTLRd_TL_1_15 - vTLLd_TL_1_5 + RTL_TL_1_15*iTLMd_TL_1_15))/LTL_TL_1_15;
diTLMq_TL_1_15dt = - 377*dphidt*iTLMd_TL_1_15 - (377*(vTLRq_TL_1_15 - vTLLq_TL_1_5 + RTL_TL_1_15*iTLMq_TL_1_15))/LTL_TL_1_15;
dvTLRd_TL_1_15dt = 377*dphidt*vTLRq_TL_1_15 - (377*(iLd_L15 - iTLMd_TL_1_15))/CTL_TL_1_15;
dvTLRq_TL_1_15dt = - 377*dphidt*vTLRd_TL_1_15 - (377*(iLq_L15 - iTLMq_TL_1_15))/CTL_TL_1_15;
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_5 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_5 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = 377*dphidt*vTLRq_TL_1_2 - (377*(iLd_L2 - iSd_G23 + iSd_IM2 - iTLMd_TL_1_2))/CTL_TL_1_2;
dvTLRq_TL_1_2dt = - 377*dphidt*vTLRd_TL_1_2 - (377*(iLq_L2 - iSq_G23 + iSq_IM2 - iTLMq_TL_1_2))/CTL_TL_1_2;
diTLMd_TL_1_12dt = 377*dphidt*iTLMq_TL_1_12 - (377*(vTLRd_TL_1_12 - vTLLd_TL_1_5 + RTL_TL_1_12*iTLMd_TL_1_12))/LTL_TL_1_12;
diTLMq_TL_1_12dt = - 377*dphidt*iTLMd_TL_1_12 - (377*(vTLRq_TL_1_12 - vTLLq_TL_1_5 + RTL_TL_1_12*iTLMq_TL_1_12))/LTL_TL_1_12;
dvTLRd_TL_1_12dt = 377*dphidt*vTLRq_TL_1_12 - (377*(iLd_L12 - iTLMd_TL_1_12))/CTL_TL_1_12;
dvTLRq_TL_1_12dt = - 377*dphidt*vTLRd_TL_1_12 - (377*(iLq_L12 - iTLMq_TL_1_12))/CTL_TL_1_12;
diTLMd_TL_1_13dt = 377*dphidt*iTLMq_TL_1_13 - (377*(vTLRd_TL_1_13 - vTLLd_TL_1_5 + RTL_TL_1_13*iTLMd_TL_1_13))/LTL_TL_1_13;
diTLMq_TL_1_13dt = - 377*dphidt*iTLMd_TL_1_13 - (377*(vTLRq_TL_1_13 - vTLLq_TL_1_5 + RTL_TL_1_13*iTLMq_TL_1_13))/LTL_TL_1_13;
dvTLRd_TL_1_13dt = 377*dphidt*vTLRq_TL_1_13 - (377*(iLd_L13 - iTLMd_TL_1_13))/CTL_TL_1_13;
dvTLRq_TL_1_13dt = - 377*dphidt*vTLRd_TL_1_13 - (377*(iLq_L13 - iTLMq_TL_1_13))/CTL_TL_1_13;
diTLMd_TL_1_11dt = 377*dphidt*iTLMq_TL_1_11 - (377*(vTLRd_TL_1_11 - vTLLd_TL_1_5 + RTL_TL_1_11*iTLMd_TL_1_11))/LTL_TL_1_11;
diTLMq_TL_1_11dt = - 377*dphidt*iTLMd_TL_1_11 - (377*(vTLRq_TL_1_11 - vTLLq_TL_1_5 + RTL_TL_1_11*iTLMq_TL_1_11))/LTL_TL_1_11;
dvTLRd_TL_1_11dt = 377*dphidt*vTLRq_TL_1_11 - (377*(iLd_L11 - iTLMd_TL_1_11))/CTL_TL_1_11;
dvTLRq_TL_1_11dt = - 377*dphidt*vTLRd_TL_1_11 - (377*(iLq_L11 - iTLMq_TL_1_11))/CTL_TL_1_11;
diTLMd_TL_5_21dt = 377*dphidt*iTLMq_TL_5_21 - (377*(vTLRd_TL_5_21 - vTLLd_TL_5_16 + RTL_TL_5_21*iTLMd_TL_5_21))/LTL_TL_5_21;
diTLMq_TL_5_21dt = - 377*dphidt*iTLMd_TL_5_21 - (377*(vTLRq_TL_5_21 - vTLLq_TL_5_16 + RTL_TL_5_21*iTLMq_TL_5_21))/LTL_TL_5_21;
dx = [diSd_G23dt
diSq_G23dt
diRd_G23dt
diRq_G23dt
diF_G23dt
ddelta_G23dt
domega_G23dt
diSd_G22dt
diSq_G22dt
diRd_G22dt
diRq_G22dt
diF_G22dt
ddelta_G22dt
domega_G22dt
diLd_L2dt
diLq_L2dt
diLd_L16dt
diLq_L16dt
diLd_L17dt
diLq_L17dt
diLd_L18dt
diLq_L18dt
diLd_L19dt
diLq_L19dt
diLd_L14dt
diLq_L14dt
diLd_L15dt
diLq_L15dt
diLd_L12dt
diLq_L12dt
diLd_L13dt
diLq_L13dt
diLd_L11dt
diLq_L11dt
diLd_PV21dt
diLq_PV21dt
diSd_IM2dt
diSq_IM2dt
diRd_IM2dt
diRq_IM2dt
domega_IM2dt
dtheta_IM2dt
diSd_IM14dt
diSq_IM14dt
diRd_IM14dt
diRq_IM14dt
domega_IM14dt
dtheta_IM14dt
dvTLLd_TL_5_16dt
dvTLLq_TL_5_16dt
diTLMd_TL_5_16dt
diTLMq_TL_5_16dt
dvTLRd_TL_5_16dt
dvTLRq_TL_5_16dt
diTLMd_TL_5_17dt
diTLMq_TL_5_17dt
dvTLRd_TL_5_17dt
dvTLRq_TL_5_17dt
diTLMd_TL_5_18dt
diTLMq_TL_5_18dt
dvTLRd_TL_5_18dt
dvTLRq_TL_5_18dt
diTLMd_TL_5_19dt
diTLMq_TL_5_19dt
dvTLRd_TL_5_19dt
dvTLRq_TL_5_19dt
dvTLRd_TL_5_21dt
dvTLRq_TL_5_21dt
%dvTLLd_TL_1_5dt
%dvTLLq_TL_1_5dt
diTLMd_TL_1_5dt
diTLMq_TL_1_5dt
diTLMd_TL_1_14dt
diTLMq_TL_1_14dt
dvTLRd_TL_1_14dt
dvTLRq_TL_1_14dt
diTLMd_TL_1_15dt
diTLMq_TL_1_15dt
dvTLRd_TL_1_15dt
dvTLRq_TL_1_15dt
diTLMd_TL_1_2dt
diTLMq_TL_1_2dt
dvTLRd_TL_1_2dt
dvTLRq_TL_1_2dt
diTLMd_TL_1_12dt
diTLMq_TL_1_12dt
dvTLRd_TL_1_12dt
dvTLRq_TL_1_12dt
diTLMd_TL_1_13dt
diTLMq_TL_1_13dt
dvTLRd_TL_1_13dt
dvTLRq_TL_1_13dt
diTLMd_TL_1_11dt
diTLMq_TL_1_11dt
dvTLRd_TL_1_11dt
dvTLRq_TL_1_11dt
diTLMd_TL_5_21dt
diTLMq_TL_5_21dt
];
end

iSd_G23 = x(:,1);
iSq_G23 = x(:,2);
iRd_G23 = x(:,3);
iRq_G23 = x(:,4);
iF_G23 = x(:,5);
delta_G23 = x(:,6);
omega_G23 = x(:,7);
iSd_G22 = x(:,8);
iSq_G22 = x(:,9);
iRd_G22 = x(:,10);
iRq_G22 = x(:,11);
iF_G22 = x(:,12);
delta_G22 = x(:,13);
omega_G22 = x(:,14);
iLd_L2 = x(:,15);
iLq_L2 = x(:,16);
iLd_L16 = x(:,17);
iLq_L16 = x(:,18);
iLd_L17 = x(:,19);
iLq_L17 = x(:,20);
iLd_L18 = x(:,21);
iLq_L18 = x(:,22);
iLd_L19 = x(:,23);
iLq_L19 = x(:,24);
iLd_L14 = x(:,25);
iLq_L14 = x(:,26);
iLd_L15 = x(:,27);
iLq_L15 = x(:,28);
iLd_L12 = x(:,29);
iLq_L12 = x(:,30);
iLd_L13 = x(:,31);
iLq_L13 = x(:,32);
iLd_L11 = x(:,33);
iLq_L11 = x(:,34);
iLd_PV21 = x(:,35);
iLq_PV21 = x(:,36);
iSd_IM2 = x(:,37);
iSq_IM2 = x(:,38);
iRd_IM2 = x(:,39);
iRq_IM2 = x(:,40);
omega_IM2 = x(:,41);
theta_IM2 = x(:,42);
iSd_IM14 = x(:,43);
iSq_IM14 = x(:,44);
iRd_IM14 = x(:,45);
iRq_IM14 = x(:,46);
omega_IM14 = x(:,47);
theta_IM14 = x(:,48);
vTLLd_TL_5_16 = x(:,49);
vTLLq_TL_5_16 = x(:,50);
iTLMd_TL_5_16 = x(:,51);
iTLMq_TL_5_16 = x(:,52);
vTLRd_TL_5_16 = x(:,53);
vTLRq_TL_5_16 = x(:,54);
iTLMd_TL_5_17 = x(:,55);
iTLMq_TL_5_17 = x(:,56);
vTLRd_TL_5_17 = x(:,57);
vTLRq_TL_5_17 = x(:,58);
iTLMd_TL_5_18 = x(:,59);
iTLMq_TL_5_18 = x(:,60);
vTLRd_TL_5_18 = x(:,61);
vTLRq_TL_5_18 = x(:,62);
iTLMd_TL_5_19 = x(:,63);
iTLMq_TL_5_19 = x(:,64);
vTLRd_TL_5_19 = x(:,65);
vTLRq_TL_5_19 = x(:,66);
vTLRd_TL_5_21 = x(:,67);
vTLRq_TL_5_21 = x(:,68);
%vTLLd_TL_1_5 = x(:,67);
%vTLLq_TL_1_5 = x(:,68);
iTLMd_TL_1_5 = x(:,69);
iTLMq_TL_1_5 = x(:,70);
iTLMd_TL_1_14 = x(:,71);
iTLMq_TL_1_14 = x(:,72);
vTLRd_TL_1_14 = x(:,73);
vTLRq_TL_1_14 = x(:,74);
iTLMd_TL_1_15 = x(:,75);
iTLMq_TL_1_15 = x(:,76);
vTLRd_TL_1_15 = x(:,77);
vTLRq_TL_1_15 = x(:,78);
iTLMd_TL_1_2 = x(:,79);
iTLMq_TL_1_2 = x(:,80);
vTLRd_TL_1_2 = x(:,81);
vTLRq_TL_1_2 = x(:,82);
iTLMd_TL_1_12 = x(:,83);
iTLMq_TL_1_12 = x(:,84);
vTLRd_TL_1_12 = x(:,85);
vTLRq_TL_1_12 = x(:,86);
iTLMd_TL_1_13 = x(:,87);
iTLMq_TL_1_13 = x(:,88);
vTLRd_TL_1_13 = x(:,89);
vTLRq_TL_1_13 = x(:,90);
iTLMd_TL_1_11 = x(:,91);
iTLMq_TL_1_11 = x(:,92);
vTLRd_TL_1_11 = x(:,93);
vTLRq_TL_1_11 = x(:,94);
iTLMd_TL_5_21 = x(:,95);
iTLMq_TL_5_21 = x(:,96);

save('Data8.mat');

figure(1);
subplot(2,1,1)
plot(t,iSd_G23,'b',t,iSq_G23,'r');
title('Stator Currents of G1');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G23,'b',t,iRq_G23,'r',t,iF_G23,'k');
title('Rotor Currents of G1');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(2);
plot(t,delta_G23,t,omega_G23)
title('Rotor Mechanical states of G1')
xlabel('Time (in seconds)');
legend('Rotor Relative angle','Rotor angular frequency');

figure(3);
subplot(2,1,1)
plot(t,iSd_G22,'b',t,iSq_G22,'r');
title('Stator Currents of G2');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_G22,'b',t,iRq_G22,'r',t,iF_G22,'k');
title('Rotor Currents of G2');
legend('iD','iQ','iF');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(4);
plot(t,delta_G22,t,omega_G22)
title('Rotor Mechanical states of G2')
xlabel('Time (in seconds)');
legend('Rotor Relative angle','Rotor angular frequency');

figure(5);
subplot(2,1,1)
plot(t,iSd_IM2,'b',t,iSq_IM2,'r');
title('Stator Currents of IM1');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_IM2,'b',t,iRq_IM2,'r');
title('Rotor Currents of IM1');
legend('iD','iQ');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(6);
plot(t,omega_IM2)
title('Rotor Mechanical states of IM1')
xlabel('Time (in seconds)');
legend('Rotor angular frequency');

figure(7);
subplot(2,1,1)
plot(t,iSd_IM14,'b',t,iSq_IM14,'r');
title('Stator Currents of IM2');
legend('Id','Iq');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

subplot(2,1,2)
plot(t,iRd_IM14,'b',t,iRq_IM14,'r');
title('Rotor Currents of IM2');
legend('iD','iQ');
xlabel('Time in seconds');
ylabel('Currents (in p.u)');

figure(8);
plot(t,omega_IM14)
title('Rotor Mechanical states of IM14')
xlabel('Time (in seconds)');
legend('Rotor angular frequency');


figure(9);
plot(t,vTLRd_TL_1_2,'b',t,vTLRq_TL_1_2,'r');
title('Voltages at bus 2');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(10);
plot(t,vTLLd_TL_5_16,'b',t,vTLLq_TL_5_16,'r');
title('Voltages at bus 5');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(11);
plot(t,vTLRd_TL_1_14,'b',t,vTLRq_TL_1_14,'r');
title('Voltages at bus 14');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

end