function [temp,temp1,temp2,Ared] = Kron(Avolt,nodes,size)
toElim = nodes;
toRem = setdiff(1:size,toElim);
diff = size-numel(nodes);
Ared = Avolt(toRem,toRem)- (Avolt(toRem,toElim))*inv(Avolt(toElim,toElim))*Avolt(toElim,toRem);
temp = 0;
for i = 1:diff
    temp = temp+Ared(i,i);
end
temp = vpa(temp,4);
Ared = vpa(Ared,4);
% temp=det(Ared);
temp1 = 0;
for i = 1:numel(nodes)
    temp1 = temp1+Avolt(nodes(i),nodes(i));
end
temp1 = vpa(temp1,4);
temp2 = temp+temp1;
end        
