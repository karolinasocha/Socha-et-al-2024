clear all
load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1D_1E_1F.mat')

alpha=0.05
main_array_temporal= data_Figure1.avg_dPupil_perAnimal_temporalDirs ; 
main_array_nasal=data_Figure1.avg_dPupil_perAnimal_nasalDirs ;
num_animals=size(main_array_nasal,1);

mean_values_nasal_main = nanmean(main_array_nasal(:));
sem_values_nasal_main = std(main_array_nasal(:)) / sqrt(num_animals);

mean_values_temporal_main = nanmean(main_array_temporal(:));
sem_values_temporal_main = std(main_array_temporal(:)) / sqrt(num_animals);

alpha=0.05
t_value = tinv(1 - alpha/2, num_animals - 1);

lower_ci_nasal_main = mean_values_nasal_main - t_value * sem_values_nasal_main;
upper_ci_nasal_main = mean_values_nasal_main + t_value * sem_values_nasal_main;

lower_ci_temporal_main = mean_values_temporal_main - t_value * sem_values_temporal_main;
upper_ci_temporal_main = mean_values_temporal_main + t_value * sem_values_temporal_main;

colors=jet(13);
colors_transparency=colors;
colors_transparency(:,4)=0.5;

figure(1)
clf
set(gcf, 'Position', [50, 100, 300, 400]); 

for iAn=1:length(data_Figure1.avg_dPupil_perAnimal_allDirs)
    
    data_temporal=data_Figure1.avg_dPupil_perAnimal_temporalDirs(iAn,:);
    data_nasal=data_Figure1.avg_dPupil_perAnimal_nasalDirs(iAn,:);
    hold on
    
    s1=scatter(data_temporal(:),data_nasal(:),'o','MarkerFaceColor',[0.5, 0.5, 0.5],'MarkerEdgeColor','k');
    s1.MarkerFaceAlpha =.5;
    
    hold on;
    temporal_pupil(iAn)=nanmean(data_Figure1.avg_dPupil_perAnimal_temporalDirs(iAn,:));
    nasal_pupil(iAn)=nanmean(data_Figure1.avg_dPupil_perAnimal_nasalDirs(iAn,:));
    s2=scatter(temporal_pupil(iAn), nasal_pupil(iAn),'o','MarkerFaceColor',colors(iAn,:),'MarkerEdgeColor','k','SizeData', 100);
    hold on
    
end

hold on

errorbar(nanmean(temporal_pupil), nanmean(nasal_pupil), ...
    (mean_values_nasal_main- lower_ci_temporal_main),...
    (upper_ci_nasal_main - mean_values_nasal_main), ...
    (mean_values_temporal_main - lower_ci_temporal_main),...
    (upper_ci_temporal_main - mean_values_temporal_main),...
    'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k',...
    'LineWidth', 1.5,'Color','k', 'MarkerSize', 12);

plot([-100 100], [-100 100],'--k');

ylim([-10, 70])
xlim([-10, 40])

ylabel('Pupil size change (%) NASAL', 'FontSize',18,'Color','k');
xlabel('Pupil size change (%) TEMPORAL','FontSize',18,'Color','k');
set(gca,'tickdir','out','fontsize',14,'ticklength',get(gca,'ticklength')*4);
box off

set(gcf,'paperunits','centimeters','papersize' ,[21,29.7],'color','w','paperposition',[0,0,21,29.7],'inverthardcopy','off');

