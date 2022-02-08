function [bu,bd,testfunction]=getbud(NO)
% Authors: Maoguo Gong and Licheng Jiao
% April 7, 2006
% Copyright (C) 2005-2006 by Maoguo Gong (e-mail: gongmg@126.com)
%--------------------------------------------------------------------------
switch NO 
%%1-3 are MISA's problems    
case 1
    bu=[1,1];bd=[0,0];testfunction='DEB';
case 2
    bu=[10];bd=[-5];testfunction='SCH';
case 3
    bu=[5 5 5];bd=[-5 -5 -5];testfunction='KUR';   
    
%%4-18 are Veldhuizen's probems
case 4
    bu=[10 10];bd=[-5 -5];testfunction='Binh1';
case 5
    bu=[10^6 10^6];bd=[10^(-6) 10^(-6)];testfunction='Binh3';
case 6
    bu=[10 10];bd=[-10 -10];testfunction='Fonseca';
case 7
    bu=[4 4 4];bd=[-4 -4 -4];testfunction='Fonseca2';
case 8
    bu=[2 2];bd=[-2 -2];testfunction='Laumanns';
case 9
    bu=[10 10];bd=[-5 -5];testfunction='Lis';
case 10
    bu=[4 2];bd=[1 1];testfunction='Murata';
case 11
    bu=[pi pi];bd=[-pi -pi];testfunction='Poloni';
case 12
    bu=[5.12 5.12 5.12];bd=[-5.12 -5.12 -5.12];testfunction='Quagliarella';
case 13
    bu=[3 3];bd=[-3 -3];testfunction='Rendon';
case 14
    bu=[3 3];bd=[-3 -3];testfunction='Rendon2';
case 15
    bu=[5];bd=[-5];testfunction='Schaffer';
case 16
    bu=[2 2];bd=[-2 -2];testfunction='Viennet';
case 17
    bu=[4 4];bd=[-4 -4];testfunction='Viennet2';
case 18
    bu=[3 3];bd=[-3 -3];testfunction='Viennet3';
%DTLZ
    case 19
        bd=zeros(1,7);bu=ones(1,7);  testfunction='DTLZ1'; 
    case 20
        bd=zeros(1,12);bu=ones(1,12);  testfunction='DTLZ2';      
    case 21
        bd=zeros(1,12);bu=ones(1,12);  testfunction='DTLZ3';
    case 22
        bd=zeros(1,12);bu=ones(1,12);  testfunction='DTLZ4';
   case 23
        bd=zeros(1,12);bu=ones(1,12);  testfunction='DTLZ5';
    case 24
        bd=zeros(1,22);bu=ones(1,22);  testfunction='DTLZ6'; 
        %ZDT
    case 25
        bd=zeros(1,30);bu=ones(1,30);  testfunction='ZDT1'; 
    case 26
        bd=zeros(1,30);bu=ones(1,30);  testfunction='ZDT2';
    case 27
        bd=zeros(1,30);bu=ones(1,30);  testfunction='ZDT3';
    case 28
        bd=[0 -5 -5 -5 -5 -5 -5 -5 -5 -5];bu=[1 5 5 5 5 5 5 5 5 5];  testfunction='ZDT4';
%     case 29
%         bd=zeros(1,30);bu=ones(1,30);  testfunction='ZDT5';
    case 30
        bd=zeros(1,10);bu=ones(1,10);  testfunction='ZDT6';
otherwise
    disp(sprintf('£¡£¡£¡Wrong number of test problems entered, hence exiting '));bu=0;bd=0;testfunction='err**';
end