function Ybus = Kron(Ybus,nodes)
for k=1:numel(nodes)
    for i=1:size(Ybus,1)
        if i~=nodes(k)
        for j=1:size(Ybus,2)
            if j~=nodes(k)
            Ybus(i,j)=Ybus(i,j)-Ybus(i,nodes(k))*Ybus(nodes(k),j)/Ybus(nodes(k),nodes(k));
            end
        end
        end
    end
end
    Ybus(nodes,:)=[];
    Ybus(:,nodes)=[];
    Ybus=round(Ybus*1000)/1000;
end
        
        