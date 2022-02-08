function bd=dfun3(t,b);
bd=zeros(2,1);
bd(1)=b(2);
bd(2)=-b(1)-b(2)+b(1)^3;