function [Vectors,Training_matrix,Y]=train(numvecs)

% train the image samples
% return value U represents the eigenvectors
% Traing_matrix denotes the training matrix
% Y is the feature matrix
Training_matrix=[];


%read images from s01-s40
%---------------------------------------------------
for i=1:40   % i is the label of class
   for j=1:3 % 5 images per subject for test
      I=double(imread(['D:\face database\orl_faces(olivetti)\s' num2str(i) '\' num2str(j) '.bmp' ]));  
      I=extract_fea(I);
      I=reshape(I,size(I,1)*size(I,2),1);
      Training_matrix=[Training_matrix I];
  end;
 
end;


% evaluate the eigenvectors of covariance matrix
psi=mean(Training_matrix,2);
X=Training_matrix-repmat(psi,1,size(Training_matrix,2));
L=(X'*X); 
[V,m]=eig(L);
  [Vectors,Values] = sortem(V,m);
  Vectors = X*Vectors;

  % Get the eigenvalues out of the diagonal matrix and
  % normalize them so the evalues are specifically for cov(A'), not A*A'.
  nexamp=size(X,2);
  Values = diag(Values);
  Values = Values / (nexamp-1);

  % Normalize Vectors to unit length, kill vectors corr. to tiny evalues

  num_good = 0;
  for i = 1:nexamp
    Vectors(:,i) = Vectors(:,i)/norm(Vectors(:,i));
    if Values(i) < 0.00001
      % Set the vector to the 0 vector; set the value to 0.
      Values(i) = 0;
      Vectors(:,i) = zeros(size(Vectors,1),1);
    else
      num_good = num_good + 1;
    end;
  end;
  if (numvecs > num_good)
    fprintf(1,'Warning: numvecs is %d; only %d exist.\n',numvecs,num_good);
    numvecs = num_good;
  end;
  Vectors = Vectors(:,1:numvecs);  %eigenspace


Y = Vectors'*X;   % feature extraction
