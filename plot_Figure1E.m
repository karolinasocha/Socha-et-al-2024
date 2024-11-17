
clear all
load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1D_1E_1F.mat')
data_Figure1


for iAn=1:length(data_Figure1.avg_dPupil_perAnimal_allDirs)
    [pval(iAn),~]=ranksum(data_Figure1.avg_dPupil_perAnimal_nasal{iAn}(:), data_Figure1.avg_dPupil_perAnimal_temporal{iAn}(:),'Tail','right');
end
num_significant_animals=sum(pval<0.05)

pupil_delta_prct=data_Figure1.avg_dPupil_perAnimal_allDirs;

meanData = nanmean(pupil_delta_prct);
semData = (nanstd(pupil_delta_prct))./ sqrt(size(pupil_delta_prct, 1));

x = 1:numel(meanData);

figure(1)
clf
set(gcf, 'Position', [50, 100, 300, 400]);  

plot(x, meanData, 'k', 'LineWidth', 2);
hold on;

fill([x, fliplr(x)], [meanData - semData, fliplr(meanData + semData)], 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
axis tight

ylabel('Delta pupil (%)', 'FontSize',16,'Color','k');
xlabel('Direction (deg)','FontSize',16,'Color','k');
set(gca,'xtick',[1:1:12],'xticklabel',[0:30:330],'ylim',[-5, 30.1]);
set(gca,'tickdir','out','fontsize',14,'ticklength',get(gca,'ticklength')*4);
box off

set(gcf,'paperunits','centimeters','papersize' ,[21,29.7],'color','w','paperposition',[0,0,21,29.7],'inverthardcopy','off');

order_nasal=[11,12,1,2,3,4];
order_temporal=[5,6,7,8,9,10];

data_nasal=pupil_delta_prct(:,order_nasal);
data_temporal=pupil_delta_prct(:,order_temporal);

[pval, ~]=ranksum(data_nasal(:), data_temporal(:),'Tail','right');
