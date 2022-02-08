clear
clc
G1=[1.15,1.46,1.67,1.82,1.94,2.03,2.11,2.18,2.23,2.29,2.33,2.37,2.41,2.44,2.47,2.50,2.53,2.56]
G2=[1.15,1.49,1.75,1.94,2.10,2.22,2.32,2.41,2.48,2.55,2.61,2.66,2.70,2.74,2.78,2.82,2.85,2.85]
grubbstab=input('Please input measuring datas:')
g=input('please input confidence level ')
if g==0.99
    G=G2
else 
    G=G1
end
meangrubbstab =mean(grubbstab)          
stdgrubbstab=std(grubbstab) 
len=length(grubbstab)
for i=1:len
  A(i)=abs(grubbstab(i)-meangrubbstab)
end
Max1=max(A)
location1=find(A==Max1)
if    abs(grubbstab(location1)-meangrubbstab)< G(len-2)*stdgrubbstab 
      disp('no wide error!')
else
       grubbstab(location1)=[]
       A(location1)=[]
       meangrubbstab =mean(grubbstab)          
       stdgrubbstab=std(grubbstab) 
       Max2=max(A)
       location2=find(A==Max2)
       len=length(grubbstab)
       if    abs(grubbstab(location2)-meangrubbstab)< G(len-2)*stdgrubbstab 
             disp('no more wide error!')
       else
       grubbstab(location2)=[]
       end
end
