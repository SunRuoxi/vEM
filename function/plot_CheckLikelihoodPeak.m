function out = plot_CheckLikelihoodPeak(Gx, bbb, Lx, vec, t)
%check peak of laplace gaussian approx and poisson likelihood 
%{
Gx = exp(bbb-max(bbb));
Lx = exp(aaa-max(aaa));
%}
figure
 
subplot(1,2,1)
plot(t(find(bbb~=-Inf)),Gx(bbb~=-Inf),'b-', 'LineWidth',2)
% xlim([-1 1])
hold on
plot(t(find(bbb~=-Inf)),Lx(find(bbb~=-Inf)),'r-')%u
% xlim([-1 1])
%plot(t(find(bbb~=-Inf)),Fx(find(bbb~=-Inf)),'g-', 'LineWidth',2)
%plot(t(find(bbb~=-Inf)),Fx_new(find(bbb~=-Inf)),'k-')
%plot(t ,Fx,'g-')
%xlim([-1 1])
%plot(t(find(bbb~=-Inf)),aaa2(find(bbb~=-Inf)),'c.')
xlabel('t')
ylabel('exp(y-max(y))')
title('Likelihood')
legend('Laplace approx Gx','Poisson Lx')
%legend('Gx','Lx','Fx')
hold off
 
 

a=1:(length(vec)/2);
x_label = num2cell(num2str(a'))';
myXTickLabel = [strcat('X',x_label) strcat('Y',x_label)] ;

subplot(1,2,2)
bar([1:length(vec)],vec)
set(gca, 'XTick', [1:1:length(vec)], 'XTickLabel', myXTickLabel);
title('random direction, vec')
for i1=1:numel(vec)
    if vec(i1)<0
    text(i1,vec(i1),num2str(vec(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','top')
    else
        text(i1,vec(i1),num2str(vec(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
        
    end
end

out=1;
end
