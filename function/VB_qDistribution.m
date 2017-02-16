function [im, indx, indy]  = VB_qDistribution(qstack, frame, fluorophore, img_size, dfactor)

%rearrage q distibution stored in qstack to matrix form. 
% if fluorophore is [] (empty), plot all fluorophores in the frame. 
% Usage: im  = VB_qDistribution(qstack, 285, 5, img_size, dfactor);
% Usage: im  = VB_qDistribution(qstack, 285, [], img_size, dfactor);
  f = frame; 
 % disp('VB_qDistribution: ceil') 
  if qstack(f).nX == 0
      % disp(['no fluorophores for frame', num2str(frame)])
       im = zeros(img_size*dfactor); 
       return
  end
   
  idx = qstack(f).frame; 
  %want = qstack(f).center; %update
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
       %indx = min(round(Xit(:,1,m)*dfactor),img_size*dfactor); %the same with part33 %  GOOD dfactor3
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       %indy = min(round(Xit(:,2,m)*dfactor),img_size*dfactor); %  GOOD dfactor3
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor); 
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = sub;%prob(:,m);
       im = im+imim; 
       if 0
       figure; imagesc(imim); title(['imim', num2str(t)]); drawnow; 
       end    
    end 
    
else
       m = fluorophore; 
       sub = qstack(f).ppp(:,:,m);
       imim = zeros(img_size*dfactor);  
       %indx = min(round(Xit(:,1,m)*dfactor),img_size*dfactor); %the same with part33 %  GOOD dfactor3
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       %indy = min(round(Xit(:,2,m)*dfactor),img_size*dfactor);  %  GOOD dfactor3
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor);
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = sub;%prob(:,m);
       if 0
       figure; imagesc(imim); title(['imim', num2str(t)]); drawnow; 
       end 
       im = imim; 
end


end