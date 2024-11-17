clear all
load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1D_1E_1F.mat');

session_list=unique(data_Figure1.sessions_id)
animals_id=unique(data_Figure1.animal_id)

animal_id_list=data_Figure1.animal_id
sessions_id_list=data_Figure1.sessions_id

data_selected_in=data_Figure1.raw_relative_diam_delta;

nAnimal_sel=8
nruns = 1000
numSelections=6
numSamples = 1;

nconditions=12; 

alpha = 0.05;
alpha_Bonferroni = alpha / nruns;
    
permuted_pupil_data_cell={};

j=0;

for iruns=1:nruns;

    clear permuted_in
    permuted_in = animals_id(randperm(numel(animals_id)));
    permuted_animal_id=permuted_in(1:nAnimal_sel);
    
   
    tmp=[]
    tmp_per_animal=[];
    
    for iAn=1:length(permuted_animal_id);
        j=j+1;
        
       clear chosen_session
       clear animal_session_indexes
       clear random_session
       
       animal_session_indexes=find(animal_id_list==permuted_animal_id(iAn));
       clear weights
       clear random_session
       weights=(1/length(animal_session_indexes))*(ones(1,numel(animal_session_indexes)));
    
       random_session = randsample(numel(animal_session_indexes), numSamples, true, weights);

       selected_session=animal_session_indexes(random_session(1));
       selected_animal=permuted_animal_id(iAn);
       selected_trials=intersect(find(data_selected_in(:,2)==random_session(1)), find(data_selected_in(:,1)==selected_animal));
       
       weights_trial=(1/length(selected_trials))*(ones(1,numel(selected_trials)));
       selected_indexes = randsample(length(selected_trials),numSelections, true, weights_trial);
         
       permuted_selected_trials=selected_trials(selected_indexes);
       permuted_pupil_data_cell{j}=data_selected_in(permuted_selected_trials,:);
       permuted_data_mean_per_animal=nanmean(data_selected_in(permuted_selected_trials,:));
       tmp_per_animal=[tmp_per_animal; permuted_data_mean_per_animal];
       tmp=[tmp; data_selected_in(permuted_selected_trials,:)];

    end
    
    permuted_pupil_data_run_mean{iruns}=100*tmp_per_animal;
    permuted_pupil_data_run{iruns}=100*tmp;
    
end
%
for iruns=1:nruns
    permuted_pupil_data_run_mean_mean{iruns}=nanmean(permuted_pupil_data_run_mean{iruns});
end

%
points = 1:12;
pairs_both_sides = [];
for i = 1:length(points)
    for j = 1:length(points)
        if i ~= j
            pairs_both_sides = [pairs_both_sides; points(i), points(j)];
        end
    end
end

data_in=cell2mat(permuted_pupil_data_run_mean_mean');
add_val=3;  

clear data_all
for icond=1:nconditions
    data_all{icond}=data_in(:,icond+add_val);
end

ngroup=numel(data_all);
pairs=pairs_both_sides;

ranksumpval=nan(length(pairs),1);


for ipair=1:size(pairs,1)
    clear data1
    clear data2
    pair_now=pairs(ipair,:);    
    data1=data_all{pair_now(1)};
    data2=data_all{pair_now(2)};
    data1_mean(pair_now(1))=nanmean(data1);
    data2_mean(pair_now(2))=nanmean(data2);

    clear ranksumstat_tmp
    [ranksumpval(ipair),~,ranksumstat_tmp]=ranksum(rmmissing(data1(:)),rmmissing(data2(:)),'Tail','right');

end


mat_sig_now=zeros(ngroup);
pval_sig_now=zeros(ngroup);

for ipairs=1:size(pairs,1)
    
    if sum(ranksumpval(ipairs)>=0.05)==1
        pval_sig_now(pairs(ipairs,1),pairs(ipairs,2))=2
    elseif sum(ranksumpval(ipairs)<0.05 & ranksumpval(ipairs)>=0.01)==1
        pval_sig_now(pairs(ipairs,1),pairs(ipairs,2))=4;
    elseif sum(ranksumpval(ipairs)<0.01 & ranksumpval(ipairs)>=0.001)==1
        pval_sig_now(pairs(ipairs,1),pairs(ipairs,2))=6;
    elseif sum(ranksumpval(ipairs)<0.001)==1
        pval_sig_now(pairs(ipairs,1),pairs(ipairs,2))=8;
    end

end

A=magic(12);
[row, col] = meshgrid(1:12, 1:12);
diagonal_elements_subscript = A(row == col);

mat_sig_now=pval_sig_now;

mat_sig_now(diagonal_elements_subscript)=1;
mat_sig=mat_sig_now;


figure
[XX,YY]=meshgrid([1:ngroup+1]-0.5,[1:ngroup+1]-0.5);
hp=pcolor(XX,YY,padarray(mat_sig,[1 1],0,'post'));
set(hp,'edgecolor','w');
colorspace=brewermap(8,'Blues');
colormap(colorspace)
set(gca,'clim',[0 8]);
axis square ij
box on
set(gca,'xtick',[],'ytick',[]);


hold on;
text_legend_x = ngroup + 1.5; 
text_legend_y = [1:4]; 

text(text_legend_x, text_legend_y(1), 'ns', 'Color', colorspace(2, :), 'FontSize', 10, 'FontWeight', 'bold');
text(text_legend_x, text_legend_y(2), '< 0.05', 'Color', colorspace(4, :), 'FontSize', 10, 'FontWeight', 'bold');
text(text_legend_x, text_legend_y(3), '< 0.01', 'Color', colorspace(6, :), 'FontSize', 10, 'FontWeight', 'bold');
text(text_legend_x, text_legend_y(4), '< 0.001', 'Color', colorspace(8, :), 'FontSize', 10, 'FontWeight', 'bold');

hold off;
%
diams = 5; 

currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);

markersize = diams/diff(xlim)*min(axpos(3),axpos(4))*1.5; % Calculate Marker width in points
list_conditions={'0','30','60','90','120','150','180','210','240','270','300','330','control'}

set(gca,'xtick',[1:length(list_conditions)],'xticklabel',list_conditions);
set(gca,'ytick',[1:length(list_conditions)],'yticklabel',list_conditions);
xtickangle(90);

set(gca, 'TickDir', 'out', 'TickLength', get(gca, 'TickLength') * 4, 'FontSize', 14);
xlabel('DIRECTION X (deg)', 'FontSize', 14);
ylabel('DIRECTION Y (deg)', 'FontSize', 14);

box off
set(gcf,'paperunits','centimeters','papersize' ,[21,29.7],'color','w','paperposition',[0,0,21,29.7],'inverthardcopy','off');