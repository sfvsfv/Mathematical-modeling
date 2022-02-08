function [xv,fv] = TrackRoute(H,c,A,b,x0,y0,w0,p,delta,tolX)
if min(y0) <= 0
    disp('y0的每个分量必须大于0！');
    xv = NaN;
    fv = NaN;
    return;
end
if min(w0) <= 0
    disp('w0的每个分量必须大于0！');
    xv = NaN;
    fv = NaN;
    return;
end
if nargin == 9
    tolX = 1.0e-6;
end

sz = size(A);
m = sz(1);
tol = 1;

while tol>tolX
    Y = diag(y0);
    W = diag(w0);
    lu = b - A*x0+w0;
    sigma = c + H*x0 - transpose(A)*y0;
    gama = transpose(y0)*w0;
    mu = delta*gama/m;
    SA = [-H transpose(A);A inv(Y)*W];
    SB = [c+H*x0 - transpose(A)*y0;b - A*x0+mu*inv(Y)*ones(m,1)];
    ds = SA\SB;
    dx = ds(1:length(x0));
    dy = ds((length(x0)+1):length(ds));
    dw = inv(Y)*(mu*ones(m,1) - Y*W*ones(m,1) - W*dy);
    ry = - dy./y0;
    rw = -dw./w0;
    vec = [ry;rw];
    mr = max(vec);
    lamda = min(p/mr ,1);
    
    x0 = x0 + lamda*dx;
    y0 = y0 + lamda*dy;
    w0 = w0 + lamda*dw;
    
    tollu = norm(lu);
    tolsigma = norm(sigma);
    tolgama = abs(gama);
    tol = max(tollu,tolsigma);
    tol = max(tol,tolgama);
end

xv = x0;
fv = transpose(xv)*H*xv/2 + transpose(c)*xv;

    

    