% linedata=[  
% 1	2	0.012356522	0.261709075	0	1
% 1	3	0.021782783	0.108784284	0	1
% 1	4	0.008237681	0.041139383	0	1
% 3	5	0.02436215	0.228332438	0	1
% 3	11	0.029773333	0.348689486	0	1
% 4	6	0.016475362	0.082278767	0	1
% 4	7	0.000235362	0.001175411	0	1
% 5	8	0.001171154	0.0058488	0	1
% 5	9	0.000780769	0.0038992	0	1
% 9	10	0.001990962	0.00994296	0	1
% 8	16	0.010817048	0.45402087	0	1
% 8	17	0.021510192	0.507422955	0	1
% 9	18	0.021510192	0.307422955	0	1
% 10	19	0.019519231	0.297479995	0	1
% 10	20	0.005413333	0.127034452	0	1
% 6	13	0.018828986	0.62736621	0	1
% 6	14	0.056016232	0.479747807	0	1
% 7	15	0.002953797	0.121418074	0	1
% 8	21	0	0.1	0	1
% 4	12	0.001406516	0.007024211	0	1
% 7	22	0.001176812	0.005877055	0	1
% 2	23	0.017652174	0.088155822	0	1
% ];
linedata = [1	4	0	0.0576	0 1
	4	5	0.017	0.092	0.158 1
	5	6	0.039	0.17	0.358 1
	3	6	0	0.0586	0 1
	6	7	0.0119	0.1008	0.209 1
	7	8	0.0085	0.072	0.149 1
	8	2	0	0.0625	0	1
	8	9	0.032	0.161	0.306 1
	9	4	0.01	0.085	0.176 1];
%%
j=sqrt(-1);
FB=linedata(:,1); %From Bus%
TB=linedata(:,2); %To Bus%
r=linedata(:,3); %Resistance%
x=linedata(:,4);%Reactance%
b=linedata(:,5);%Half line Charging susceptance%
a=linedata(:,6);%Transformer tap ratio%

nlines=length(FB);
nbranch=length(FB);
z=r+j*x;
y=1./z;
b=j*b;

nbus=max(max(FB),max(TB));

d=zeros(nlines,1);
y=vertcat(y,b*0,b*0); %to include the elements of half line charging capacitances%
TB=vertcat(TB,FB,TB);
FB=vertcat(FB,d,d);
nlines=nlines*3;
A=zeros(nlines,nbus);
for k=1:nlines
    if(FB(k)~=0)
           A(k,FB(k))=1;
    end
    A(k,TB(k))=-1;
end

y1=diag(y);
ybus=A'*y1*A;
%%
elem = 2*size(ybus,1);
Fin = zeros(elem,elem);
for k = 1:elem/2
    for l = 1:elem/2
    Fin(2*k-1,2*l-1) = imag(ybus(k,l));
    Fin(2*k-1,2*l) = real(ybus(k,l));
    end
end
for k = 1:elem/2
    for l = 1:elem/2
    Fin(2*k,2*l-1) = real(ybus(k,l));
    Fin(2*k,2*l) = -imag(ybus(kl));
    end
end

%%
% 
% % Add load impedances to diagonal elemets
% Z2 = 7.975+ 1i*4.1341;
% Z11 = 52.8 + 1i*9.6 ; 
% Z12 = 60.6498 + 1i*38.982;
% Z13 = 56.9733 + 1i*32.0475;
% Z14 = 9.3432 + 1i*8.4565;
% Z15 = 3.9012 + 1i*1.8726;
% Z16 = 109.49819 + 1i* 51.0949;
% Z17 = 85.2792 + 1i*6.09;
% Z18 = 38.009 + 1i*13.5747;
% Z19  = 11.9266 + 1i*6.422;
% Z21 = -0.1 - 1i*0.01;
% 
% Loads = [0; 1./Z2; 0; 1./Z11; 1./Z12; 1./Z13; 1./Z14; 1./Z15; 1./Z16; 1./Z17; 1./Z18; 1./Z19; 0];
% 
% %%
% 
% ybus = ybus + (diag(Loads));
% 
% Nodes =  setdiff(1:13,[2 3 7]);
% 
% Yred=Kron(ybus,Nodes);
% 
% Yshunt = sum(Yred,1);