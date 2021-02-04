function [count,J,U,e]=Newton_39(n,m,G,B,U,e,P,Q,fx,oe,oU)


count=1 ;%计算迭代次数

while max(abs(fx))>1e-5
    oP=zeros(n-1,1);
    oQ=zeros(m,1);
    H=zeros(n-1,n-1);
    N=zeros(n-1,m);
    M=zeros(m,n-1);
    L=zeros(m,m);
    count
    for i=1:n-1
        for j=1:n 
            oP(i)=oP(i)+U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)));
        end
        oP(i)=P(i)-oP(i);
    end
    for i=1:m
        for j=1:n
            oQ(i)=oQ(i)+U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)));
        end
        oQ(i)=Q(i)-oQ(i);
    end
    fx=[oP;oQ];
    %求雅克比矩阵
    %当i~=j时候求H,N,M,L 如下：
    %H
    for i=1:n-1
        for j=1:n-1
            if i~=j 
                H(i,j)=-U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)));
            end
        end
    end
    %N
    for i=1:n-1
        for j=1:m
            if i~=j 
                N(i,j)=-U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)));
            end
        end
    end
    %M
    for i=1:m
        for j=1:n-1
            if i~=j 
                M(i,j)=U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)));
            end
        end
    end
    %L
    for i=1:m
        for j=1:m
            if i~=j 
                L(i,j)=-U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)));
            end
        end
    end
    %当i=j 时H,N,M,L如下：
    %H
    for i=1:n-1
        for j=1:n
            if i~=j
                H(i,i)=H(i,i)+U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)));
            end
        end
    end
    %N  M   L
    for i=1:m
        for j=1:n
            if i~=j                    
                N(i,i)=N(i,i)-U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)));
                M(i,i)=M(i,i)-U(i)*U(j)*(G(i,j)*cos(e(i)-e(j))+B(i,j)*sin(e(i)-e(j)));
                L(i,i)=L(i,i)-U(i)*U(j)*(G(i,j)*sin(e(i)-e(j))-B(i,j)*cos(e(i)-e(j)));
            end
        end
        N(i,i)=N(i,i)-2*(U(i))^2*G(i,i);
        L(i,i)=L(i,i)+2*(U(i))^2*B(i,i);
    end
    
    J=[H,N;M,L]; %J 为雅克比矩阵
    ox=-((inv(J))*fx);
    for i=1:n-1
        oe(i)=ox(i);
        e(i)=e(i)+oe(i); 
    end
    for i=1:m
        oU(i)=ox(i+n-1)*U(i);
        U(i)=U(i)+oU(i);
    end
    count=count+1;
    U,e
end
end