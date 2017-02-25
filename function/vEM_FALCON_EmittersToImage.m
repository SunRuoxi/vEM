function [out] = vEM_FALCON_EmittersToImage(Results, img_size, dfactor, N)

% Reconstructed image from FALCON output
% FALCON outputs are a list of emitters 
%                      || frame number || x positions || y positions || photon counts || PSF_width_ratio
% Author: Ruoxi Sun 

           
   
   fid = Results(:,1); 
  
   myim = zeros(img_size*dfactor); 
  
   for idx = 1:N
         x = Results(fid==idx,2)*dfactor;
         y = Results(fid==idx,3)*dfactor;
         x =max(1,x); 
         x =min(x,img_size*dfactor); 
         y =max(1,y); 
         y =min(y,img_size*dfactor); 
   
         fal = ceil(sub2ind([img_size*dfactor,img_size*dfactor],ceil(y),ceil(x)));
         im = zeros([img_size*dfactor,img_size*dfactor]);
         im(fal) = Results(fid==idx,4); 
         myim = myim + im; 
   end
    
   out = myim; 
    
end