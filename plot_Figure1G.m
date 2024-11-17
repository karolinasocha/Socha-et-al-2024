%% 
clear all
load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1G.mat');

order_nasal=[11,12,1,2,3,4];
order_temporal=[5,6,7,8,9,10];

mean_pupil_delta_anesthesia=100*cell2mat(Figure1G.avg_dPupil_vistim_anesthesia');
mean_pupil_delta_anesthesia=mean_pupil_delta_anesthesia(:,1:12);

meanData_ansth = nanmean(mean_pupil_delta_anesthesia);
stdData_ansth = nanstd(mean_pupil_delta_anesthesia);

semData_ansth = stdData_ansth ./ sqrt(size(mean_pupil_delta_anesthesia, 1));
x = 1:numel(meanData_ansth);
figure(1)
plot(x, meanData_ansth, 'b', 'LineWidth', 2);
hold on;

fill([x, fliplr(x)], [meanData_ansth - semData_ansth, fliplr(meanData_ansth + semData_ansth)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');


mean_pupil_delta_awake=100*cell2mat(Figure1G.avg_dPupil_vistim_awake');
mean_pupil_delta_awake=mean_pupil_delta_awake(:,1:12);

meanData_awake = nanmean(mean_pupil_delta_awake);
stdData_awake = nanstd(mean_pupil_delta_awake);

semData_awake = stdData_awake ./ sqrt(size(mean_pupil_delta_awake, 1));

plot(x, meanData_awake, 'k', 'LineWidth', 2);
hold on;

fill([x, fliplr(x)], [meanData_awake - semData_awake, fliplr(meanData_awake + semData_awake)], 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
axis tight

ylabel('Delta pupil (%)', 'FontSize',16,'Color','k');
xlabel('Direction (deg)','FontSize',16,'Color','k');
set(gca,'xtick',[1:1:12],'xticklabel',[0:30:330],'ylim',[-5, 40]);
set(gca,'tickdir','out','fontsize',14,'ticklength',get(gca,'ticklength')*4);
box off
set(gcf,'paperunits','centimeters','papersize' ,[21,29.7],'color','w','paperposition',[0,0,21,29.7],'inverthardcopy','off');


order_nasal=[11,12,1,2,3,4];
order_temporal=[5,6,7,8,9,10];

data_nasal_anesthesia=mean_pupil_delta_anesthesia(:,order_nasal);
data_temporal_anesthesia=mean_pupil_delta_anesthesia(:,order_temporal);
[pval_anesthesia, ~]=ranksum(data_nasal_anesthesia(:), data_temporal_anesthesia(:),'Tail','right');

pval_anesthesia