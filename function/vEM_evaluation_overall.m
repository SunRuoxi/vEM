function out = vEM_evaluation_overall(my_image, true_image,th)
%usage: out = VB_evaluation_overall(my_image, simparm.I, 1)
% true_image = simparm.I; 
%{
temp0 = prctile(my_image(:),90)
temp2 = my_image(my_image<temp0); 
temp = sort(temp2(:)); 
temp1 = diff(temp); 
[~,max_index] = max( abs(diff(temp1))); 
[~,max_index] = max((diff(temp1))); 
th = temp(max_index+2); 
%}
%{
figure
plot(temp,'bo-')
hold on
plot(max_index+2,th,'ro')
%}

temp = sort(my_image(:)); 
th=temp(min(find(temp>0))) ; 

%th = prctile(my_image(:),50)
my_results = find(my_image > th);
true_results = find(true_image~=0); 
tp = length(intersect(my_results,true_results)); 
%overall.recall = tp/length(true_results); 
%overall.precision = tp/length(my_results); 
%overall.F = 2*overall.recall*overall.precision/(overall.recall+overall.precision);
overall.correct_mass_percentage = sum(my_image(find(true_image~=0)))/sum(my_image(:)); 
out = overall; 

%figure
%subplot(1,2,1); imagesc(my_image>=th); subplot(1,2,2); imagesc(true_image); title('overall evaluation')