function imim = q2image(newQ, fluo, Xit, img_size, dfactor)
%% ****************************************************************************************************
%% Reconstruct image from the q distribution (probability mass) of one fluorophore (usually updated q): 
%% Input:
%%       new Q:     the updated q distribution (probility mass) for a fluorophore  
%%       fluo:      the index of fluorophore (of interest) in the frame
%%       Xit:       all fluorophores positions (of a frame) in image pixel 
%%       img_size:  observed image size 
%%       dfactor:   resolution up-scaled factor
%% Output: reconstructed image
%% Author: Ruoxi Sun
%% ****************************************************************************************************

       m = fluo; 
       
       imim = zeros(img_size*dfactor);  
        
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
        
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor); 
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = newQ; 
       
end