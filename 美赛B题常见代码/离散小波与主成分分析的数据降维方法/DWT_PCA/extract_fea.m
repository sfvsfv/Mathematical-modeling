% extract the DCT-based features

function dwt_im=extract_fea(im)

[cA,cH,cV,cD] = dwt2(im,'db1'); 
dwt_im= cA;

