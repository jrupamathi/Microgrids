function mpc = caseMicro
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
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
1	1	0	0	0	0	1	1	0	13.8	1	1.2	0.98
2	1	1.186425	0.61481875	0	0	1	1	0	0.46	1	1.2	0.98
3	1	0	0	0	0	1	1	0	13.8	1	1.2	0.98
4	1	0	0	0	0	1	1	0	13.8	1	1.2	0.98
5	1	0	0	0	0	1	1	0	4.16	1	1.2	0.98
6	1	0	0	0	0	1	1	0	13.8	1	1.2	0.98
7	1	0	0	0	0	1	1	0	13.8	1	1.2	0.98
8	1	0	0	0	0	1	1	0	4.16	1	1.2	0.98
9	1	0	0	0	0	1	1	0	4.16	1	1.2	0.98
10	1	0	0	0	0	1	1	0	4.16	1	1.2	0.98
11	1	0.22	0.01	0	0	1	1	0	0.46	1	1.2	0.98
12	1	0.14	0.09	0	0	1	1	0	0.46	1	1.2	0.98
13	1	0.16	0.09	0	0	1	1	0	0.46	1	1.2	0.98
14	1	0.706425	0.63981875	0	0	1	1	0	0.46	1	1.2	0.98
15	1	2.5	1.2	0	0	1	1	0	0.46	1	1.2	0.98
16	1	0.09	0.042	0	0	1	1	0	0.46	1	1.2	0.98
17	1	0.14	0.01	0	0	1	1	0	0.208	1	1.2	0.98
18	1	0.28	0.1	0	0	1	1	0	0.208	1	1.2	0.98
19	1	0.78	0.42	0	0	1	1	0	0.208	1	1.2	0.98
20	1	0	0	0	0	1	1	0	2.4	1	1.2	0.98
21	1	-3.5	-0.01	0	0	1	1	0	2.4	1	1.2	0.98
22	3	0	0	0	0	1	1	0	13.8	1	1.2	0.98
23	2	0	0	0	0	1	1	0	0.46	1	1.2	0.98
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
22	0	0	4	-4	1	4	1	4	0	0	0	0	0	0	0	0	0	0	0	0
23	0.6	0	1	-1	1	4	1	1	0	0	0	0	0	0	0	0	0	0	0	0
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
1    2    0.0124    0.2617    0.0100    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
1    3    0.0218    0.1088    0.0042    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
1    4    0.0082    0.0411    0.0016    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
3    5    0.0244    0.2283    0.0087    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
3   11    0.0298    0.3487    0.0133    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
4    6    0.0165    0.0823    0.0031    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
4    7    0.0002    0.0012    0.0000    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
5    8    0.0012    0.0058    0.0002    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
5    9    0.0008    0.0039    0.0001    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
9   10    0.0020    0.0099    0.0004    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
8   16    0.0108    0.4540    0.0173    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
8   17    0.0215    0.5074    0.0194    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
9   18    0.0215    0.3074    0.0117    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
10   19    0.0195    0.2975    0.0114    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
10   20    0.0054    0.1270    0.0049    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
6   13    0.0188    0.6274    0.0240    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
6   14    0.0560    0.4797    0.0183    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
7   15    0.0030    0.1214    0.0046    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
8   21         0    0.1000    0.0038    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
4   12    0.0014    0.0070    0.0003    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
7   22    0.0012    0.0059    0.0002    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.0000
2   23    0.0177    0.0882    0.0034    7.0000    7.0000    7.0000         0         0    1.0000 -360.0000  360.00000
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