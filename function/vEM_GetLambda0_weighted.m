function [im, im_stack] = vEM_GetLambda0_weighted(qstack,w,img_size,dfactor)
 
%% ****************************************************************************************************
%% Reconstruct lambda from the q distibutions. Each q can be weighted by its intensity. 
%% Input:
%%          qstack:         q distributions stored 
%%          w:              intensities
%                           % if w is [] (empty), unweighted by intensities, therefore sum of q distributions 
%%          img_size:       observed image size 
%%          dfactor:        resolution up-scaled factor
%% Output: 
%%          im:             reconstructed lambda
%%          im_stack:       reconstructed image frames
%% Author:  Ruoxi Sun
%% ****************************************************************************************************

im = zeros(img_size*dfactor);
 
w_idx = 1; 
for f = 1:length(qstack)
    
  idx = qstack(f).frame; 
   
  prob = squeeze(qstack(f).ppp);
  nX  = qstack(f).nX;
  
  Xit = qstack(f).Xit;   
  center = qstack(f).center;  
  if f==1
   
  end
   im_f = zeros(img_size*dfactor);
  for m = 1:nX
       imim = zeros(img_size*dfactor);  
       
   
       
       indx = min((Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       indx = ceil(indx); 
       indy = min((Xit(:,2,m)*dfactor),img_size*dfactor);
       indy = max(indy,1); 
       indy = ceil(indy); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = prob(:,m);
       if ~isempty(w)
           w_use = w(w_idx); 
           w_idx = w_idx+1; 
       else
           w_use = 1; 
           
       end
       im = im + imim*w_use; 
        im_f = im_f + imim*w_use; 
      
  end
  
   im_stack(:,:,f) = im_f; 
   
end
