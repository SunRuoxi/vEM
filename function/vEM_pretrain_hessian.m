function vEM_pretrain_hessian(num_of_fluo, img_size)
%% ****************************************************************************************************
%% Pre-train hessians with fixed number of fluorophores per frame and fixed image size 
%% Save differetiated files are saved in in folder 'hessians'
%      include: negative log likelihood, gradient, and hessians 
%      with names: negLikelihood_XXX, negLikelihood_XXX_ADiGatorHes, negLikelihood_XXX_ADiGatorHes
%                  XXX is number of fluorophores per frame 
%% The hessians can ONLY be used for MATCHED number of fluorophores per frame AND image size
%% The hessians can be plugged in different X(fluorophore positions), y(observation), w (intensities), baseline, and dfactor(up scale factor)
%% Author: Ruoxi Sun 
%% ****************************************************************************************************

mkdir('hessians');cd('hessians'); 
addpath(pwd)

for nX = 1:num_of_fluo 

strall = []; 
    for j = 1:nX
        str = ['w(',num2str(j),')', '*', '1/one *  1/(2*pi*(abs(c).^2))', '*', 'exp(-(([', 'Xt',']-x(',num2str(j),')).^2 + ([','Yt' ,']-x(', num2str(j+nX),')).^2)/', '(2*(c.^2)))'];
  
        if isempty(strall)
              strall = str; 
        else
              strall = [strall, '+', str];   
        end
 
    end
    strall = ['baseline +', strall]; 
    
FuncBody = ['-sum(-(', strall, ')+[', 'y','].* log(', strall, ')', ')'];  
FuncVar = 'x, w, y, c, baseline, one,Xt, Yt';
FuncName = ['negLikelihood_',num2str(nX)];
writefunc(FuncName, FuncVar, FuncBody); 


%%

%differentiation
x_a = adigatorCreateDerivInput([2*nX 1],'x');
% auxillary variable
w_a = adigatorCreateAuxInput([nX 1]);
y_a = adigatorCreateAuxInput([img_size^2 1]);
c_a = adigatorCreateAuxInput([1 1]);
baseline_a = adigatorCreateAuxInput([1 1]);
one_a = adigatorCreateAuxInput([1 1]);
image_size_a = adigatorCreateAuxInput([1 1]);
Xt_a = adigatorCreateAuxInput([img_size^2 1]);
Yt_a = adigatorCreateAuxInput([img_size^2 1]);
 
output = adigatorGenHesFile_ChangeOuputOrder(FuncName,{x_a, w_a, y_a, c_a, baseline_a,one_a, Xt_a, Yt_a});

end