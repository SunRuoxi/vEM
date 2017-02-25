function  vEM_PlotEvaluation_individual(evaluation_all, folder)

% Plot evaluation of estimators for individual fluorophores for FALCON, Refine-1, vEM-1, constrained FALCON, Refine-2, vEM-2
% Individual evaluation: 'Recall', 'Precision', 'F measure', 'absolute localization error'
% Author: Ruoxi Sun

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
set(gca, 'XTick', [1:6], 'XTickLabel', {'FALCON','Refine','vEM-1','Constraint FALCON','Refine','vEM-2' });
title('Performace by steps') 

subplot(2,1,2)
mystd = extractfield(evaluation_all, 'error_std'); 
p4 = plot(1:3,mystd(1:3),'ko:'); hold on; 
p5 = plot(4:6,mystd(4:6),'ko-'); 
title('Abs localization error, std');
legend('stage 1','stage 2'); 
ylabel('Value'); xlabel('Steps')
grid on 
set(gca, 'XTick', [1:6], 'XTickLabel', {'FALCON','Refine-1','vEM-1','Constraint FALCON','Refine-2','vEM-2' });

saveas(fi, [folder, 'individual_performace.png'])

 