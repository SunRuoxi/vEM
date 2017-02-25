function  vEM_PlotEvaluation_overall(overall_evaluation_all, reconstructed_image, folder, bdy, high_size, N) 

% Plot overall reconstructed images for FALCON, vEM-1,constrained FALCON,vEM-2
% Plot overall evaluation("Correct intensity mass") figure of the above four steps 
% Author: Ruoxi Sun


% Plot overall reconstructed images
fi = figure('Position', [100, 100, 900, 900]);
out_falcon = reconstructed_image{1}; 
im =  reconstructed_image{2};
out_constraint =  reconstructed_image{3};
im_constraint =  reconstructed_image{4};
subplot(2,2,1)
imagesc(out_falcon(bdy:high_size-bdy,bdy:high_size-bdy)); title(['FALCON, N=',num2str(N)]);axis off 
subplot(2,2,2)
imagesc(im(bdy:high_size-bdy,bdy:high_size-bdy)); title(['vEM-1']);axis off 
subplot(2,2,3)
imagesc(out_constraint(bdy:high_size-bdy,bdy:high_size-bdy)); title('Constraint FALCON');axis off 
subplot(2,2,4)
imagesc(im_constraint(bdy:high_size-bdy,bdy:high_size-bdy)); title('vEM-2');axis off 
saveas(fi, [folder, 'Overall_reconstructed_image.png'])

% "Correct intensity mass" figure  
fi = figure; 
correctness = extractfield(overall_evaluation_all,'correct_mass_percentage'); 
plot([1,3],correctness([1,3]),'bo:')
hold on
plot([4,6],correctness([4,6]),'bo-')
ylabel('Percentage'); xlabel('Steps')
title('Overall evaluation: Correct intensity mass')
grid on 
set(gca, 'XTick', [1:4], 'XTickLabel', {'FALCON','vEM-1','Constraint FALCON','vEM-2' });
saveas(fi, [folder, 'Overall evaluation_Correct intensity mass.png'])
