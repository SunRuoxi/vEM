function filename = vEM_WriteImage(data,folder)

% Write image from .mat file (data) into .tif file 
% Write into "folder"
% Author: Ruoxi Sun 

filename = [folder, 'obs.tif'];     
delete(filename)

numFrame = size(data,3); 
for nn = 1:numFrame
    imwrite(uint16(data(:,:,nn)),filename,'tif','Compression','none','writemode','append');
end 