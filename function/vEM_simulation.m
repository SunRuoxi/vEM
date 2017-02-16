function [simparm,  true_poses] = vEM_simulation(psf, dfactor, img_size, scale, p, N, background, CCD_pitch, folder)

% vEM_simulation generates simulated images. 

%% Input: 
%%         psf                     : width of Gaussian fuctions, i.e. standard deviation of gaussian blur in the unit of image pixels 
%%         dfactor                 : resolution up-scaled factor, 1 CCD image pixel = dfactor * 1 high resolution pixel  
%%         img_size                : size of raw camera images, i.e. 32x32
%%         scale                   : number of photons per fluorophore
%%         p                       : emission probability 
%%         N                       : number of frames to be reconstructed
%%         background              : background noise 
%%         CCD_pitch               : raw camera pixel size in nm
%%         folder                  : the folder used to save the simulations
%% Output: 
%%         simparm                 : save simulation parameters and simulated images 
%%             simparm.I                : the complete ground truth x scale
%%             simparm.i                : the complete ground truth x scale 
%%             simparm.lambda0          : molecule density * p 
%%             simparm.nX               : number of fluorophores per frame 
%%             simparm.idx              : frame index
%%             simparm.molecule_density : molecule density per frame (# of fluorophores/area um^-2)
%%        true_poses                : a list of emitter positions (x, y) for every frame 
%%             
%% ****************************************************************************************************
 
evalc('delete(''obs.tif'')'); %erase file in the folder with the same name to prevent append new tif file to the old one. 
%delete('obs.tif')

xs = 1:1:img_size; 
xs = xs-0.5;  
[Y,X] = meshgrid(xs,xs); 
R = sqrt(X.^2 + Y.^2);
X = X(:); 
Y = Y(:);



%% Simulation

%simparm.psf (standard deviation)
simparm.psf = psf; 

%simparm.p: emission probability
simparm.p = p; 

%simparm.dfactor
simparm.dfactor = dfactor; 

%simparm.I 
up_decon = dfactor; 
bdy = round(img_size * 7/8 *dfactor/3); 
high_size = img_size * up_decon; 
simparm.I = zeros(high_size); 
simparm.I(round(bdy+(high_size-bdy*2)*1/5),:) = 1*scale; 
simparm.I(round(bdy+(high_size-bdy*2)*2/5),:) = 1*scale; 
simparm.I(round(bdy+(high_size-bdy*2)*3/5),:) = 1*scale; 
simparm.I(round(bdy+(high_size-bdy*2)*4/5),:) = 1*scale; 
simparm.I(:,round(bdy+(high_size-bdy*2)*1/5)) = 1*scale; 
simparm.I(:,round(bdy+(high_size-bdy*2)*2/5)) = 1*scale; 
simparm.I(:,round(bdy+(high_size-bdy*2)*3/5)) = 1*scale; 
simparm.I(:,round(bdy+(high_size-bdy*2)*4/5)) = 1*scale; 
   
 

inda = zeros(size(simparm.I)); 
inda(bdy:end-bdy,bdy+1:end-bdy)=1;
simparm.I = simparm.I.*inda; %imagesc(simparm.I)

%{
simparm.I(round(high_size*1/2),round(high_size/150*[60,100])) = up*scale; 
simparm.I(round(high_size*1/2),round(high_size/150*[40])) = up*scale; 
simparm.I(round(high_size*1/3),round(high_size/150*[50,110])) = up*scale; 
simparm.I(round(high_size*1/3),round(high_size/150*[90])) = up*scale; 
simparm.I(round(high_size/150*[60]),round(high_size*1/2)) = up*scale;
simparm.I(round(high_size/150*[100]),round(high_size*1/2)) = up*scale;
%}
% emission rate
%p = 0.01; 
%up= 10; 

simparm.i = zeros(high_size,high_size,N);
lambda0 = zeros(high_size); 
lambda0(simparm.I==scale) = p;
%lambda0(simparm.I==up*scale)= p*up; 
simparm.lambda0 = lambda0;  

for idx = 1:N
   
   %simparm.i(:,:,idx) = (rand(high_size)<p).* im_low + (rand(high_size)<up*p).* im_high;   %!!WRONG 
   % simparm.i(:,:,idx) = (rand(high_size)<p).* im_low + sum(rand([high_size,high_size,up])<p,3).* im_high; %OK
   simparm.i(:,:,idx) = poissrnd(lambda0)*scale; 
end %imagesc(sum(simparm.i,3))

%simparm.y
simparm.y = zeros(img_size,img_size,N); 
for idx = 1:N
    %idx
    if mod(idx,100)==1
        fprintf(['building frame ', num2str(idx),'~', num2str(idx+100), '... \n']);
    end
     
   [my_x,my_y] = find(simparm.i(:,:,idx)~=0); %high resolution grid
    my_x = my_x - 0.5; 
    my_y = my_y -0.5; 
    true_poses{idx} = [my_y,my_x]; 
    
    if isempty(my_x)
        lambda = zeros(img_size);
    else
        
    one = 1;
    nX = length(my_x); 
    simparm.nX(idx) = nX; 
    simparm.idx(idx) = idx; 
    simparm.molecule_density(idx) = nX/(((img_size-2*bdy/dfactor)*CCD_pitch/1000)^2); 
    
    simparm_i_vec = simparm.i(:,:,idx);
    Falw  = simparm_i_vec(find(simparm.i(:,:,idx)~=0));  

    %Falw =  scale*ones(1,nX);  
    Falx  = [my_x;my_y]/dfactor;  
 
    Xt = X;    
    Yt = Y;

    strall = []; 
    for j = 1:nX
   
      str = [num2str(Falw(j)), '*', num2str(1/one * 1/(2*pi*(abs(psf).^2))), '*', 'exp(-(([', num2str(Xt'),']-x(',num2str(j),')).^2 + ([',num2str(Yt') ,']-x(', num2str(j+nX),')).^2)/', num2str((2*(psf.^2))),')'];
 
    if isempty(strall)
    strall = str; 
    else
    strall = [strall, '+', str];   
    end
 
    end

    func = str2func(['@(x) ', strall]);
    qqq = func(Falx);
    %figure; imagesc(reshape(qqq,img_size,img_size)); title('lambda')
    lambda = reshape(qqq,img_size,img_size) ; 
    lambda = lambda/sum(lambda(:))*sum(Falw); %normalize lambda
   % simparm.lambda(:,:,idx) = lambda; 
    end
    simparm.y(:,:,idx) =  poissrnd(lambda+background);  
end

%save([folder, 'simparm'],'simparm','-v7.3');
% write data into tif  

vEM_WriteImage(simparm.y, folder);  
end