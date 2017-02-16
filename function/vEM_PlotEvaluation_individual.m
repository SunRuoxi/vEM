function  vEM_PlotEvaluation_individual(evaluation_all, folder)
% plot the evaliation of accuracy of individual fluorophore, and save figure to folder
% plot localization error
% steps = {'FALCON','REFINE-1','vEM-1','Constraint FALCON','REFINE-2','vEM-2'}; 
 %{
 fi = figure('Position', [100, 100, 1700, 900]);
 for i = 1:length(evaluation_all)
 %err = sqrt(evaluation_all(i).errors_x.^2+  evaluation_all(i).errors_y.^2); 
 mystd = std([evaluation_all(i).errors_x;evaluation_all(i).errors_y ] ); 
 myname = steps{i}; 
 subplot(2,3,i)
 hist([evaluation_all(1).errors_x;evaluation_all(1).errors_y ]); 
 title([myname,': std=',num2str(mystd)])
 ylabel('Counts')
 xlabel('Localization error (nm)')
end
saveas(fi,[folder, 'localization_error.png'])
 %}
 
%plot F measure and error std 
fi = figure('Position', [100, 100, 550, 900]);
subplot(2,1,1)
p1=plot(1:3,[evaluation_all(1).Recall,evaluation_all(2).Recall,evaluation_all(3).Recall],'ro:'); hold on; 
p11 =plot(4:6,[evaluation_all(4).Recall,evaluation_all(5).Recall,evaluation_all(6).Recall],'ro-')

p2=plot(1:3,[evaluation_all(1).Precision,evaluation_all(2).Precision,evaluation_all(3).Precision],'bo:')
p22=plot(4:6,[evaluation_all(4).Precision,evaluation_all(5).Precision,evaluation_all(6).Precision],'bo-')

p3=plot(1:3,[evaluation_all(1).F1,evaluation_all(2).F1,evaluation_all(3).F1],'go:');
p33=plot(4:6,[evaluation_all(4).F1,evaluation_all(5).F1,evaluation_all(6).F1],'go-'); 

legend([p11,p22,p33],'Recall', 'Precision', 'F measure','location','southeast')
ylabel('Value'); xlabel('Steps')
grid on 
set(gca, 'XTick', [1:6], 'XTickLabel', {'FALCON','Refine','VB','Constraint FALCON','Refine','VB' });
title('Performace by steps') 

subplot(2,1,2)
mystd = extractfield(evaluation_all, 'error_std'); 
p4 = plot(1:3,mystd(1:3),'ko:'); hold on; 
p5 = plot(4:6,mystd(4:6),'ko-'); 
title('Abs localization error, std');
legend('stage 1','stage 2'); 
ylabel('Value'); xlabel('Steps')
grid on 
set(gca, 'XTick', [1:6], 'XTickLabel', {'FALCON','Refine-1','VB-1','Constraint FALCON','Refine-2','VB-2' });

saveas(fi, [folder, 'individual_performace.png'])

 