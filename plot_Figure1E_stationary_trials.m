
clear all
load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1C_1D_1E_1F.mat');
pupil_data_in=data_Figure1.avg_dPupil_vistim_trials;
trials_still_array=data_Figure1.array_trials_stionary

nStims=12
order_nasal=[11,12,1,2,3,4];
order_temporal=[5,6,7,8,9,10];

pupil_still_mean=NaN(length(pupil_data_in), 12);
pval_session_still=nan(length(pupil_data_in),1);

for iSess=1:length(pupil_data_in)
    clear pupil_data_tmp
    pupil_data_tmp=pupil_data_in{iSess};
    appendedArray_still_tmp= NaN(15, 12);
    
    for iStim=1:nStims;
    clear tmp_still
    clear tmp_loc
    
    [still_trial still_stim_tmp]=find(trials_still_array{iSess}(:,iStim)==1);
    appendedArray_still_tmp(1:length(still_trial),iStim)=pupil_data_tmp(still_trial,iStim);
    toaverage_still=pupil_data_tmp(still_trial,iStim);
    pupil_still_mean(iSess,iStim)=nanmean(toaverage_still,1);

    end

    appendedArray_still{iSess}=appendedArray_still_tmp;
    
end

%
for iSess=1:length(appendedArray_still)
mean_sess_appendedArray_still(iSess,:)=nanmean(appendedArray_still{iSess})
end

animal_id_list=unique(data_Figure1.animal_id);
session_id=data_Figure1.sessions_id;
animal_id=data_Figure1.animal_id;

for iAn=1:length(animal_id_list)
    indecies=find(data_Figure1.animal_id==animal_id_list(iAn));
    average_stationary(iAn,:)=nanmean(mean_sess_appendedArray_still(indecies,:),1);
end

data_nasal=average_stationary(:,order_nasal);
data_temporal=average_stationary(:,order_temporal);

[pval_still, ~]=ranksum(data_nasal(:), data_temporal(:),'Tail','right');

%
mean_all_still=100*nanmean(average_stationary,1);
sem_all_still=100*nanstd(average_stationary,1)./sqrt(size(average_stationary, 1));

x = 1:numel(mean_all_still);

figure(1)
hold on
plot(x, mean_all_still, 'k', 'LineWidth', 2);
hold on;
fill([x, fliplr(x)], [mean_all_still - sem_all_still, fliplr(mean_all_still + sem_all_still)], 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight

ylabel('Pupil size change (%)', 'FontSize',16,'Color','k');
xlabel('Directions (deg)','FontSize',16,'Color','k');
set(gca,'xtick',[1:1:12],'xticklabel',[0:30:330],'ylim',[-10, 30.1]);
set(gca,'tickdir','out','fontsize',14,'ticklength',get(gca,'ticklength')*4);
box off