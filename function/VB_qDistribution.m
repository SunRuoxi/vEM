function [im]  = VB_qDistribution(qstack, frame, fluorophore, img_size, dfactor)
%% ****************************************************************************************************
%% Reconstruct one frame from the q distibution stored in "qstack"
%% Input:
%%          qstack:         q distributions stored 
%%          frame:          the frame of interest 
%%          fluorophore:    the index of fluorophore (of interest) in the frame
%%                       if fluorophore is [] (empty), plot all fluorophores in the frame.                        
%%          img_size:       observed image size 
%%          dfactor:        resolution up-scaled factor
%% Output: 
%%          im:             reconstructed image
%% Usage:   
%%          e.g. plot frame 285, fluorophore 5: 
%%          im  = VB_qDistribution(qstack, 285, 5, img_size, dfactor);
%%          e.g. plot frame 285 
%%          im  = VB_qDistribution(qstack, 285, [], img_size, dfactor);
%% Author:  Ruoxi Sun
%% ****************************************************************************************************


  f = frame; 
  
  if qstack(f).nX == 0
      
       im = zeros(img_size*dfactor); 
       return
  end
   
  idx = qstack(f).frame; 
   
  prob = qstack(f).ppp;
  nX  = qstack(f).nX;
  xhat =  qstack(f).xhat;  %refined falcon estimate
  Xit = qstack(f).Xit;  %not change
  center = qstack(f).center;  
  precision  = inv(qstack(f).sig); 
  
  
%figure
if isempty(fluorophore)
    % plot all fluorophores in the frame
    im = zeros(img_size*dfactor);  
    for t = 1:nX
       m = t; 
       sub = qstack(f).ppp(:,:,m);
       imim = zeros(img_size*dfactor);  
       
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor); 
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = sub; 
       im = im+imim; 
       if 0
       figure; imagesc(imim); title(['imim', num2str(t)]); drawnow; 
       end    
    end 
    
else
       m = fluorophore; 
       sub = qstack(f).ppp(:,:,m);
       imim = zeros(img_size*dfactor);  
      
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor);
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = sub; 
       if 0
       figure; imagesc(imim); title(['imim', num2str(t)]); drawnow; 
       end 
       im = imim; 
end


end