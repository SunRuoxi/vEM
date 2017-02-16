function imim = q2image(newQ, fluo, Xit, img_size, dfactor)
% recover image from q distribution 
% fluo: fluorophore index
       m = fluo; 
      % disp('q2image: ceil')
       imim = zeros(img_size*dfactor);  
       %indx = min(round(Xit(:,1,m)*dfactor),img_size*dfactor); %the same with part33 %GOOD dfactor3
       indx = min(ceil(Xit(:,1,m)*dfactor),img_size*dfactor); 
       indx = max(indx,1); 
       %indy = min(round(Xit(:,2,m)*dfactor),img_size*dfactor); %GOOD dfactor3
       indy = min(ceil(Xit(:,2,m)*dfactor),img_size*dfactor); 
       indy = max(indy,1); 
       
       ind = sub2ind([img_size*dfactor,img_size*dfactor],indx,indy); 
       imim(ind) = newQ;%prob(:,m);
       
end