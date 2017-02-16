function  vEM_PlotEvaluation_overall(overall_evaluation_all, reconstructed_image, folder, bdy, high_size, N) 
fi = figure; 
correctness = extractfield(overall_evaluation_all,'correct_mass_percentage'); 
plot(1:3,correctness(1:3),'bo:')
hold on
plot(4:6,correctness(4:6),'bo-')
ylabel('Percentage'); xlabel('Steps')
title('Overall evaluation: Correct intensity mass')
grid on 
set(gca, 'XTick', [1:6], 'XTickLabel', {'FALCON','Refine-1','VB-1','Constraint FALCON','Refine-2','VB-2' });
saveas(fi, [folder, 'Overall evaluation_Correct intensity mass.png'])

%
%fi = figure('units','normalized','outerposition',[0 0 1 1]); 
fi = figure('Position', [100, 100, 900, 900]);
 
out_falcon = reconstructed_image{1}; 
im =  reconstructed_image{2};
out_constraint =  reconstructed_image{3};
im_constraint =  reconstructed_image{4};


subplot(2,2,1)
imagesc(out_falcon(bdy:high_size-bdy,bdy:high_size-bdy)); title(['FALCON, N=',num2str(N)]);axis off% colorbar; 
%subplot(2,3,2)
%imagesc(im0(bdy:high_size-bdy,bdy:high_size-bdy)); title('Refine-1');axis off%colorbar; 
subplot(2,2,2)


imagesc(im(bdy:high_size-bdy,bdy:high_size-bdy)); title(['vEM-1']);axis off% colorbar; 
subplot(2,2,3)
imagesc(out_constraint(bdy:high_size-bdy,bdy:high_size-bdy)); title('Constraint FALCON');axis off% colorbar; 
%subplot(2,3,5)
%imagesc(im0_constraint(bdy:high_size-bdy,bdy:high_size-bdy)); title('Refine-2');axis off% colorbar; 
subplot(2,2,4)
imagesc(im_constraint(bdy:high_size-bdy,bdy:high_size-bdy)); title('vEM-2');axis off%colorbar; 
%out1,im0,im,out_constraint,im0_constraint,im_constraint
saveas(fi, [folder, 'Overall_reconstructed_image.png'])
