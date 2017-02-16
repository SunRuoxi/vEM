 function [output, VB_out_all] = vEM_evaluation_q_dist(qstack, true_poses, pitch, radius, simparm)

% For evaluation, q distribution is transformed to a list of emitters, the same as FALCON output, using intensity-weighted sum.  

%% transform q distirbution to a list of emitters, e.g. the output of FALCON
num_frame = size(simparm.y,3);
%pitch: high_resolution_pitch
for idx = 1:length(qstack)
    if qstack(idx).nX~=0
      
    
     clear VB_out val
     for j = 1:size(qstack(idx).Xit,3)
         j;
        
         VB_out(j,:) = sum(qstack(idx).Xit(:,:,j).*repmat(qstack(idx).ppp(:,:,j),1,2)); 
         val(j) = sum(qstack(idx).ppp(:,:,j));  
     end
    
     
     VB_out_all{idx} = [VB_out val']; 
     
        
    end
end

%Re = Results2; 

%clear Re

idx_end = 0; 
for idx = 1:length(qstack)
    if ~isempty(VB_out_all{idx})
    VB = VB_out_all{idx}; 
    Re(idx_end+1:idx_end+size(VB,1),1) = idx; 
    Re(idx_end+1:idx_end+size(VB,1),[3,2])= VB(:,1:2); 
    
    idx_end = idx_end+size(VB,1); 
    end
end
 

%% the same with FALCON's evaluation 

Results = Re;% Results_constaint ;%Results_changepara; 
Results(:,[2,3]) = Re(:,[2,3]) *simparm.dfactor; 
 

num_idens = zeros(num_frame,1);
num_clusters = zeros(num_frame,1);
errors_x = [];
errors_y = [];
for tt = 1:num_frame
    ind = find(Results(:,1) == tt);
    est_pos = Results(ind,2:3);
   % true_pos = true_poses(:,:,tt);
    true_pos = true_poses{tt};
    num_cluster = size(est_pos,1);
    if num_cluster
        num_iden_temp = zeros(1,size(true_pos,1));
        error_x = zeros(num_cluster,1);
        error_y = zeros(num_cluster,1);
        num_cluster_temp = zeros(num_cluster,1);
        true_errors_temp = Inf*ones(1,length(true_pos(:,1))); 
        all_true_errors_temp = Inf*ones(1,length(true_pos(:,1))); 
            
        for ii = 1: num_cluster
            % find the closest true location
            distance = sqrt((true_pos(:,1)-est_pos(ii,1)).^2 + (true_pos(:,2)-est_pos(ii,2)).^2);
            [error_2D,index] = min(distance*pitch);
            
            
            if abs(error_2D) < radius
                num_iden_temp(index) = 1;
                num_cluster_temp(ii) = 1;
                error_x(ii) = (true_pos(index,1)-est_pos(ii,1))*pitch;
                error_y(ii) = (true_pos(index,2)-est_pos(ii,2))*pitch;
                
                
                if true_errors_temp(index)==Inf
                    true_errors_temp(index) = error_2D; 
                else
                    true_errors_temp(index) = min([true_errors_temp(index),error_2D]); 
                end
                
              
                
                
            end
            
            
                if all_true_errors_temp(index)==Inf
                    all_true_errors_temp(index) = error_2D; 
                else
                    all_true_errors_temp(index) = min([all_true_errors_temp(index),error_2D]); 
                end
                
                
                
            
             
        end
     %{   
          for z = 1:length(true_errors_temp)
                    if true_errors_temp(z)==Inf
                         distance = sqrt((true_pos(z,1)-est_pos(:,1)).^2 + (true_pos(z,2)-est_pos(:,2)).^2);
                         [error_2d,index] = min(distance*pitch);
                         if abs(error_2d) < radius
                         num_iden_temp(index) = 1;
                         true_errors_temp(z) = error_2d; 
                         end
                    end
          end
        
        for z = 1:length(all_true_errors_temp)
                    if all_true_errors_temp(z)==Inf
                         distance = sqrt((true_pos(z,1)-est_pos(:,1)).^2 + (true_pos(z,2)-est_pos(:,2)).^2);
                         [error_2dd,index] = min(distance*pitch);
                         all_true_errors_temp(z) = error_2dd; 
                    end
        end
     %}            
                
        true_errors{tt} = true_errors_temp; 
        all_true_errors{tt} = all_true_errors_temp; 
        ind = find(num_cluster_temp>0);
        num_idens(tt) = sum(num_iden_temp(:));
        num_clusters(tt) = num_cluster;
        error_x = error_x(ind);
        error_y = error_y(ind);
        errors_x = [errors_x(:); error_x(:)];
        errors_y = [errors_y(:); error_y(:)];
    end
end

num_mol = sum(squeeze(simparm.nX)); 
Recall = sum(num_idens)/num_mol; 
Precision = mean(num_idens)/mean(num_clusters); 
F1 = 2*Precision*Recall/(Precision+Recall); 


output.num_idens = num_idens; 
output.num_clusters = num_clusters; 
output.errors_x =errors_x; 
output.errors_y = errors_y; 
output.Recall = Recall; 
output.Precision = Precision; 
output.F1 = F1; 
output.error_std = std([errors_x;errors_y]); 
output.true_errors = true_errors; %true-error
output.all_true_errors = all_true_errors; 

mean_abs_error = mean(abs([errors_x; errors_y]));
output.mean_abs_error = mean_abs_error;
%{
%fprintf('\n\n\n\');
fprintf('\n');
%fprintf('Run time(GPU) : %.2fsec/frame, %.2fms/particle \n',run_time_GPU/numFrame,1000*run_time_GPU/size(Results,1));
fprintf('Accuracy      : rms_x %.2fnm,  rms_y %.2fnm \n',rms(errors_x),rms(errors_y));
fprintf('Recall        : %.2f (%.1f/%d) \n',sum(num_idens)/num_mol,sum(num_idens), num_mol); % identified true/real true
fprintf('True-positive : %.2f (%.1f /%.1f) \n',mean(num_idens)/mean(num_clusters),mean(num_idens),mean(num_clusters)); % precision: identified true p/total identified p
fprintf('F measure: %.4f \n',F1); % precision: identified true p/total identified p
if num_frame == 1
    fprintf('Average Molecule density for frame (%d): %.2f um^-2\n', simparm.idx, mean(simparm.molecule_density));
else
    fprintf('Average Molecule density : mean(simparm.molecule_density) %.2f um^-2\n',mean(simparm.molecule_density));
end 
%}

id = Results(:,1); 
fprintf('\n');
%mean(id) = id(1)
%fprintf('\n\n\n\');
%fprintf('Run time(GPU) : %.2fsec/frame, %.2fms/particle \n',run_time_GPU/numFrame,1000*run_time_GPU/size(Results,1));
%fprintf('Accuracy      : rms_x %.2fnm,  rms_y %.2fnm \n',rms(errors_x),rms(errors_y));
fprintf('Recall: %.2f (total: %.1f/%d) \n',sum(num_idens)/num_mol,sum(num_idens), num_mol); % identified true/real true
%fprintf('Recall: %.2f (%.1f/%d) \n',mean(num_idens)/mean(num_mol),mean(num_idens), mean(num_mol)); % identified true/real true
if mean(id) == id(1)
%fprintf('True-positive : %.2f (%.1f /%.1f) \n',sum(num_idens)/sum(num_clusters),sum(num_idens),sum(num_clusters)); 
fprintf('Precision : %.2f (per frame: %.1f/%.1f) \n',sum(num_idens)/sum(num_clusters),sum(num_idens),sum(num_clusters)); 
else
%fprintf('True-positive : %.2f (%.1f /%.1f) \n',mean(num_idens)/mean(num_clusters),mean(num_idens),mean(num_clusters)); % precision: identified true p/total identified p
fprintf('Precision : %.2f (per frame: %.1f/%.1f) \n',mean(num_idens)/mean(num_clusters),mean(num_idens),mean(num_clusters)); % precision: identified true p/total identified p
end
fprintf('F measure: %.4f \n',F1); % precision: identified true p/total identified p
fprintf('Mean_abs_error: %.4f nm\n',mean_abs_error);

if mean(id) == id(1)
fprintf('Average Molecule density for frame (%d): %.2f um^-2\n',id(end), mean(simparm.molecule_density(id(end))));
else
fprintf('Average Molecule density : mean(simparm.molecule_density) %.2f um^-2\n',mean(simparm.molecule_density));
end 
