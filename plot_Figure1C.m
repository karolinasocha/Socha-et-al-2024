clear all

load('G:\mousebox\code\mouselab\users\karolina\FiguresPaper2023\data_release\data_Figure1C_1D_1E_1F.mat');
array_pupil_data_perAnimal=data_Figure1.avg_zPupil_perAnimal_dynamic

array_pupil_data_perAnimal = data_Figure1.avg_zPupil_perAnimal_dynamic;

ylimitation = [-1 1.5];
pre_frames = 62;
post_frames = 247;
stim_frames = 217;
stim_vector = pre_frames + 1:315:3780;

iStim_0 = stim_vector(1); % 0 deg
iStim_180 = stim_vector(7); % 180 deg
iStim_90 = stim_vector(4); % 90 deg
iStim_270 = stim_vector(10); % 270 deg
iStim_300 = stim_vector(11); % 300 deg
iStim_330 = stim_vector(12); % 330 deg
iStim_30 = stim_vector(2); % 30 deg
iStim_60 = stim_vector(3); % 60 deg
iStim_120 = stim_vector(5); % 120 deg
iStim_150 = stim_vector(6); % 150 deg
iStim_210 = stim_vector(8); % 210 deg
iStim_240 = stim_vector(9); % 240 deg

fig(1) = figure('name', sprintf('Pupil size behaviour'), 'color', 'w', 'paperunits', ...
    'centimeters', 'papersize', [20, 20], 'paperposition', [0, 0, 20, 20]);

ax_positions = [
    0.05, 0.75, 0.13, 0.2; % Subplot 1: 310-150
    0.20, 0.75, 0.13, 0.2; % Subplot 2: 0-180
    0.35, 0.75, 0.13, 0.2; % Subplot 3: 30-210
    0.50, 0.75, 0.13, 0.2; % Subplot 4: 60-240
    0.65, 0.75, 0.13, 0.2; % Subplot 5: 90-270
    0.80, 0.75, 0.13, 0.2; % Subplot 6: 300-120
];

area_ax_positions = [
    0.05, 0.2, 0.13, 0.2;  % Position for subplot 1: 310-150
    0.20, 0.2, 0.13, 0.2;  % Position for subplot 2: 0-180
    0.35, 0.2, 0.13, 0.2;  % Position for subplot 3: 30-210
    0.50, 0.2, 0.13, 0.2;  % Position for subplot 4: 60-240
    0.65, 0.2, 0.13, 0.2;  % Position for subplot 5: 90-270
    0.80, 0.2, 0.13, 0.2;  % Position for subplot 6: 300-120
];

area_axes = {
    axes('Position', area_ax_positions(1, :), 'Units', 'normalized');  % Area axis for 330° vs 150°
    axes('Position', area_ax_positions(2, :), 'Units', 'normalized');  % Area axis for 0° vs 180°
    axes('Position', area_ax_positions(3, :), 'Units', 'normalized');  % Area axis for 30° vs 210°
    axes('Position', area_ax_positions(4, :), 'Units', 'normalized');  % Area axis for 60° vs 240°
    axes('Position', area_ax_positions(5, :), 'Units', 'normalized');  % Area axis for 90° vs 270°
    axes('Position', area_ax_positions(6, :), 'Units', 'normalized');  % Area axis for 300° vs 120°
};


nasal_color = [0 0.5 1];
temporal_color = [0.5 0.5 0.5];

ax_pupildynamics_allsessions_plot_330 = axes('Position', ax_positions(1, :), 'Units', 'normalized');
ax_pupildynamics_allsessions_plot_0 = axes('Position', ax_positions(2, :), 'Units', 'normalized');
ax_pupildynamics_allsessions_plot_30 = axes('Position', ax_positions(3, :), 'Units', 'normalized');
ax_pupildynamics_allsessions_plot_60 = axes('Position', ax_positions(4, :), 'Units', 'normalized');
ax_pupildynamics_allsessions_plot_90 = axes('Position', ax_positions(5, :), 'Units', 'normalized');
ax_pupildynamics_allsessions_plot_120 = axes('Position', ax_positions(6, :), 'Units', 'normalized');

area_ax_330 = axes('Position', area_ax_positions(1, :), 'Units', 'normalized');
area_ax_0 = axes('Position', area_ax_positions(2, :), 'Units', 'normalized');
area_ax_30 = axes('Position', area_ax_positions(3, :), 'Units', 'normalized');
area_ax_60 = axes('Position', area_ax_positions(4, :), 'Units', 'normalized');
area_ax_90 = axes('Position', area_ax_positions(5, :), 'Units', 'normalized');
area_ax_120 = axes('Position', area_ax_positions(6, :), 'Units', 'normalized');

tmp1 = array_pupil_data_perAnimal;

% 330° vs 150° 
tmp_toplot = tmp1(:, (iStim_330) - pre_frames:iStim_330 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_150) - pre_frames:iStim_150 + post_frames);

substraction_values(1,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_330);
hold on;

h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

x_shade = [pre_frames stim_frames]; % between 0 and 5 seconds
y_shade = ylimitation; 
fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_330, 'ytick', min(ylimitation):0.5:max(ylimitation), ...
    'xtick', [0, pre_frames, stim_frames, pre_frames + post_frames], 'xticklabel', [-2, 0, 5, 8], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
xlabel('Time(s)');
title('330-150');
ylabel(ax_pupildynamics_allsessions_plot_330, 'Pupil area zscore', 'FontSize', 14)
    
% 0° vs 180° 
tmp_toplot = tmp1(:, (iStim_0) - pre_frames:iStim_0 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_180) - pre_frames:iStim_180 + post_frames);

substraction_values(2,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_0);
hold on;
h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_0, 'ytick', [], 'xtick', [], 'xticklabel', [], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
title('0-180');

% 30° vs 210°
tmp_toplot = tmp1(:, (iStim_30) - pre_frames:iStim_30 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_210) - pre_frames:iStim_210 + post_frames);

substraction_values(3,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_30);
hold on;
h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_30, 'ytick', [], 'xtick', [], 'xticklabel', [], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
title('90-210');

% 60° vs 240° 
tmp_toplot = tmp1(:, (iStim_60) - pre_frames:iStim_60 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_240) - pre_frames:iStim_240 + post_frames);

substraction_values(4,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_60);
hold on;
h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_60, 'ytick', [], 'xtick', [], 'xticklabel', [], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
title('60-240');

% 90° vs 270° 
tmp_toplot = tmp1(:, (iStim_90) - pre_frames:iStim_90 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_270) - pre_frames:iStim_270 + post_frames);

substraction_values(5,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_90);
hold on;
h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_90, 'ytick', [], 'xtick', [], 'xticklabel', [], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
title('90-270');

% 300° vs 120° 
tmp_toplot = tmp1(:, (iStim_300) - pre_frames:iStim_300 + post_frames);
tmp_toplot_contrary = tmp1(:, (iStim_120) - pre_frames:iStim_120 + post_frames);

substraction_values(6,:)=nanmean(tmp_toplot,1)-nanmean(tmp_toplot_contrary,1);

axes(ax_pupildynamics_allsessions_plot_120);
hold on;
h1 = shadedErrorBar(1:length(tmp_toplot), nanmean(tmp_toplot, 1), ...
    nanstd(tmp_toplot, [], 1) ./ sqrt(size(tmp_toplot, 1)), 'k');
h1.patch.FaceColor = nasal_color;
h1.patch.FaceAlpha = 1;
h = shadedErrorBar(1:length(tmp_toplot_contrary), nanmean(tmp_toplot_contrary, 1), ...
    nanstd(tmp_toplot_contrary, [], 1) ./ sqrt(size(tmp_toplot_contrary, 1)), 'k');
h.patch.FaceColor = temporal_color;
h.patch.FaceAlpha = 1;

fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
    [y_shade(1) y_shade(2) y_shade(2) y_shade(1)], ...
    [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

axis tight;
plot([pre_frames pre_frames], ylimitation, '--k');
plot([stim_frames stim_frames], ylimitation, '--k');

set(ax_pupildynamics_allsessions_plot_120, 'ytick', [], 'xtick', [], 'xticklabel', [], ...
    'tickdir', 'out', 'box', 'off', 'layer', 'top', 'color', 'none', 'fontsize', 14);
ylim(ylimitation);
title('300-120');

    
ylimitation_areazscored = [-0.5 1.5];
frameRate = 315/10;
pre_frames = round(2 * frameRate);
post_frames = round((2 + 5 + 3) * frameRate);
stim_frames = pre_frames + round(5 * frameRate);
val = [-2.2, 0, 5, 8];

area_axes = {area_ax_330, area_ax_0, area_ax_30, area_ax_60, area_ax_90, area_ax_120};  % Store all area axes in a cell array

for iStim = 1:6
    current_ax = area_axes{iStim};  
    
    axes(current_ax); 
    area_diff = substraction_values(iStim, :);  
    
    a_ax = area(area_diff);
    a_ax.FaceColor = [0.5 0.5 0.5];  
    axis tight;
    hold on;
    
    fill([x_shade(1) x_shade(1) x_shade(2) x_shade(2)], ...
        [ylimitation_areazscored(1) ylimitation_areazscored(2) ylimitation_areazscored(2) ylimitation_areazscored(1)], ...
        [0.5 0.5 0.5], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    
    plot([pre_frames pre_frames], ylimitation_areazscored, '--k');
    plot([stim_frames stim_frames], ylimitation_areazscored, '--k');
    if iStim == 1  
        set(current_ax, ...
            'ytick', min(ylimitation_areazscored):0.5:max(ylimitation_areazscored), ... 
            'xtick', [0, 5], ... 
            'xticklabel', val, ... 
            'tickdir', 'out', ...
            'box', 'off', ...
            'layer', 'top', ...
            'color', 'none', ...
            'fontsize', 14, ...
            'ticklength', get(current_ax, 'ticklength') * 4);
        ylabel(current_ax, 'Pupil area difference', 'FontSize', 14);
    else 
        set(current_ax, ...
            'ytick', [], ...
            'yticklabel', [], ...
            'xtick', [], ...
            'xticklabel', [], ... 
            'tickdir', 'out', ...
            'box', 'off', ...
            'layer', 'top', ...
            'color', 'none', ...
            'fontsize', 14, ... 
            'ticklength', get(current_ax, 'ticklength') * 4);
    end
end

