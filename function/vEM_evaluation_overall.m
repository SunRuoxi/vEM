function out = vEM_evaluation_overall(my_image, true_image,th)
 
% Overall accuracy evaluation: calculate the "correct_mass_percentage", which is the ratio between the intensity mass on the real support versus all intensity mass 
% Author: Ruoxi Sun

temp = sort(my_image(:)); 
th=temp(min(find(temp>0))) ; 

my_results = find(my_image > th);
true_results = find(true_image~=0); 
tp = length(intersect(my_results,true_results)); 
 
overall.correct_mass_percentage = sum(my_image(find(true_image~=0)))/sum(my_image(:)); 
out = overall; 

 