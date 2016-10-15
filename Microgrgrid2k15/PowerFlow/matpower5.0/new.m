%get the test case
run 'ieeecase30.m';
%Do modifications here
Vbase=NR(busdata,linedata);
nbr=length(linedata);
VPI=zeros(nbr,1);
%for j=1:nbr
j=5;
    branchdata=[linedata(1:j-1,:);linedata(j+1:length(linedata),:)]; 
    V=NR(busdata,branchdata);
    VPI=sum(((V-Vbase)/0.2).^4);
%end