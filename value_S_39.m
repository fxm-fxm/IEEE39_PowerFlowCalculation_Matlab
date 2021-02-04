function S=value_S_39(U,e,G,B,n)
P=zeros(n,1);
Q=zeros(n,1);
for i=1:n
    for j=1:n
        P(i)=U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)))+P(i);
        Q(i)=U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)))+Q(i);
    end
end
S=complex(P,Q).*100;
end