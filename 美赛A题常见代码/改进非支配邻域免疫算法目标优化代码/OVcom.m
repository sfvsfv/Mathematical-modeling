function pa=OVcom(v,NO)
% OVcom: define the test problems,compute the objective values to v
% usage:
%        pa=OVcom(v,NO);
% where
%        NO:  the serial number of test problem
%        v:   the solutions in decision space
%        pa:  the solutions in objective space

% Authors: Maoguo Gong and Licheng Jiao
% April 7, 2006
% Copyright (C) 2005-2007 by Maoguo Gong (e-mail: gong@ieee.org)
%--------------------------------------------------------------------------
switch NO
%%1-3 are MISA's problems    
case 1 %%  MISA's Example 1
    x=v(:,1);y=v(:,2);
    f1=x; 
    f2=(1+10*y).*(1-(x./(1+10*y)).^2-(x./(1+10*y)).*sin(2*pi*4*x));
    pa=[f1,f2];
case 2%%  MISA's Example 2
    x=v;
    f1=zeros(size(v,1),1);
    f2=(x-5).^2;
    sx1=find(x<=1);x1=x(sx1);f1(sx1)=-x1;
    sx2=find(x>1&x<=3);x2=x(sx2);f1(sx2)=-2+x2;
    sx3=find(x>3&x<=4);x3=x(sx3);f1(sx3)=4-x3;
    sx4=find(x>4);x4=x(sx4);f1(sx4)=x4-4;
    pa=[f1,f2];
case 3 %% MISA's Example 5
    x=v(:,1);y=v(:,2);z=v(:,3);
    f1=-10*exp(-0.2*sqrt(x.^2+y.^2))-10*exp(-0.2*sqrt(y.^2+z.^2));
    f2=((abs(x)).^0.8+5*sin((x).^3))+((abs(y)).^0.8+5*sin((y).^3))+((abs(z)).^0.8+5*sin((z).^3));
    pa=[f1,f2];
    
%%4-18 are Veldhuizen's probems
case 4 %%  Binh (1)
    x=v(:,1);y=v(:,2);
    f1=x.^2+y.^2;
    f2=(x-5).^2+(y-5).^2;
    pa=[f1,f2];
case 5 %%  Binh (3)
    x=v(:,1);y=v(:,2);
    f1=x-10.^6;
    f2=y-2*10.^(-6);
    f3=x.*y-2;
    pa=[f1,f2,f3];
case 6 %%  Fonseca
    x=v(:,1);y=v(:,2);
    f1=1-exp(-(x-1).^2-(y+1).^2);
    f2=1-exp(-(x+1).^2-(y-1).^2);
    pa=[f1,f2]; 
case 7 %%  Fonseca (2)
    x=v(:,1);y=v(:,2);z=v(:,3);
    f1=1-exp(-(x-1/sqrt(3)).^2-(y-1/sqrt(3)).^2-(z-1/sqrt(3)).^2);
    f2=1-exp(-(x+1/sqrt(3)).^2-(y+1/sqrt(3)).^2-(z+1/sqrt(3)).^2);
    pa=[f1,f2];
case 8 %%  Laumanns
    x=v(:,1);y=v(:,2);
    f1=x.^2+y.^2; 
    f2=(x+2).^2+y.^2;
    pa=[f1,f2];
case 9 %%  Lis
    x=v(:,1);y=v(:,2);
    f1=(x.^2+y.^2).^(1/8); 
    f2=((x-0.5).^2+(y-0.5).^2).^(1/4);
    pa=[f1,f2];
case 10 %%  Murata
    x=v(:,1);y=v(:,2);
    f1=2* sqrt(x);
    f2=x.*(1-y)+5;
    pa=[f1,f2];
case 11 %%  Poloni
    x=v(:,1);y=v(:,2);
    A1=0.5*sin(1)-2*cos(1)+sin(2)-1.5*cos(2);
    A2=1.5*sin(1)-cos(1)+2*sin(2)-0.5*cos(2);
    B1=0.5*sin(x)-2*cos(x)+sin(y)-1.5*cos(y);
    B2=1.5*sin(x)-cos(x)+2*sin(y)-0.5*cos(y);
    f1=(1+(A1-B1).^2+(A2-B2).^2);
    f2=((x+3).^2+(y+1).^2);
    pa=[f1,f2];
case 12 %%  Quagliarella
    A1=(v(:,1).^2-10*cos(2*pi*v(:,1))+10)+(v(:,2).^2-10*cos(2*pi*v(:,2))+10)+(v(:,3).^2-10*cos(2*pi*v(:,3))+10);
    A2=((v(:,1)-1.5).^2-10*cos(2*pi*(v(:,1)-1.5))+10)+((v(:,2)-1.5).^2-10*cos(2*pi*(v(:,2)-1.5))+10)+((v(:,3)-1.5).^2-10*cos(2*pi*(v(:,3)-1.5))+10);
    f1=sqrt(A1/3);
    f2=sqrt(A2/3);
    pa=[f1,f2];
case 13 %%  Rendon
    x=v(:,1);y=v(:,2);
    f1=1./(x.^2+y.^2+1); 
    f2=x.^2+3*y.^2+1;
    pa=[f1,f2];
case 14 %%  Rendon (2)
    x=v(:,1);y=v(:,2);
    f1=x+y+1; 
    f2=x.^2+2*y-1;
    pa=[f1,f2];
case 15 %%  Schaffer  
    x=v;
    f1=x.^2;
    f2=(x-2).^2;
    pa=[f1,f2];
case 16 %%  Viennet 
    x=v(:,1);y=v(:,2);
    f1=x.^2+(y-1).^2; 
    f2=x.^2+(y+1).^2+1;
    f3=(x-1).^2+y.^2+2;
    pa=[f1,f2,f3];
case 17 %%  Viennet (2)
    x=v(:,1);y=v(:,2);
    f1=(x-2).^2/2+(y+1).^2/13+3; 
    f2=(x+y-3).^2/36+(-x+y+2).^2/8-17; 
    f3=(x+2*y-1).^2/175+(-x+2*y).^2/17-13;
    pa=[f1,f2,f3];
case 18 %%  Viennet (3)
    x=v(:,1);y=v(:,2);
    f1=(x.^2+y.^2)/2+sin(x.^2+y.^2); 
    f2=(3*x-2*y+4).^2/8+(x-y+1).^2/27+15; 
    f3=1./(x.^2+y.^2+1)-1.1*exp(-x.^2-y.^2);
    pa=[f1,f2,f3];
%DTLZ
    case 19 %%DTLZ1
        vg=v(:,3:7);
        gx=100*(5+sum((vg-0.5).^2-cos(20*pi*(vg-0.5)),2));
        f1=0.5*v(:,1).*v(:,2).*(1+gx);
        f2=0.5*v(:,1).*(1-v(:,2)).*(1+gx);
        f3=0.5*(1-v(:,1)).*(1+gx);
        pa=[f1,f2,f3];
    case 20 %%DTLZ2
        vg=v(:,3:12);
        gx=sum((vg-0.5).^2,2);
        f1=(1+gx).*cos(v(:,1)*0.5*pi).*cos(v(:,2)*0.5*pi);
        f2=(1+gx).*cos(v(:,1)*0.5*pi).*sin(v(:,2)*0.5*pi);
        f3=(1+gx).*sin(v(:,1)*0.5*pi);
        pa=[f1,f2,f3];
    case 21%%DTLZ3
        vg=v(:,3:12);
        gx=100*(10+sum((vg-0.5).^2-cos(20*pi*(vg-0.5)),2));
        f1=(1+gx).*cos(v(:,1)*0.5*pi).*cos(v(:,2)*0.5*pi);
        f2=(1+gx).*cos(v(:,1)*0.5*pi).*sin(v(:,2)*0.5*pi);
        f3=(1+gx).*sin(v(:,1)*0.5*pi);
        pa=[f1,f2,f3];
    case 22%%DTLZ4
        vg=v(:,3:12);
        gx=sum((vg-0.5).^2,2);
        f1=(1+gx).*cos((v(:,1).^100)*0.5*pi).*cos((v(:,2).^100)*0.5*pi);
        f2=(1+gx).*cos((v(:,1).^100)*0.5*pi).*sin((v(:,2).^100)*0.5*pi);
        f3=(1+gx).*sin((v(:,1).^100)*0.5*pi);
        pa=[f1,f2,f3];   
%     case 23%DTLZ5
%         vg=v(:,3:12);
%         gx=sum((vg-0.5).^2,2);
%         Q1=(1./(2*(1+gx))).*(1+2*gx.*v(:,1));
%         Q2=(1./(2*(1+gx))).*(1+2*gx.*v(:,2));
%         f1=(1+gx).*cos(Q1*0.5*pi).*cos(Q2*0.5*pi);
%         f2=(1+gx).*cos(Q1*0.5*pi).*sin(Q2*0.5*pi);
%         f3=(1+gx).*sin(Q1*0.5*pi);
%         pa=[f1,f2,f3];
    case 24%%DTLZ6
        vg=v(:,3:22);
        gx=1+(9/20)*sum(vg,2);
        f1=v(:,1);
        f2=v(:,2);
        hf=3-(f1./(1+gx)).*(1+sin(3*pi*f1))-(f2./(1+gx)).*(1+sin(3*pi*f2));
        f3=(1+gx).*hf;
        pa=[f1,f2,f3];
%%ZDT
    case 25 %ZDT1
        vg=v(:,2:30);
        gx=1+9*(sum(vg,2)/29);
        f1=v(:,1);
        f2=gx.*(1-sqrt(v(:,1)./gx));
        pa=[f1,f2];
    case 26 %ZDT2
        vg=v(:,2:30);
        gx=1+9*(sum(vg,2)/29);
        f1=v(:,1);
        f2=gx.*(1-(v(:,1)./gx).^2);
        pa=[f1,f2];
    case 27 %ZDT3
        vg=v(:,2:30);
        gx=1+9*(sum(vg,2)/29);
        f1=v(:,1);
        f2=gx.*(1-sqrt(v(:,1)./gx)-(v(:,1)./gx).*sin(10*pi*v(:,1)));
        pa=[f1,f2];
    case 28 %ZDT4
        vg=v(:,2:10);
        gx=1+10*9+(sum(vg.^2-10*cos(4*pi*vg),2));
        f1=v(:,1);
        f2=gx.*(1-sqrt(v(:,1)./gx));
        pa=[f1,f2];
%     case 29 %ZDT5
    case 30 %ZDT6
        vg=v(:,2:10);
        gx=1+9*(sum(vg,2)/9).^0.25;
        f1=1-(exp(-4*v(:,1))).*(sin(6*pi*v(:,1))).^6;
        f2=gx.*(1-(f1./gx).^2);
        pa=[f1,f2];
end
