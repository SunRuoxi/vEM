function [stat, qstack0] = vEM_HessianInStock_qdist(simparm, Results, img_size, ini_baseline, refine, test_peaks)
%% ****************************************************************************************************
%% Prepare for vEM; calculate hessians and q initial  
%% Input: 
%%        simparm:          simulated parameters and observations (y)
%%        Results:          FALCON output
%%        img_size:         observed image size
%%        ini_baseline:     the estimated baseline level of the backgroun noise 
%                           if provided value, use the value.  if is empty, use a percentile of y
%%        refine:           whether to perform refine or not 
%                           Refine is eq 11 of http://biorxiv.org/content/biorxiv/early/2016/11/19/081703.full.pdf
%%        test_peaks:       if '1', to test whether poisson likelihood and its Laplace approximation align well; '0' otherwise 
%% Output: 
%%        stat:             save caluclated hessians and other parameters 
%%        qstack0:          initialize q distribution (gaussians, whose co-variance is decided by laplace approximation)
%% ****************************************************************************************************
% Setup 
N = size(simparm.y,3); 
dfactor = simparm.dfactor; 
c = simparm.psf; 
xs = 1:1:img_size; 
xs = xs-0.5;  
[Y,X] = meshgrid(xs,xs); 
R = sqrt(X.^2 + Y.^2);
X = X(:); 
Y = Y(:);
gd = -3:1/dfactor:3;  % q distribution support 
tor = 1.5/dfactor; % tolerance of refine alteration in super-resolved pixels 
one = 1/(2*pi*(abs(c).^2)) * exp(-((X-floor(mean(xs))).^2+(Y-floor(mean(xs))).^2)/(2*(c.^2)));  %normalize constant for a fluorophore (sum of intensities of one fluorophore)
one = sum(one(:)); 
id = Results(:,1); % frame index

%% generated "stat" (refine and hessian)

stat = []; 
for idx = 1: N
 
 	if mod(idx,100)==1
        disp(['Refine and calculate hessians: frame ', num2str(idx), '~', num2str(idx+99), '(out of ', num2str(N),' frames)...'])
    end
    nX = sum(id == idx); 
    stat{idx}.nX = nX;
    stat{idx}.psf = c;  
    if nX ~= 0
        Falw = double(Results(id == idx,4)'); 
        Falx  = double([Results(id == idx,3); Results(id == idx,2)]); 
        y = simparm.y(:,:,idx);  
        y = y(:); 
     
        if isempty(ini_baseline)
            % if not provided baseline 
            baseline = prctile(y(:), perc); 
            disp(['ATTENTION !!! baseline DOES NOT exist!!! Set baseline=',num2str(baseline),'. It is ', num2str(perc),' percent of observation y'])
        else
            if isscalar(ini_baseline)
                baseline = ini_baseline; 
            else
                baseline = ini_baseline(:,:,idx); 
                baseline =  baseline(:); 
            end
         
        end
        baseline = double(baseline); 
   
  
     
        Xt = X;   
        Yt = Y;   
 
        clear f
        negLikelihood_Hes = str2func(['negLikelihood_',num2str(nX),'_Hes']);
        f  = @(x)negLikelihood_Hes(x,Falw,y,c,baseline,one,Xt,Yt); % call the pre-trained objective function 
 
        %% refine
 
        if refine % refine  
            options = optimoptions(@fmincon,'GradObj','on','Hessian','on', 'Algorithm','trust-region-reflective','Display','notify');
            lower = max(ones(size(Falx)),Falx-tor); 
            upper = min(img_size*ones(size(Falx)), Falx+tor); 
            [xxx,fval,exitflag,output]  = fmincon(f,Falx,[],[],[],[], lower,upper,[],options); 
  
        else % not refine 
            xxx = Falx; 
        end % end refine 
  
  
        %% hessian 
 
        [negf,negG,negH] = negLikelihood_Hes(xxx, Falw, y, c, baseline, one, X, Y); % call the pre-trained hessian function 
 
        H = -negH; 
        I = negH; 
        Sigma = inv(negH); 
        Sigma = round(Sigma,10);
        stat{idx}.sigma = Sigma; 
        stat{idx}.H = -negH;  

 
        mynew = reshape(xxx,nX,2); % reshape x, y coordinates 
        stat{idx}.refine = xxx;    % refine results
        stat{idx}.falcon = Falx;   % FALCON results 
        stat{idx}.mynew = mynew; 
        stat{idx}.w = Falw;        % FALCON intensities 
 
        %% test peaks (Laplace and poisson likelihood): test peaks=1, plot test performance; 0, otherwise
 
        if test_peaks
    
                if sum(eig(Sigma)<0)
                    %disp(['frame =', num2str(idx), ', Sigma has negative eigenvalue, skip test peaks!! '])
                    continue
                end
                vec = randn([length(xxx),1]);
                t  = linspace(-1,1,1000); 
 
                for i = 1:1000
                    XT = xxx(:) + t(i)* vec;
                    mu = XT(:);
                    bbb(i) = log(mvnpdf(mu, xxx, Sigma));
                    Xt = X;
                    Yt = Y;
                    yt = y;
                    func = str2func(['negLikelihood_',num2str(nX)]);
                    aaa(i) = -1*func(XT(:),Falw, y, c, baseline, one, X, Y); %long
                end

                Gx = exp(bbb-max(bbb));
                Lx = exp(aaa-max(aaa));

                figure(1)
                plot_CheckLikelihoodPeak(Gx, bbb, Lx, vec, t); drawnow; 
 
        end
 
 
    end
    
 end
  
 


%% generate initial q distribution (by Laplace approximation)

high_xs = 0:1/dfactor:img_size; 
high_xs = high_xs(2:end)- 1/dfactor/2; 
[ydg,xdg] = meshgrid(gd,gd);
Xitbase = [xdg(:),ydg(:)]; 

clear qstack 
for idx = 1:length(stat)
  
	nX =  stat{idx}.nX;
    
    if nX==0
        qstack(idx).nX = nX;    
    else
        if ~isfield(stat{idx}, 'sigma')
             qstack(idx).nX = 0; 
             qstack(idx).skip = 1; 
             %disp([num2str(idx), ' is skpped'])
             continue
        end
        
        
	want = stat{idx}.refine;
    sig = stat{idx}.sigma;   
    if max(sig(:))==Inf |  sum(isnan(sig(:)))~=0
        qstack(idx).nX = 0; 
        continue
    end
       
    SIG2d_change = zeros(1,nX); 
    SIG2d_before = []; 
    SIG2d = []; 
    Xit = []; 
    ppp = []; 
   
    for t = 1:nX 
      
      
        center = reshape(want,nX,2); 
        xhat = reshape(want,nX,2); 
        Xit(:,:,t)  = Xitbase + repmat(center(t,:),size(Xitbase,1),1); 
   
       
        %align with preknown grid, if not known comment out
        %%{
        indx = min((Xit(:,1,t)*dfactor),img_size*dfactor); 
        indx = max(indx,1); 
        indx = ceil(indx); 
        indy = min((Xit(:,2,t)*dfactor),img_size*dfactor);
        indy = max(indy,1); 
        indy = ceil(indy); 
        Xit(:,1,t) = high_xs(indx); 
        Xit(:,2,t) = high_xs(indy); 
       %}
       
       
        SIGMA = sig([t,t+nX],[t,t+nX]); 
        SIG2d_before(:,:,t) = SIGMA;  
      
        if min((eig(SIGMA)))<0 
        %   disp(['eig!!!! idx=', num2str(idx), 't=', num2str(t)])
            [V,D]=eig(SIGMA);d=diag(D);d(d<=0)= 1E-3; 
            SIGMA= V*diag(d)*V';
            SIG2d_change(t) = 1;
        end
       
       
        SIGMA = round(SIGMA,5); 
        [R,err] = cholcov(SIGMA,0);
        if err == 0
            prob_temp =  mvnpdf(Xit(:,:,t),center(t,:),SIGMA);
            SIG2d(:,:,t) = SIGMA; 
            ppp(:,:,t)  =  prob_temp/sum(prob_temp(:)); 
       
            if sum(prob_temp(:))==0 % eigenvalue of sigma is too small,  q distirbution is almost all zeros
                   ppp(:,:,t) = zeros(length(gd)^2,1); 
            end
       
       else
            SIG2d(:,:,t) =  nan(size(SIGMA)); 
            ppp(:,:,t) = zeros(length(gd)^2,1); %q distirbution is almost all zeros
            %disp(['completely wrong q, frame:', num2str(idx),',fluo:',num2str(t)])
       end
       
   end
   qstack(idx).frame = idx; 
   qstack(idx).center = center; 
   qstack(idx).nX = nX; 
   qstack(idx).xhat = xhat; %refined falcon 
   qstack(idx).Xit = Xit; 
   qstack(idx).ppp = ppp; 
   qstack(idx).sig = sig; 
   qstack(idx).SIG2d_before = SIG2d_before; 
   qstack(idx).SIG2d = SIG2d; 
   qstack(idx).SIG2d_change = SIG2d_change; 
   qstack(idx).w = stat{idx}.w; 
   
    end
    
end
qstack0 = qstack; 
 

end