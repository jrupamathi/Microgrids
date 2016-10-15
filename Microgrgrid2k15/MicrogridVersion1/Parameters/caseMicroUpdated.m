function mpc = caseMicroUpdated
%CASE9    Power flow data for Lincoln Lab microgrid
%   Please see CASEFORMAT for details on the case file format.
%
%   Based on data from Joe H. Chow's book, p. 70.

%   MATPOWER
%   $Id: case9.m 2408 2014-10-22 20:41:33Z ray $

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 4;

%% bus data
%t =0;
Vmax = 1.02; Vmin = 0.97;
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
% mpc.bus = [
% 1	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 2	1	1.186425	0.61481875	0	0	1	1	0	0.46	1	Vmax	Vmin
% 3	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 4	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 5	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 6	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 7	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 8	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 9	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 10	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 11	1	0.22	0.01	0	0	1	1	0	0.46	1	Vmax	Vmin
% 12	1	0.14	0.09	0	0	1	1	0	0.46	1	Vmax	Vmin
% 13	1	0.16	0.09	0	0	1	1	0	0.46	1	Vmax	Vmin
% 14	1	0.706425	0.63981875	0	0	1	1	0	0.46	1	Vmax	Vmin
% 15	1	2.5	1.2	0	0	1	1	0	0.46	1	Vmax	Vmin
% 16	1	0.09	0.042	0	0	1	1	0	0.46	1	Vmax	Vmin
% 17	1	0.14	0.01	0	0	1	1	0	0.208	1	Vmax	Vmin
% 18	1	0.28	0.1	0	0	1	1	0	0.208	1	Vmax	Vmin
% 19	1	0.78	0.42	0	0	1	1	0	0.208	1	Vmax	Vmin
% 20	1	0	0	0	0	1	1	0	2.4	1	Vmax	Vmin
% 21	1	-3.5	-0.01	0	0	1	1	0	2.4	1	Vmax	Vmin
% 22	3	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 23	2	0	0	0	0	1	1	0	0.46	1	Vmax	Vmin
% ];


%%
%at t=7000sec
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
% mpc.bus = [
% 1	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 2	1	1.186425	0.61481875	0	0	1	1	0	0.46	1	Vmax	Vmin
% 3	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 4	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 5	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 6	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 7	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 8	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 9	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 10	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
% 11	1	0.26	0.015	0	0	1	1	0	0.46	1	Vmax	Vmin
% 12	1	0.25	0.11	0	0	1	1	0	0.46	1	Vmax	Vmin
% 13	1	0.2	0.1	0	0	1	1	0	0.46	1	Vmax	Vmin
% 14	1	0.886425	0.82981875	0	0	1	1	0	0.46	1	Vmax	Vmin
% 15	1	2.5	1.2	0	0	1	1	0	0.46	1	Vmax	Vmin
% 16	1	0.09	0.042	0	0	1	1	0	0.46	1	Vmax	Vmin
% 17	1	0.26	0.03	0	0	1	1	0	0.208	1	Vmax	Vmin
% 18	1	0.59	0.2	0	0	1	1	0	0.208	1	Vmax	Vmin
% 19	1	0.93	0.43	0	0	1	1	0	0.208	1	Vmax	Vmin
% 20	1	0	0	0	0	1	1	0	2.4	1	Vmax	Vmin
% 21	1	-0.8	-0.01	0	0	1	1	0	2.4	1	Vmax	Vmin
% 22	3	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
% 23	2	0	0	0	0	1	1	0	0.46	1	Vmax	Vmin
% ];
%%
%worst case loading
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
1	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
2	1	1.186425	0.61481875	0	0	1	1	0	0.46	1	Vmax	Vmin
3	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
4	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
5	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
6	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
7	1	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
8	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
9	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
10	1	0	0	0	0	1	1	0	4.16	1	Vmax	Vmin
11	1	0.28	0.015	0	0	1	1	0	0.46	1	Vmax	Vmin
12	1	0.25	0.11	0	0	1	1	0	0.46	1	Vmax	Vmin
13	1	0.21	0.1	0	0	1	1	0	0.46	1	Vmax	Vmin
14	1	0.996425	0.84981875	0	0	1	1	0	0.46	1	Vmax	Vmin
15	1	2.5	1.2	0	0	1	1	0	0.46	1	Vmax	Vmin
16	1	0.09	0.042	0	0	1	1	0	0.46	1	Vmax	Vmin
17	1	0.26	0.03	0	0	1	1	0	0.208	1	Vmax	Vmin
18	1	0.59	0.2	0	0	1	1	0	0.208	1	Vmax	Vmin
19	1	0.94	0.43	0	0	1	1	0	0.208	1	Vmax	Vmin
20	1	-1.75	-1.4	0	0	1	1	0	2.4	1	Vmax	Vmin
21	1	-3.5	-2.81	0	0	1	1	0	2.4	1	Vmax	Vmin
22	3	0	0	0	0	1	1	0	13.8	1	Vmax	Vmin
23	2	0	0	0	0	1	1	0	0.46	1	Vmax	Vmin
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
22	4	0	4	-4	1	4	1	4	0	0	0	0	0	0	0	0	0	0	0	0
23	1	0	1	-1	1.02	4	1	1	0	0	0	0	0	0	0	0	0	0	0	0
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
1	2	0.013358639	0.05018743	0.000132324	7	7	7	0	0	1	-360	360
1	3	0.001143025	0.001811733	0.000299749	7	7	7	0	0	1	-360	360
1	4	0.004719597	0.000929217	8.35473E-05	7	7	7	0	0	1	-360	360
3	5	0.00907773	0.04987504	0.000299749	7	7	7	0	0	1	-360	360
3	11	0.167611947	0.105140171	0.000132324	7	7	7	0	0	1	-360	360
4	6	0.009439193	0.001858433	0.000167095	7	7	7	0	0	1	-360	360
4	7	1.23503E-05	1.95757E-05	3.23878E-06	7	7	7	0	0	1	-360	360
5	8	0.002225869	0.00043824	3.25375E-07	7	7	7	0	0	1	-360	360
5	9	0.001483913	0.00029216	2.16917E-07	7	7	7	0	0	1	-360	360
9	10	0.003783977	0.000745007	5.53137E-07	7	7	7	0	0	1	-360	360
8	16	0.029644307	0.079008783	5.53137E-07	7	7	7	0	0	1	-360	360
8	17	0.083705049	0.12797995	5.53137E-07	7	7	7	0	0	1	-360	360
9	18	0.083705049	0.164696897	5.53137E-07	7	7	7	0	0	1	-360	360
10	19	0.079921071	0.16395189	9.19728E-10	7	7	7	0	0	1	-360	360
10	20	0.029799523	0.059752202	2.88794E-07	7	7	7	0	0	1	-360	360
6	13	0.038460508	0.093168317	1.19353E-05	7	7	7	0	0	1	-360	360
6	14	0.014665087	0.050263045	0.000132761	7	7	7	0	0	1	-360	360
7	15	0.010152997	0.049235878	4.06466E-05	7	7	7	0	0	1	-360	360
8	21	0.01196619	0.056241091	0	7	7	7	0	0	1	-360	360
6	12	0.037954837	0.093068758	2.98383E-06	7	7	7	0	0	1	-360	360
7	22	6.17517E-05	9.78786E-05	1.61939E-05	7	7	7	0	0	1	-360	360
2	23	0.151228733	0.053875236	7.35131E-09	7	7	7	0	0	1	-360	360
];

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	1500	0	3	0.11	5	150;
	2	2000	0	3	0.085	1.2	600;
];

end 