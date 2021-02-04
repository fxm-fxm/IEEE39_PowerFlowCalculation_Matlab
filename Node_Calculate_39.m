function Node_Out=Node_Calculate_39(NodeData,Branch_Out,n,BranchNum,U,Y,V,theta)

Node_Out=zeros(n,6);
Node_Out(:,1:2)=NodeData(:,1:2);
Node_Out(:,4)=NodeData(:,7)+NodeData(:,8).*1i;
for i=1:n
    Node_Out(i,5)=U(i);
    Node_Out(i,6)=theta(i);
end

sum=0;      %,计算平衡节点的发电机输出功率
for i=1:n
    if(NodeData(i,2)==3)
        for j=1:n
            sum=conj(Y(i,j)*V(j))+sum;  
        end
        Node_Out(i,3)=V(i)*sum*100+NodeData(i,7)+NodeData(i,8)*sqrt(-1);
    end
end

SGEN=zeros(n,1);         %计算PV节点发电机的输出功率
for i=1:n
    if(NodeData(i,2)==2)
        for j=1:BranchNum
            if(Branch_Out(j,1)==NodeData(i,1))
                SGEN(i,1)=SGEN(i,1)+Branch_Out(j,3); 
            elseif(Branch_Out(j,2)==NodeData(i,1))
                SGEN(i,1)=SGEN(i,1)+Branch_Out(j,4);
            end
        end
        Node_Out(i,3)=SGEN(i,1)+NodeData(i,7)+NodeData(i,8).*1i;
    end
end  

end