function Branch_Out=Branch_Calculate_39(BranchData,U,n,BranchNum,Y,V)

z=complex(BranchData(:,3),BranchData(:,4));
y=1i*BranchData(:,5);
ratio=BranchData(:,6);
fbus=BranchData(:,1);
tbus=BranchData(:,2);

%����˫�����ѹ��ѹ����pai�͵�Ч��·
yp0=zeros(n,1);
yp1=zeros(n,1);
yp2=zeros(n,1);
for a=1:BranchNum       
    if(ratio(a)~=0)
        yp0(a)=1/ratio(a)/z(a);
        yp1(a)=(1-ratio(a))/(ratio(a).^2*z(a));
        yp2(a)=(ratio(a)-1)/(ratio(a)*z(a));
    end
end

Branch_Out=zeros(BranchNum,5);
transz=zeros(BranchNum,2);

for k=1:BranchNum               %����ÿ����������ע�빦��,���� Strcal�ĵ�����
    i=fbus(k);
    j=tbus(k);
    if(ratio(k)==0)
        St=U(i)^2*conj(-y(k)/2)+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
        Sz=V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
    else
        St=U(i)^2*conj(-yp1(k))+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
        Sz=U(i)^2*conj(-yp1(k))+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
    end
    transz(k,1)=-Sz*100;
    Branch_Out(k,3)=-St*100;
    Branch_Out(k,1)=fbus(k);      %��Strcal1����ĵ�1,2�зŽ�֧·����ˡ����˱�� 
    Branch_Out(k,2)=tbus(k);
end


for k=1:BranchNum         %����ÿ������߳���ע�빦��,���� Strcal�ĵ�����
    j=fbus(k);
    i=tbus(k);
    if(ratio(k)~=0)
        St=U(i)^2*conj(-yp2(k))+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
        Sz=U(i)^2*conj(-yp2(k))+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
    else
        St=U(i)^2*conj(-y(k)/2)+V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
        Sz=V(i)*(conj(V(i))-conj(V(j)))*conj(Y(i,j));
    end 
    transz(k,2)=-Sz*100;
    Branch_Out(k,4)=-St*100;
end
for k=1:BranchNum
    Branch_Out(k,5)=transz(k,1)+transz(k,2);
end

end