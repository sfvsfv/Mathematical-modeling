%% »æÍ¼º¯Êý
function pathPlot(linkV,positionV)
hold on;
len=length(linkV);
for i=1:len-1
    plot([positionV(linkV(i,1),1),positionV(linkV(i+1,1),1)],[positionV(linkV(i,1),2),positionV(linkV(i+1,1),2)]);
end
plot([positionV(linkV(1,1),1),positionV(linkV(len,1),1)],[positionV(linkV(1,1),2),positionV(linkV(len,1),2)]);