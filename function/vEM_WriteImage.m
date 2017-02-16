function filename = vEM_WriteImage(data,folder)

%% write image
%CCD_imgs =  simparm.y;
filename = [folder, 'obs.tif'];     
%numFrame = N; 
% delete previous images
%delete(filename);
numFrame = size(data,3); 
for nn = 1:numFrame
    imwrite(uint16(data(:,:,nn)),filename,'tif','Compression','none','writemode','append');
end 