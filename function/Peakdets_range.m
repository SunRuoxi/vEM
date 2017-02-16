
 function [est_c_new,delta_x,delta_y] = Peakdets_range(est_c,thresh,range)

[Ny,Nx,Nt] = size(est_c);
img = zeros(Ny,Nx,'single');
est_c_new = zeros(size(est_c),'single');
delta_x = zeros(size(est_c),'single');
delta_y = zeros(size(est_c),'single');
%{
c_mask = ones(3);
x_mask = [-1 0 1;-1 0 1;-1 0 1];
x_mask = x_mask(:);
y_mask = [-1 -1 -1; 0 0 0; 1 1 1];
y_mask = y_mask(:);
%}
%range=2; 
gd = -range:1:range; 
%
 %{
c_mask = ones(length(gd));
[x_mask,y_mask] = meshgrid(gd,gd);
x_mask = x_mask(:);
y_mask = y_mask(:);
%}

est_c_copy = est_c;
est_c_copy(est_c<thresh) = 0;
for tt = 1: Nt
   % img(2:end-1,2:end-1) = est_c_copy(2:end-1,2:end-1,tt);%orginal
    img  = est_c_copy(:,:,tt) ;
    [I,J,FF] = find(img>0);
    for ii = 1:length(I)
        xx = J(ii);
        yy = I(ii);
       %  if (yy-range >=1 && yy+range <= size(est_c,2)) % estra: if not exceed the range
       
        img_temp = est_c(max(yy-range,1):min(yy+range,Nx),max(xx-range,1):min(xx+range,Nx),tt);
        %%{
        c_mask = ones(size(img_temp)); 
        y_mask_real = max(yy-range,1):min(yy+range,Nx); 
        y_mask_real = y_mask_real - yy; 
        x_mask_real = max(xx-range,1):min(xx+range,Nx); 
        x_mask_real = x_mask_real - xx; 
        [x_mask,y_mask] = meshgrid(x_mask_real,y_mask_real);
        x_mask = x_mask(:);
        y_mask = y_mask(:);
       %} 
        % for local maxima
        if est_c(yy,xx,tt) >= max(img_temp(:))
            
            % center of mass
            img_temp2 = c_mask(:).*img_temp(:);
            photon = sum(img_temp2);
            dx = sum(x_mask.*img_temp2)/photon;
            dy = sum(y_mask.*img_temp2)/photon;
            pos_y = yy+round(dy);
            pos_x = xx+round(dx);
            est_c_new(pos_y,pos_x,tt) = photon;
            delta_x(pos_y,pos_x,tt) = dx-round(dx);
            delta_y(pos_y,pos_x,tt) = dy-round(dy);
        %end
        end
    end
end
end
