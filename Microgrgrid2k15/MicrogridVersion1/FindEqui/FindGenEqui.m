%SEtting up equations in syms for Gen22 and loading PF data to get ueq and
%xeq
%Input which status - 1: Interconected 0: Isolated
% Gen 22 or 23
%stability: 1. stable operating point o.w. unstable operating point
%Outputs x0eq and ueq according to the order needed by dynamics
function [x10, u10, k] = FindGenEqui(status,Gen,stability,PVbus,solver,file1,file2)
load('G22.mat','Lad_G22','Laf_G22','Laq_G22','Ldf_G22','LSd_G22','LSq_G22','LRD_G22','LF_G22','LRQ_G22','RS_G22','Rkd_G22','RF_G22','H_G22','B_G22','Rkq_G22',...
    'K1_G22','K2_G22','K3_G22','delta_G22_ref','omega_G22_ref','iF_G22_ref',...
    'tauL_G22_ref','vR_G22_ref');

load('G23.mat','Lad_G23','Laf_G23','Laq_G23','Ldf_G23','LSd_G23','LSq_G23','LRD_G23','LF_G23','LRQ_G23','RS_G23','Rkd_G23','RF_G23','H_G23','B_G23','Rkq_G23',...
    'K1_G23','K2_G23','K3_G23','delta_G23_ref','omega_G23_ref','iF_G23_ref',...
    'tauL_G23_ref','vR_G23_ref');
        
% addpath('RedBookBranchDataFile/')
% status = 'inter';
% switch solver 
%     case 'NETSS'
%         switch status
%             case 'inter'
%                 filename1 = 'RedBookBranchDataFile/Micro15_CONNgen.txt';
%                 filename2 = 'RedBookBranchDataFile/Microgrid15_CONNvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%             case 'iso'
%                 filename1 = 'RedBookBranchDataFile/Micro15_islandgen.txt';
%                 filename2 = 'RedBookBranchDataFile/Microgrid15_islandvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%         end
%     case 'MATPOWER'
%         switch status
%             case 'inter'
%                 filename1 = 'RedBookBranchDataFile/MATMicro15_CONNgen.txt';
%                 filename2 = 'RedBookBranchDataFile/MATMicrogrid15_CONNvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%             case 'iso'
%                 filename1 = 'RedBookBranchDataFile/MATMicro15_islandgen.txt';
%                 filename2 = 'RedBookBranchDataFile/MATMicrogrid15_islandvolt.txt';
%                 file1 = load(filename1,'variable');
%                 file2 = load(filename2,'variable');
%         end
% end

%%
% Gen = 22;
% Gen22Equi
switch Gen
    case 22
         H=H_G22;
        B = B_G22;
        rs=RS_G22;
        rr=Rkd_G22;
        rf=RF_G22;
        Ld=LSd_G22;
        LD=LRD_G22;
        LF=LF_G22;
        Lq=LSq_G22;
        LQ=LRQ_G22;
        Lad=Lad_G22;
        Laf=Laf_G22;
        Ldf=Ldf_G22;
        Laq=Laq_G22;
        rq = Rkq_G22;
        F = B;
        ind1 = find(file1(:,1) == 22);
        Pref = file1(ind1,3);Qref = file1(ind1,4);
        ind2 = find(file2(:,1) == 22);
        Vmagref = file2(ind2,2);Vangref = file2(ind2,3);
        if strcmp(PVbus, 'slack')
            Pref = file1(ind1,5);Qref = file1(ind1,6);
            Vmagref = file2(ind2,4);Vangref = file2(ind2,5);
        end
     case 23
        H=H_G23;
        B = B_G23;
        rs=RS_G23;
        rr=Rkd_G23;
        rf=RF_G23;
        Ld=LSd_G23;
        LD=LRD_G23;
        LF=LF_G23;
        Lq=LSq_G23;
        LQ=LRQ_G23;
        Lad=Lad_G23;
        Laf=Laf_G23;
        Ldf=Ldf_G23;
        Laq=Laq_G23;
        rq = Rkq_G23;
        F = B;
        ind1 = find(file1(:,1) == 23);
        Pref = file1(ind1,3);Qref = file1(ind1,4);
        ind2 = find(file2(:,1) == 23);
        Vmagref = file2(ind2,2);Vangref = file2(ind2,3);
        if strcmp(PVbus, 'slack')
            Pref = file1(ind1,5);Qref = file1(ind1,6);
            Vmagref = file2(ind2,4);Vangref = file2(ind2,5);
        end
end
clear delta omega iD iFd iQ vf Tm vds vqs Id Iq vds vqs 
syms delta omega iD iQ iFd vf Tm vds vqs Id Iq real
syms vds vqs real;

%%base frequency
wb = 377;
omega0 = 1;

%%
  dIddt=-wb*(iFd*((rf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Laf*omega*cos(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (LQ*Lad*omega*cos(delta))/(Laq^2 - LQ*Lq)) - vds*(LQ/(2*(Laq^2 - LQ*Lq)) + cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Iq*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + iQ*((Laq*rq*cos(delta))/(Laq^2 - LQ*Lq) - (Laq*omega*sin(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*(rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - vqs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            dIqdt=wb*(iFd*((rf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Laf*omega*sin(delta))/(Laq^2 - LQ*Lq)) + iD*((rr*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (LQ*Lad*omega*sin(delta))/(Laq^2 - LQ*Lq)) - vqs*(cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + Id*(omega - omega0 + omega*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) - (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + rs*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - omega*cos(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) - iQ*((Laq*rq*sin(delta))/(Laq^2 - LQ*Lq) + (Laq*omega*cos(delta)*(Ldf^2 - LD*LF))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*(rs*cos(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) - rs*(LQ/(2*(Laq^2 - LQ*Lq)) - (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + omega*sin(2*delta)*((LQ*Ld)/(2*(Laq^2 - LQ*Lq)) + (Lq*(Ldf^2 - LD*LF))/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)))) + vds*sin(2*delta)*(LQ/(2*(Laq^2 - LQ*Lq)) + (Ldf^2 - LD*LF)/(2*(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld))) + (vf*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diDdt=wb*(Iq*((rs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Id*((rs*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vqs*cos(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vds*sin(delta)*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Laf^2 - LF*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iFd*rf*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Laq*iQ*omega*(LF*Lad - Laf*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diFddt=-wb*(Id*((rs*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Lq*omega*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) - Iq*((rs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (Lq*omega*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld)) + (vf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (vqs*cos(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (vds*sin(delta)*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) + (iFd*rf*(Lad^2 - LD*Ld))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (iD*rr*(Lad*Laf - Ld*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld) - (Laq*iQ*omega*(LD*Laf - Lad*Ldf))/(LF*Lad^2 - 2*Lad*Laf*Ldf + LD*Laf^2 + Ld*Ldf^2 - LD*LF*Ld));
            diQdt=-wb*(Id*((Laq*rs*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*Ld*omega*sin(delta))/(Laq^2 - LQ*Lq)) + Iq*((Laq*rs*sin(delta))/(Laq^2 - LQ*Lq) - (Laq*Ld*omega*cos(delta))/(Laq^2 - LQ*Lq)) + (Laq*vds*cos(delta))/(Laq^2 - LQ*Lq) + (Laq*vqs*sin(delta))/(Laq^2 - LQ*Lq) - (Lq*iQ*rq)/(Laq^2 - LQ*Lq) + (Lad*Laq*iD*omega)/(Laq^2 - LQ*Lq) + (Laf*Laq*iFd*omega)/(Laq^2 - LQ*Lq));
            ddeltadt=wb*(omega - omega0);
            domegadt=-(Id*vds - Tm +F*omega + Iq*vqs)/(2*H);
            
x=[delta;omega;Id;Iq;iD;iFd;iQ];u=[Tm;vf]; 
 xdot = [ ddeltadt; domegadt; dIddt; dIqdt; diDdt; diFddt; diQdt];
%%
 Jx=jacobian(xdot,x);
Ju=jacobian(xdot,u);

%For finding equilibrium
Vmag = Vmagref; Vang = Vangref;
Vdref = Vmag*cos(Vang);
Vqref = Vmag*sin(Vang);

vd = Vdref;vq=Vqref; % From Load flow
I=solve([vd*Id+ vq*Iq ;vq*Id- vd*Iq] - [Pref;Qref]); % From Load flow
step1=subs(xdot,[Id;Iq;vds;vqs],[I.Id;I.Iq;vd;vq]);
Equi=solve(step1);
Tm0=Equi.Tm; delta0=Equi.delta; iD0=Equi.iD; iFd0=Equi.iFd; iQ0=Equi.iQ; 
omega0=Equi.omega; vf0=Equi.vf;

if stability == 1
    %Stable Equilibrium
    Tm0s=Tm0(2); delta0s=delta0(2);iD0s=iD0(2); iFd0s=iFd0(2); iQ0s= iQ0(2);
    omega0s=omega0(2); vf0s=vf0(2);
    x0s=[delta0s;omega0s;I.Id;I.Iq;iD0s;iFd0s;iQ0s];
    As=subs(Jx,x,x0s);
    As=subs(As,[vds;vqs;vf],[vd;vq;vf0s]);

    Bs=subs(Ju,x,x0s);
    Bs=subs(Bs,[vds;vqs;vf],[vd;vq;vf0s]);
    As=double(As);Bs=double(Bs);

    ks=lqr(As,Bs,diag([1;1;1;1;1;1;1]),1*diag([1;1]));

%     Acls=As-Bs*ks;
    K = zeros(2,7); K(1,1) = ks(1,1); K(1,2) = ks(1,2); K(2,6) = K(2,6);
    Acls = As - Bs*K;
    vpa(eig(Acls),4)
    %Reorder for our dynamics
    x10 = [x0s(3:4);x0s(5);x0s(7);x0s(6);x0s(1:2)];
    u10 = vpa([Tm0s;vf0s],4);
    k = [ks(1,1);ks(1,2);ks(2,6)];
else
 %%
%UnStable Equilibrium
    Tm0u=Tm0(1); delta0u=delta0(1);iD0u=iD0(1); iFd0u=iFd0(1); iQ0u= iQ0(1);
    omega0u=omega0(1); vf0u=vf0(1);

    x0u=[delta0u;omega0u;I.Id;I.Iq;iD0u;iFd0u;iQ0u];
    Au=subs(Jx,x,x0u);
    Au=subs(Au,[vds;vqs;vf],[vd;vq;vf0u]);

    Bu=subs(Ju,x,x0u);
    Bu=subs(Bu,[vds;vqs;vf],[vd;vq;vf0u]);
    Au=double(Au);Bu=double(Bu);
    ku=lqr(Au,Bu,diag([1;1;1;1;1;1;1]),diag([1;1]));
    K = zeros(2,7); K(1,1) = ku(1,1); K(1,2) = ku(1,2); K(2,6) = ku(2,6);
    Aclu = Au - Bu*K;
    vpa(eig(Aclu),4)
    %Reorder for our dynamics
    x10 = [x0u(3:4);x0u(5);x0u(7);x0u(6);x0u(1:2)];
    u10 = vpa([Tm0u;vf0u],4);
    k = [ku(1,1);ku(1,2);ku(2,6)];
end