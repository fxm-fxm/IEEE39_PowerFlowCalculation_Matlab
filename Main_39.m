clear;clc

%读取节点、支路数据
NodeData=xlsread('Node_Data_39.xlsx');            %读取节点数据
BranchData=xlsread('Branch_Data_39.xlsx');        %读取支路数据
%计算节点数n、PQ节点数m、支路数BranchNum
n=size(NodeData,1);   %节点数n
%PQ节点数m
for a=1:n
    if NodeData(a,2)~=1
        m=a-1;
        break;
    end
end
BranchNum=size(BranchData,1);    %支路数BranchNum

%计算导纳矩阵Y
Y=Y_calculate_39(NodeData,BranchData,n,BranchNum);
G=real(Y);
B=imag(Y);

%赋初值
S=zeros(n,1);
for a=1:n
    S(a)=0.01*(NodeData(a,5)-NodeData(a,7)-NodeData(a,8)*1i);
end
P=real(S);
Q=imag(S);

U=ones(n,1);
for a=m+1:n
    U(a)=NodeData(a,3);
end
e=zeros(n,1);
fx=ones(n+m-1,1);
oe=zeros(n+m-1,1);oU=zeros(n+m-1,1);

%求解各节点电压和相角

[count,J,U,e]=Newton_39(n,m,G,B,U,e,P,Q,fx,oe,oU);
theta=e.*180/pi

V=zeros(n,1);           %进行节点电压向量运算
for i=1:n
    V(i)=U(i)*cos(e(i))+U(i)*sin(e(i))*1i;
end

%求节点注入的净功率
S=value_S_39(U,e,G,B,n)

%计算输出矩阵
fprintf('线路、支路潮流计算结果：\n')
fprintf('       入端序号          出端序号            入端功率           出端功率           功率损耗') 
Branch_Out=Branch_Calculate_39(BranchData,U,n,BranchNum,Y,V)


fprintf('节点的朝流计算结果:\n')
fprintf('      节点序号            节点类型        发电机输出功率      负荷吸收功率         电压幅值         电压相位(度)') 
Node_Out=Node_Calculate_39(NodeData,Branch_Out,n,BranchNum,U,Y,V,theta)

