function Y=Y_calculate_39(NodeData,BranchData,n,BranchNum)

Y=zeros(n);
z=complex(BranchData(:,3),BranchData(:,4));
y=1i*BranchData(:,5);
ratio=BranchData(:,6);
fbus=BranchData(:,1);
tbus=BranchData(:,2);

%����˫�����ѹ��ѹ����pai�͵�Ч��·
yp0=zeros(BranchNum,1);
yp1=zeros(BranchNum,1);
yp2=zeros(BranchNum,1);
for a=1:BranchNum       
    if(ratio(a)~=0)
        yp0(a)=1/ratio(a)/z(a);
        yp1(a)=(1-ratio(a))/(ratio(a).^2*z(a));
        yp2(a)=(ratio(a)-1)/(ratio(a)*z(a));
    end
end

%��·�ĵ��ɾ���
for a=1:BranchNum  
    if(ratio(a)==0)
        Y(fbus(a),fbus(a))=Y(fbus(a),fbus(a))+1/z(a)+0.5*y(a);
        Y(fbus(a),tbus(a))=Y(fbus(a),tbus(a))-1/z(a);
        Y(tbus(a),fbus(a))=Y(fbus(a),tbus(a));
        Y(tbus(a),tbus(a))=Y(tbus(a),tbus(a))+1/z(a)+0.5*y(a);
    end
end

%�޸ĺ�ĵĵ��ɾ���
for a=1:BranchNum  
    if(ratio(a)~=0)
     Y(fbus(a),fbus(a))=Y(fbus(a),fbus(a))+yp0(a)+yp1(a);
     Y(fbus(a),tbus(a))=Y(fbus(a),tbus(a))-yp0(a);
     Y(tbus(a),fbus(a))=Y(fbus(a),tbus(a));
     Y(tbus(a),tbus(a))=Y(tbus(a),tbus(a))+yp0(a)+yp2(a);
    end
end

%�Եص���
for a=1:n
    Y(a,a)=Y(a,a)+complex(NodeData(a,9),NodeData(a,10));
end
end