function [xv,fv] = QuadLagR(H,c,A,b)
invH = inv(H);
F =  invH*transpose(A)*inv(A*invH*transpose(A))*A*invH - invH;
D = inv(A*invH*transpose(A))*A*invH;
xv = F*c + transpose(D)*b;
fv = transpose(xv)*H*xv/2+transpose(c)*xv;