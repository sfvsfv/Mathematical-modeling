function [rate]=recognition(Training_matrix,Vectors,Y)

% recognition process
sucess=0;
error=0;

psi=mean(Training_matrix,2);

%--------------recognition from s01-s40-------------------------------
for i=1:40
   for j=4:10
     test=double(imread(['D:\face database\orl_faces(olivetti)\s' num2str(i) '\' num2str(j) '.bmp' ]));
     test=extract_fea(test);
     test=reshape(test,size(test,1)*size(test,2),1);
     %Projecting the test image onto the eigenface space...
     newomega=Vectors'*(test-psi);
     %Calculating the distance of the new face from each sample..NN
     %classifier
     distances = dist(Y',newomega);
     %Choosing the nearest sample : the smallest distance...
     indice=find(distances==min(distances));
     k=indice(1);  % k is the label of the class,correspond the column of the trainingmatrix.
     if mod(k,3)==0
         if (k/3==i)
             sucess=sucess+1;
         else
             error=error+1;
         end
     else 
         if (floor(k/3)+1)==i       
             sucess=sucess+1;
         else
           error=error+1;
         end
     end
end
end
      
rate=sucess/(sucess+error);          


