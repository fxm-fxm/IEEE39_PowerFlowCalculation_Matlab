clear;clc

%��ȡ�ڵ㡢֧·����
NodeData=xlsread('Node_Data_39.xlsx');            %��ȡ�ڵ�����
BranchData=xlsread('Branch_Data_39.xlsx');        %��ȡ֧·����
%����ڵ���n��PQ�ڵ���m��֧·��BranchNum
n=size(NodeData,1);   %�ڵ���n
%PQ�ڵ���m
for a=1:n
    if NodeData(a,2)~=1
        m=a-1;
        break;
    end
end
BranchNum=size(BranchData,1);    %֧·��BranchNum

%���㵼�ɾ���Y
Y=Y_calculate_39(NodeData,BranchData,n,BranchNum);
G=real(Y);
B=imag(Y);

%����ֵ
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

%�����ڵ��ѹ�����

[count,J,U,e]=Newton_39(n,m,G,B,U,e,P,Q,fx,oe,oU);
theta=e.*180/pi

V=zeros(n,1);           %���нڵ��ѹ��������
for i=1:n
    V(i)=U(i)*cos(e(i))+U(i)*sin(e(i))*1i;
end

%��ڵ�ע��ľ�����
S=value_S_39(U,e,G,B,n)

%�����������
fprintf('��·��֧·������������\n')
fprintf('       ������          �������            ��˹���           ���˹���           �������') 
Branch_Out=Branch_Calculate_39(BranchData,U,n,BranchNum,Y,V)


fprintf('�ڵ�ĳ���������:\n')
fprintf('      �ڵ����            �ڵ�����        ������������      �������չ���         ��ѹ��ֵ         ��ѹ��λ(��)') 
Node_Out=Node_Calculate_39(NodeData,Branch_Out,n,BranchNum,U,Y,V,theta)

