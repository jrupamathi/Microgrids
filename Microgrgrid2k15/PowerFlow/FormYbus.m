% Bus 1 - 1; Bus2 -2; Bus 5 - 3 ; Bus 11 - 4; Bus 12 - 5; Bus 13 - 6; Bus 14 - 7
%Bus 15 - 8; Bus 16 - 9; Bus 17 - 10; Bus 18 - 11; Bus 19 - 12 ; Bus21 - 13
linedata=[  1	2	4.55E-05	0.1	0.01    1
1	3	5.75E-05	1.00E-01	0.01    1
1	4	0.0021	0.102	0.01    1
1	5	5.68E-04	0.1019	0.01    1
1	6	6.00E-04	0.102	0.01    1
1	7	0.0015	0.1048	0.01    1
1	8	1.85E-05	0.1	0.01    1
3	9	2.95E-04	0.101	0.01    1
3	10	0.0014	0.1046	0.01    1
3	11	0.0014	0.1046	0.01    1
3	12	0.0014	0.1046	0.01    1
3	13	7.14E-06	0.1	0.01    1
];

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

% Add load impedances to diagonal elemets
Z2 = 7.975+ 1i*4.1341;
Z11 = 52.8 + 1i*9.6 ; 
Z12 = 60.6498 + 1i*38.982;
Z13 = 56.9733 + 1i*32.0475;
Z14 = 9.3432 + 1i*8.4565;
Z15 = 3.9012 + 1i*1.8726;
Z16 = 109.49819 + 1i* 51.0949;
Z17 = 85.2792 + 1i*6.09;
Z18 = 38.009 + 1i*13.5747;
Z19  = 11.9266 + 1i*6.422;
Z21 = -0.1 - 1i*0.01;

Loads = [0; 1./Z2; 0; 1./Z11; 1./Z12; 1./Z13; 1./Z14; 1./Z15; 1./Z16; 1./Z17; 1./Z18; 1./Z19; 0];

%%

ybus = ybus + (diag(Loads));

Nodes =  setdiff(1:13,[2 3 7]);

Yred=Kron(ybus,Nodes);

Yshunt = sum(Yred,1);