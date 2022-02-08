function [NV,ND] = sortem(V,D)
%[V,D] = SORTEM(V,D)
%    Assumes the columns of V are vectors to be sorted along with the
%    diagonal elements of D.
%
% Matthew Dailey, 1998

% Check arguments

if nargin ~= 2
 error('Must specify vector matrix and diag value matrix')
end;

dvec = diag(D);
NV = zeros(size(V));
[dvec,index_dv] = sort(dvec);
index_dv = flipud(index_dv);
for i = 1:size(D,1)
  ND(i,i) = D(index_dv(i),index_dv(i));
  NV(:,i) = V(:,index_dv(i));
end;

