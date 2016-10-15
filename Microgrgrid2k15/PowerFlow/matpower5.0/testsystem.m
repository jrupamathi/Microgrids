%function mpc = case9
function mpc=testsystem
%CASE9    Power flow data for 9 bus, 3 generator case.
%   Please see CASEFORMAT for details on the case file format.
%
%   Based on data from Joe H. Chow's book, p. 70.

%   MATPOWER
%   $Id: case9.m 2408 2014-10-22 20:41:33Z ray $

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	3	0	0	0	0	1	1	0	345	1	1.1	0.9;
	2	2	0.40	0	0	0	1	1	0	345	1	1.1	0.9;
	3	1	0	0	0	0	1	1	0	345	1	1.1	0.9;
	4	2	0.40	0	0	0	1	1	0	345	1	1.1	0.9;
	5	2	0.40	0	0	0	1	1	0	345	1	1.1	0.9;
	6	1	0	0	0	0	1	1	0	345	1	1.1	0.9;
	];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0	0	0.300	-0.300	1	100	1	1.80	0.10	0	0	0	0	0	0	0	0	0	0	0;
	2	0.40	0	300	-300	1	100	1	1.80	0.10	0	0	0	0	0	0	0	0	0	0	0;
	4	0.40	0	300	-300	1	100	1	1.80	0.10	0	0	0	0	0	0	0	0	0	0	0;
    5	0.40	0	300	-300	1	100	1	1.85	0.10	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	2	0	0.0576	0	0.250	250	250	0	0	1	-360	360;
	1	3	0.017	0.092	0.158	0.250	0.1*250	0.1*250	0	0	1	-360	360;
	2	3	0.039	0.17	0.358	0.150	150	150	0	0	1	-360	360;
	3	6	0	0.0586	0	0.300	0.300	0.300	0	0	1	-360	360;
	4	6	0.0119	0.1008	0.209	0.150	150	150	0	0	1	-360	360;
	5	6	0.0085	0.072	0.149	0.250	250	250	0	0	1	-360	360;
	4	5	0	0.0625	0	0.250	250	0.250	0	0	1	-360	360;
	];

transmission_cnstr=[20,35,40, 30,15,15,10]/100 ;
num_line=7;
for i=1:num_line
    mpc.branch(i,6:8)=transmission_cnstr(i)*ones(1,3);
end

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	0	0	3	0.11	5	150;
	2	0	0	3	0.11	5	150;
	2	0	0	3	0.11	5	150;
    2	0	0	3	0.11	5	150;
];
