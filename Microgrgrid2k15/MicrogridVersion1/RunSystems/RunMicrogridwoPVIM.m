function RunMicrogridwoPVIM

clear all
close all

set(0,'defaultlinelinewidth',1.5)


addpath('../Parameters')
            
load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','RR_G23','RF_G23','H_G23','B_G23')
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','RR_G22','RF_G22','H_G22','B_G22');

load('L2.mat', 'RL_L2', 'LL_L2');
load('L16.mat', 'RL_L16', 'LL_L16');
load('L17.mat', 'RL_L17', 'LL_L17');
load('L18.mat', 'RL_L18', 'LL_L18');
load('L19.mat', 'RL_L19', 'LL_L19');
load('L14.mat', 'RL_L14', 'LL_L14');
load('L12.mat', 'RL_L12', 'LL_L12');
load('L13.mat', 'RL_L13', 'LL_L13');
load('L15.mat', 'RL_L15', 'LL_L15');
load('L11.mat', 'RL_L11', 'LL_L11');

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

% base frequency
wb = 377;
omega0 = 1;

tic
tArray = 4:1e-3:5;%[4 4.2 5 6];% 8 10 12 14 16 18 20];
%x0 = ones(80,1);
x0 = [0.5552;-0.4078;0.0016;0.0082;-1.3009;0.6396;0.9999;
0.5447;-0.3230;-0.0000;-0.0000;-1.2330;0.6567;1.0000;
    0.3129;-0.1455;
   0.0218;-0.0109;
    0.0502;-0.0180;
   0.0016;0.0014;
    0.1407;-0.0524;
   0.2059;-0.2656;
    0.7481  ; -0.2621;
   0.0350;   -0.0227;
    0.0400;   -0.0227;
   0.0340;   -0.0105;
    1.0617;    0.0036 ;   0.0452 ;  -0.1052;    1.5373  ; -0.0625;
     0.3627 ;   0.0395 ;   1.2433 ;  -0.6160;
     -0.8070 ;  -0.7785;   -1.5397;    2.7540;
     0.2225;    0.2177 ;   1.1675 ;  -0.8991;
    1.0907 ;   0.0392; 0.2129;    0.0234;
    0.4421 ;  -0.6845  ;  0.1673  ; -0.1074;
    0.5758 ;  -0.3002;    0.0061 ;   0.0685;
    -0.4682;   -0.1414 ;   1.0907 ;   0.0392;
    5.67e-4 ;  -0.0127 ;   0.9987  ; -0.0036;
    0.0400 ;  -0.0127 ;   0.9987  ; -0.0041;
    -0.2715 ;   0.0444 ;   1.0813 ;   0.4202];
   
Options =  odeset('RelTol',1e-4,'AbsTol',1e-3');

t = [];
x = [];
%for i = 1:numel(tArray)-1
    %tspan = [tArray(1),5];%tArray(i+1)];
    tspan = [4,5];
    %tspan = 4:1e-5:5;
    %tauL_IM2 = tauL_IM2Array(1);
    [t,x] = ode45(@LLMicrogridDynamics,tspan,x0);%,Options,tauL_IM2);
   % t = [t tStep'];
   % x = [x xStep'];
   % x0 = x(:,end);
%end
    toc
    %t = tspan;


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
vTLLd_TL_5_16 = x(35);
vTLLq_TL_5_16 = x(36);
iTLMd_TL_5_16 = x(37);
iTLMq_TL_5_16 = x(38);
vTLRd_TL_5_16 = x(39);
vTLRq_TL_5_16 = x(40);
iTLMd_TL_5_17 = x(41);
iTLMq_TL_5_17 = x(42);
vTLRd_TL_5_17 = x(43);
vTLRq_TL_5_17 = x(44);
iTLMd_TL_5_18 = x(45);
iTLMq_TL_5_18 = x(46);
vTLRd_TL_5_18 = x(47);
vTLRq_TL_5_18 = x(48);
iTLMd_TL_5_19 = x(49);
iTLMq_TL_5_19 = x(50);
vTLRd_TL_5_19 = x(51);
vTLRq_TL_5_19 = x(52);
vTLLd_TL_1_5 = x(53);
vTLLq_TL_1_5 = x(54);
iTLMd_TL_1_5 = x(55);
iTLMq_TL_1_5 = x(56);
iTLMd_TL_1_14 = x(57);
iTLMq_TL_1_14 = x(58);
vTLRd_TL_1_14 = x(59);
vTLRq_TL_1_14 = x(60);
iTLMd_TL_1_15 = x(61);
iTLMq_TL_1_15 = x(62);
vTLRd_TL_1_15 = x(63);
vTLRq_TL_1_15 = x(64);
iTLMd_TL_1_2 = x(65);
iTLMq_TL_1_2 = x(66);
vTLRd_TL_1_2 = x(67);
vTLRq_TL_1_2 = x(68);
iTLMd_TL_1_12 = x(69);
iTLMq_TL_1_12 = x(70);
vTLRd_TL_1_12 = x(71);
vTLRq_TL_1_12 = x(72);
iTLMd_TL_1_13 = x(73);
iTLMq_TL_1_13 = x(74);
vTLRd_TL_1_13 = x(75);
vTLRq_TL_1_13 = x(76);
iTLMd_TL_1_11 = x(77);
iTLMq_TL_1_11 = x(78);
vTLRd_TL_1_11 = x(79);
vTLRq_TL_1_11 = x(80);

dphidt = 1; 
k=[ 0.1717   -0.1699    0.1992    0.1616    0.2451    0.6717   18.0678
   -0.0260    1.0025   -0.9161   -1.8398    0.0834   -0.1784   -1.5713];
reqd=[0.09947, -0.1208, -3.2e-16, -0.5591, -6.12e-16, 0.1947, 1.0]';
Tm_G23=-(k(1,:)*([iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23;delta_G23;omega_G23]-reqd))+1;
    vR_G23=-(k(2,:)*([iSd_G23;iSq_G23;iRd_G23;iF_G23;iRq_G23; delta_G23;omega_G23]-reqd))+0.00064;
reqd1 = [0.9517,-0.6267, 2.2e-16, -1.997, -7.92e-16, 0.7545, 1.0]';
k1  =[0.1629   -0.1649    0.3470    0.2374    0.0802    0.9930   21.2471
   -0.5066    0.8959   -1.0195   -1.8800    0.1244   -0.6769   -6.3352];
Tm_G22=-(k1(1,:)*([iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22;delta_G22;omega_G22]-reqd1))+1;
vR_G22=-(k1(2,:)*([iSd_G22;iSq_G22;iRd_G22;iF_G22;iRq_G22;delta_G22;omega_G22]-reqd1))+0.00064;

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
diLd_L2dt = 377*dphidt*iLq_L2 + (377*(vTLRd_TL_1_2 - RL_L2*iLd_L2))/LL_L2;
diLq_L2dt = (377*(vTLRq_TL_1_2 - RL_L2*iLq_L2))/LL_L2 - 377*dphidt*iLd_L2;
diLd_L16dt = 377*dphidt*iLq_L16 + (377*(vTLRd_TL_5_16 - RL_L16*iLd_L16))/LL_L16;
diLq_L16dt = (377*(vTLRq_TL_5_16 - RL_L16*iLq_L16))/LL_L16 - 377*dphidt*iLd_L16;
diLd_L17dt = 377*dphidt*iLq_L17 + (377*(vTLRd_TL_5_17 - RL_L17*iLd_L17))/LL_L17;
diLq_L17dt = (377*(vTLRq_TL_5_17 - RL_L17*iLq_L17))/LL_L17 - 377*dphidt*iLd_L17;
diLd_L18dt = 377*dphidt*iLq_L18 + (377*(vTLRd_TL_5_18 - RL_L18*iLd_L18))/LL_L18;
diLq_L18dt = (377*(vTLRq_TL_5_18 - RL_L18*iLq_L18))/LL_L18 - 377*dphidt*iLd_L18;
diLd_L19dt = 377*dphidt*iLq_L19 + (377*(vTLRd_TL_5_19 - RL_L19*iLd_L19))/LL_L19;
diLq_L19dt = (377*(vTLRq_TL_5_19 - RL_L19*iLq_L19))/LL_L19 - 377*dphidt*iLd_L19;
diLd_L14dt = 377*dphidt*iLq_L14 + (377*(vTLRd_TL_1_14 - RL_L14*iLd_L14))/LL_L14;
diLq_L14dt = (377*(vTLRq_TL_1_14 - RL_L14*iLq_L14))/LL_L14 - 377*dphidt*iLd_L14;
diLd_L15dt = 377*dphidt*iLq_L15 + (377*(vTLRd_TL_1_15 - RL_L15*iLd_L15))/LL_L15;
diLq_L15dt = (377*(vTLRq_TL_1_15 - RL_L15*iLq_L15))/LL_L15 - 377*dphidt*iLd_L15;
diLd_L12dt = 377*dphidt*iLq_L12 + (377*(vTLRd_TL_1_12 - RL_L12*iLd_L12))/LL_L12;
diLq_L12dt = (377*(vTLRq_TL_1_12 - RL_L12*iLq_L12))/LL_L12 - 377*dphidt*iLd_L12;
diLd_L13dt = 377*dphidt*iLq_L13 + (377*(vTLRd_TL_1_13 - RL_L13*iLd_L13))/LL_L13;
diLq_L13dt = (377*(vTLRq_TL_1_13 - RL_L13*iLq_L13))/LL_L13 - 377*dphidt*iLd_L13;
diLd_L11dt = 377*dphidt*iLq_L11 + (377*(vTLRd_TL_1_11 - RL_L11*iLd_L11))/LL_L11;
diLq_L11dt = (377*(vTLRq_TL_1_11 - RL_L11*iLq_L11))/LL_L11 - 377*dphidt*iLd_L11;
dvTLLd_TL_5_16dt = (377*(iTLMd_TL_1_5 - iTLMd_TL_5_16 - iTLMd_TL_5_17 - iTLMd_TL_5_18 - iTLMd_TL_5_19 + CTL_TL_1_5*dphidt*vTLLq_TL_5_16 + CTL_TL_5_16*dphidt*vTLLq_TL_5_16 + CTL_TL_5_17*dphidt*vTLLq_TL_5_16 + CTL_TL_5_18*dphidt*vTLLq_TL_5_16 + CTL_TL_5_19*dphidt*vTLLq_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19);
dvTLLq_TL_5_16dt = -(377*(iTLMq_TL_5_16 - iTLMq_TL_1_5 + iTLMq_TL_5_17 + iTLMq_TL_5_18 + iTLMq_TL_5_19 + CTL_TL_1_5*dphidt*vTLLd_TL_5_16 + CTL_TL_5_16*dphidt*vTLLd_TL_5_16 + CTL_TL_5_17*dphidt*vTLLd_TL_5_16 + CTL_TL_5_18*dphidt*vTLLd_TL_5_16 + CTL_TL_5_19*dphidt*vTLLd_TL_5_16))/(CTL_TL_1_5 + CTL_TL_5_16 + CTL_TL_5_17 + CTL_TL_5_18 + CTL_TL_5_19);
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
dvTLLd_TL_1_5dt = (377*(iSd_G22 - iTLMd_TL_1_2 - iTLMd_TL_1_5 - iTLMd_TL_1_11 - iTLMd_TL_1_12 - iTLMd_TL_1_13 - iTLMd_TL_1_14 - iTLMd_TL_1_15 + CTL_TL_1_2*dphidt*vTLLq_TL_1_5 + CTL_TL_1_5*dphidt*vTLLq_TL_1_5 + CTL_TL_1_11*dphidt*vTLLq_TL_1_5 + CTL_TL_1_12*dphidt*vTLLq_TL_1_5 + CTL_TL_1_13*dphidt*vTLLq_TL_1_5 + CTL_TL_1_14*dphidt*vTLLq_TL_1_5 + CTL_TL_1_15*dphidt*vTLLq_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
dvTLLq_TL_1_5dt = -(377*(iTLMq_TL_1_2 - iSq_G22 + iTLMq_TL_1_5 + iTLMq_TL_1_11 + iTLMq_TL_1_12 + iTLMq_TL_1_13 + iTLMq_TL_1_14 + iTLMq_TL_1_15 + CTL_TL_1_2*dphidt*vTLLd_TL_1_5 + CTL_TL_1_5*dphidt*vTLLd_TL_1_5 + CTL_TL_1_11*dphidt*vTLLd_TL_1_5 + CTL_TL_1_12*dphidt*vTLLd_TL_1_5 + CTL_TL_1_13*dphidt*vTLLd_TL_1_5 + CTL_TL_1_14*dphidt*vTLLd_TL_1_5 + CTL_TL_1_15*dphidt*vTLLd_TL_1_5))/(CTL_TL_1_2 + CTL_TL_1_5 + CTL_TL_1_11 + CTL_TL_1_12 + CTL_TL_1_13 + CTL_TL_1_14 + CTL_TL_1_15);
diTLMd_TL_1_5dt = 377*dphidt*iTLMq_TL_1_5 - (377*(vTLLd_TL_5_16 - vTLLd_TL_1_5 + RTL_TL_1_5*iTLMd_TL_1_5))/LTL_TL_1_5;
diTLMq_TL_1_5dt = - 377*dphidt*iTLMd_TL_1_5 - (377*(vTLLq_TL_5_16 - vTLLq_TL_1_5 + RTL_TL_1_5*iTLMq_TL_1_5))/LTL_TL_1_5;
diTLMd_TL_1_14dt = 377*dphidt*iTLMq_TL_1_14 - (377*(vTLRd_TL_1_14 - vTLLd_TL_1_5 + RTL_TL_1_14*iTLMd_TL_1_14))/LTL_TL_1_14;
diTLMq_TL_1_14dt = - 377*dphidt*iTLMd_TL_1_14 - (377*(vTLRq_TL_1_14 - vTLLq_TL_1_5 + RTL_TL_1_14*iTLMq_TL_1_14))/LTL_TL_1_14;
dvTLRd_TL_1_14dt = 377*dphidt*vTLRq_TL_1_14 - (377*(iLd_L14 - iTLMd_TL_1_14))/CTL_TL_1_14;
dvTLRq_TL_1_14dt = - 377*dphidt*vTLRd_TL_1_14 - (377*(iLq_L14 - iTLMq_TL_1_14))/CTL_TL_1_14;
diTLMd_TL_1_15dt = 377*dphidt*iTLMq_TL_1_15 - (377*(vTLRd_TL_1_15 - vTLLd_TL_1_5 + RTL_TL_1_15*iTLMd_TL_1_15))/LTL_TL_1_15;
diTLMq_TL_1_15dt = - 377*dphidt*iTLMd_TL_1_15 - (377*(vTLRq_TL_1_15 - vTLLq_TL_1_5 + RTL_TL_1_15*iTLMq_TL_1_15))/LTL_TL_1_15;
dvTLRd_TL_1_15dt = 377*dphidt*vTLRq_TL_1_15 - (377*(iLd_L15 - iTLMd_TL_1_15))/CTL_TL_1_15;
dvTLRq_TL_1_15dt = - 377*dphidt*vTLRd_TL_1_15 - (377*(iLq_L15 - iTLMq_TL_1_15))/CTL_TL_1_15;
diTLMd_TL_1_2dt = 377*dphidt*iTLMq_TL_1_2 - (377*(vTLRd_TL_1_2 - vTLLd_TL_1_5 + RTL_TL_1_2*iTLMd_TL_1_2))/LTL_TL_1_2;
diTLMq_TL_1_2dt = - 377*dphidt*iTLMd_TL_1_2 - (377*(vTLRq_TL_1_2 - vTLLq_TL_1_5 + RTL_TL_1_2*iTLMq_TL_1_2))/LTL_TL_1_2;
dvTLRd_TL_1_2dt = 377*dphidt*vTLRq_TL_1_2 + (377*(iSd_G23 - iLd_L2 + iTLMd_TL_1_2))/CTL_TL_1_2;
dvTLRq_TL_1_2dt = (377*(iSq_G23 - iLq_L2 + iTLMq_TL_1_2))/CTL_TL_1_2 - 377*dphidt*vTLRd_TL_1_2;
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
dvTLLd_TL_1_5dt
dvTLLq_TL_1_5dt
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
vTLLd_TL_5_16 = x(:,35);
vTLLq_TL_5_16 = x(:,36);
iTLMd_TL_5_16 = x(:,37);
iTLMq_TL_5_16 = x(:,38);
vTLRd_TL_5_16 = x(:,39);
vTLRq_TL_5_16 = x(:,40);
iTLMd_TL_5_17 = x(:,41);
iTLMq_TL_5_17 = x(:,42);
vTLRd_TL_5_17 = x(:,43);
vTLRq_TL_5_17 = x(:,44);
iTLMd_TL_5_18 = x(:,45);
iTLMq_TL_5_18 = x(:,46);
vTLRd_TL_5_18 = x(:,47);
vTLRq_TL_5_18 = x(:,48);
iTLMd_TL_5_19 = x(:,49);
iTLMq_TL_5_19 = x(:,50);
vTLRd_TL_5_19 = x(:,51);
vTLRq_TL_5_19 = x(:,52);
vTLLd_TL_1_5 = x(:,53);
vTLLq_TL_1_5 = x(:,54);
iTLMd_TL_1_5 = x(:,55);
iTLMq_TL_1_5 = x(:,56);
iTLMd_TL_1_14 = x(:,57);
iTLMq_TL_1_14 = x(:,58);
vTLRd_TL_1_14 = x(:,59);
vTLRq_TL_1_14 = x(:,60);
iTLMd_TL_1_15 = x(:,61);
iTLMq_TL_1_15 = x(:,62);
vTLRd_TL_1_15 = x(:,63);
vTLRq_TL_1_15 = x(:,64);
iTLMd_TL_1_2 = x(:,65);
iTLMq_TL_1_2 = x(:,66);
vTLRd_TL_1_2 = x(:,67);
vTLRq_TL_1_2 = x(:,68);
iTLMd_TL_1_12 = x(:,69);
iTLMq_TL_1_12 = x(:,70);
vTLRd_TL_1_12 = x(:,71);
vTLRq_TL_1_12 = x(:,72);
iTLMd_TL_1_13 = x(:,73);
iTLMq_TL_1_13 = x(:,74);
vTLRd_TL_1_13 = x(:,75);
vTLRq_TL_1_13 = x(:,76);
iTLMd_TL_1_11 = x(:,77);
iTLMq_TL_1_11 = x(:,78);
vTLRd_TL_1_11 = x(:,79);
vTLRq_TL_1_11 = x(:,80);

save('MicrogridwoPVIM.mat');

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

figure(9);
plot(t,vTLRd_TL_1_2,'b',t,vTLRq_TL_1_2,'r');
title('Voltages at bus 2');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');


figure(11);
plot(t,vTLLd_TL_5_16,'b',t,vTLLq_TL_5_16,'r');
title('Voltages at bus 5');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

figure(12);
plot(t,vTLRd_TL_1_14,'b',t,vTLRq_TL_1_14,'r');
title('Voltages at bus 14');
legend('Vd','Vq');
xlabel('Time in seconds');
ylabel('Voltages (in p.u)');

end