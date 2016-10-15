function result=Ybus(busdata,linedata)
basemva = 100;  accuracy = 0.0001;
%% Y Bus Formation
iota=sqrt(-1);
nl=linedata(:,1);% starting bus 
nr=linedata(:,2); % ending bus
R=linedata(:,3); %Line resistance
X=linedata(:,4); % Line Reactance
Bc=linedata(:,5); % Half line charging admittance
a=linedata(:,6);% Transformer Tappings
nbr=length(nl);% no of branches
nbus=max(max(nl),max(nr));% no of busses
y=zeros(nbr,1);
for i=1:nbr 
    if a<=0 % set any faulty taps to 1
        a=1;
    end
    y(i)=1/(complex(R(i),X(i)));
    Bc(i)=complex(0,-Bc(i));
end
Ybus=zeros(nbus);
for i=1:nbr
   % off diagonal elements
    Ybus(nl(i),nr(i))=Ybus(nl(i),nr(i))-(y(i)/a(i));% The Ybus(nl(i),nr(i))- is added instead of -y(i)/a(i) to account for double lines if any
    Ybus(nr(i),nl(i))=Ybus(nl(i),nr(i));
    %diagonal elements
    Ybus(nl(i),nl(i))=Ybus(nl(i),nl(i))+(y(i)/(a(i)^2))-Bc(i);%tapping on nl side
    Ybus(nr(i),nr(i))=Ybus(nr(i),nr(i))+y(i)-Bc(i);
end
%% NR Load flow
ns=0;% no of slack bus
ng=0;% no of generator bus
kb=busdata(:,2);%bus code
Vm=busdata(:,3);% Volatage Magnitude
delta=busdata(:,4);%angle
delta=delta*(pi/180);% convert to radians
Pd=busdata(:,5);% Real Load
Qd=busdata(:,6);% Reactive Load
Pg=busdata(:,7);% Real Generation
Qg=busdata(:,8);% Reactve Generation
Qmin=busdata(:,9);% Q lower limit
Qmax=busdata(:,10);% Q upper limit
Qsh=busdata(:,11);% Q shunt
P=(Pg-Pd)/basemva;% Real Power
Q=(Qg-Qd+Qsh)/basemva;% Reactive Power
S=(complex(Pg-Pd,Qg-Qd+Qsh))/basemva;% Complex power is stored here
V=complex(Vm.*cos(delta),Vm.*sin(delta));% complex bus voltage
% number of generator and slack busses
for i=1:nbus
    if kb(i)==1
        ns=ns+1;
    end
    if kb(i)==2
        ng=ng+1;
    end
    ngs(i)=ng;% no of generator bus till this bus inclusive of this bus
    nss(i)=ns;% no of slack bus till this bus inclusive of this bus
end
m=(2*nbus)-(2*ns)-ng;% ns is generally 1 ; m is size of the jacobian matrix
maxerror=1; % initial error to start
iter=0;
% start of iteration
clear   DC   J  DX
while maxerror>=accuracy
J=zeros(m,m);% iniitialize jacobian matrix
iter=iter+1;% increase the iteration
for i=1:nbus
    J11=0;% diagonal element of J1
    J22=0;% diagonal element of J2
    J33=0;% diagonal element of J3
    J44=0;% diagonal element of J4
   
    for j=1:nbr
        if nl(j)==i || nr(j)==i% proceed in only if the bus in case now is incident by branch
            if nl(j)==i
                l=nr(j);% if the current bus was nl then nr is l
            else
                l=nl(j);% if the current bus was nr then nl is l
            end
        J11=J11+(Vm(i)*Vm(l)*abs(Ybus(i,l))*sin(angle(Ybus(i,l)) - delta(i)+delta(l)));% these two are outside the next if coz they add up to give Pk and Qk
        J33=J33+(Vm(i)*Vm(l)*abs(Ybus(i,l))*cos(angle(Ybus(i,l)) - delta(i)+delta(l)));
        if kb(i)~=1 % compute diagonal elemnets only if its not slack bus
        J22=J22+(Vm(l)*abs(Ybus(i,l))*cos(angle(Ybus(i,l)) - delta(i)+delta(l)));% still a term to be added
        J44=J44+(Vm(l)*abs(Ybus(i,l))*sin(angle(Ybus(i,l)) - delta(i)+delta(l)));% still a term to be added and this should be minus here 
        end
        % why the next two lines of code are not in the following if loop
        % will be clear at line no 210
             ii=i-nss(i);% ii is the position of the ith bus in jacobian- i.e bus no minus the no of slack busses before it for J1 and J2
             lm=nbus+i-ngs(i)-nss(i)-ns;% position of ith bus in jacoban J3 and J4 - i.e no of busses + bus no - no of slack busss till this bus - no of generator busses till this bus - no of slack busses total
        if kb(i)~=1 && kb(l)~=1% compute off diagonal elements only if neither i nor l is slack bus
            lk=nbus+l-ngs(l)-nss(l)-ns;% position of the  l bus in J2 and J4
            ll=l-nss(l);% positon of l bus in J1 and J3- i.e bis no minus no of slack busses before that
            % off diagonal elements
            J(ii,ll)=-Vm(i)*Vm(l)*abs(Ybus(i,l))*sin(angle(Ybus(i,l)) - delta(i)+delta(l));% off diag of J1
            if kb(l)==0
            J(ii,lk)=Vm(i)*abs(Ybus(i,l))*cos(angle(Ybus(i,l)) - delta(i)+delta(l));% off diag of J2 -> only for l is not generator bus
            end
            if kb(i)==0
            J(lm,ll)=-Vm(i)*Vm(l)*abs(Ybus(i,l))*cos(angle(Ybus(i,l)) - delta(i)+delta(l));% off diag for J3 -> only if i is not generator bus
            end
            if kb(l)==0 && kb(i)==0
            J(lm,lk)=-Vm(i)*abs(Ybus(i,l))*sin(angle(Ybus(i,l)) - delta(i)+delta(l));% off diag for J4 -> only if i and l are not generator bus
            end
        end
        end
    end
    % calcuate power mismatch 
    Pk=((Vm(i)^2)*(abs(Ybus(i,i)))*cos(angle(Ybus(i,i))))+J33;% Real Power of this bus at this iteration-1
    Qk=-((Vm(i)^2)*(abs(Ybus(i,i)))*sin(angle(Ybus(i,i))))-J11;% Reactive
%     Power of this bus at this iteration-1
    if kb(i)==1% for slack bus update real and reactive power
        P(i)=Pk;% dont update for other busses as it will make mismatch to 0 even at no convergence
        Q(i)=Qk;
        S(i)=complex(Pk,Qk);
    end
    if kb(i)==2% for generator bus
        Q(i)=Qk;% update Q for gen bus
        if Qmax(i)~=0 % i.e if there is an upper limit on Q gen here at this gen bus
             Qgc=(Q(i)*basemva)+Qd(i)-Qsh(i);% effective Qgc= Q calc + Q demand - Q shunt cap -> * basemva since Q(i) is in pu
             if iter<=7 || iter>2% between 2nd and 7th iteration check for Qgc limits
                 if Qgc<Qmin(i)
                     Vm(i)=Vm(i)+0.01;% increasing Vm increases Qgc by a lot -> effects the Qgc in +ve way by a lot- helps bring in limits
                 elseif Qg>Qmax(i)
                     Vm(i)=Vm(i)-0.01;% decreasing Vm decreases Qgc by a lot -> effects the Qgc in -ve way by a lot- helps bring in limits
                 end
             end
        end
    end
    % put diagonal elemnts in place
    % Put power mismatches in DC matrix 
    if kb(i)~=1
        J(ii,ii)=J11;% diagonal element of J1 due to i bus i exists if its not slack bus
        DC(ii)=P(i)-Pk;% calculate real power mismatch and place at the appropriate place for all gen and load busses- > not slack bus
    end
    if kb(i)==0% other diagonal elemnts exist only for load bus
        J(ii,lm)=(2*(Vm(i))*(abs(Ybus(i,i)))*(cos(angle(Ybus(i,i)))))+J22;% diag elemnt of J2 -> position of i bus in J2 x Position of i bus in J3
        J(lm,ii)=J33;% diag elemnt of J3-> position of i bus in J3 x Position of i bus in J1
        J(lm,lm)=-(2*(Vm(i))*(abs(Ybus(i,i)))*(sin(angle(Ybus(i,i)))))-J44;% diag elemnt of J4 -> position of i bus in J3 x Position of i bus in J3
        DC(lm)=Q(i)-Qk;% Reactive Power mismatch only for load bus
    end
end
%DX is angle and voltage mismatch matrix
% transpose is because DC was a row matric initially
% '\' is fast inverse
DX=J\DC';
for i=1:nbus
    ii=i-nss(i);% same positional as explained above
    lm=nbus+i-ngs(i)-nss(i)-ns;
    if kb(i)~=1% for all busses except slack bus
        delta(i)=delta(i)+DX(ii);% update the delta
    end
    if kb(i)==0% only for load bus
        Vm(i)=Vm(i)+DX(lm);% update the Voltage
    end
end
maxerror=max(abs(DC));% the power mismatch is checked
end
V=complex(Vm.*cos(delta),Vm.*sin(delta));% complex bus voltage
deltad=180/pi*delta;% convert to degrees

for i = 1:nbus%  slack bus was updated at every iteration
     if kb(i) == 1% for load bus
     S(i)=complex(P(i),Q(i));
     Pg(i)=(P(i)*basemva)+Pd(i);
     Qg(i)=(Q(i)*basemva)+Qd(i)-Qsh(i);
     elseif  kb(i) ==2% for gen bus
     S(i)=complex(P(i),Q(i));
     Qg(i)=(Q(i)*basemva)+Qd(i)-Qsh(i);
     end
yload(i) = (complex(Pd(i),(-Qd(i)+Qsh(i))))/(basemva*Vm(i)^2);% load = S* /V^2
end
busdata(:,3)=Vm'; busdata(:,4)=deltad';
Pgt = sum(Pg);  Qgt = sum(Qg); Pdt = sum(Pd); Qdt = sum(Qd); Qsht = sum(Qsh);
angle1=deltad*pi/180;
i=sqrt(-1);
V=Vm.*exp(i*angle1);
result=Vm;