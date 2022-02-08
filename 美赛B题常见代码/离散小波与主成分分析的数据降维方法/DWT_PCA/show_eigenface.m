% show the eigenface images
% examples are conducted in Yale face database
[vectors,Training_matrix,Y]=train(20);  % 10 is the number of eigenvectors
% the size of vectors is 77760*10
for k=1:20
    col=vectors(:,k);  %pick up every column vector
    im=reshape(col,243,320); % transform this vector into 2D-image
    m_a=max(max(im));
    n_b=min(min(im));
    for i=1:243
       for j=1:320
       im(i,j)=(im(i,j)-n_b)/(m_a-n_b)*255;
       end
    end
    subplot(4,5,k);
    imshow(uint8(im));
end
