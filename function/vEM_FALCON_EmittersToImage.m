function [out] = vEM_FALCON_EmittersToImage(Results, img_size, dfactor, N)

%  Reconstructed image from a list of emitters from FALCON output

% from emitters list of FALCON to image 

%{
                  plot_support: 
                  0 is intensity sum;  1 is num of frames;   2 is intensity sum/num of frames

in 2: if record stack, the stack is the same as intensity sum 

    %}          
   %dfactor = 5; 
   %{
   fid = Results(:,1); 
   Results = Results(fid~=0,:); 
   %}
   fid = Results(:,1); 
   %n = length(unique(fid)); 
   myim = zeros(img_size*dfactor); 
  %{ 
   if plot_support == 2
      myim1 = zeros(img_size*dfactor); 
   end
  
   if record
   stack = zeros([img_size*dfactor,img_size*dfactor,n]); 
   else 
   stack=0;
   end
   %}
   for idx = 1:N
   x = Results(fid==idx,2)*dfactor;
   y = Results(fid==idx,3)*dfactor;
   x =max(1,x); 
   x =min(x,img_size*dfactor); 
   y =max(1,y); 
   y =min(y,img_size*dfactor); 
   
   fal = ceil(sub2ind([img_size*dfactor,img_size*dfactor],ceil(y),ceil(x)));
   im = zeros([img_size*dfactor,img_size*dfactor]);
   %{
   if plot_support == 2
      im1 = im; 
   end
   %}
       im(fal) = Results(fid==idx,4); 
        %{
   if plot_support == 0
    im(fal) = Results(fid==idx,4); 
   elseif plot_support == 1
    im(fal) = 1; 
   elseif plot_support == 2
    im(fal) = Results(fid==idx,4);   
    im1(fal) = 1;    
   end
        
   %im(fal) = 1;%Results(fid==idx,4); 
   if record
   stack(:,:,idx) = im; 
   end
       %}
   myim = myim+im; 
   %{
   if plot_support == 2
       myim1 = myim1+im1; 
   end
    %}   
       
   end
   %out = myim/n; 
   out = myim; 
   %{
   if plot_support == 2
      out = myim./myim1; 
      out(isnan(out)) = 0;
   else
       out = myim; 
   end
%}
end