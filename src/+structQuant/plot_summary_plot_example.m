function plot_summary_plot_example(plot_save_folder, layer2_dendrite_level1_summary, layer2_summary, layer4_dendrite_level1_summary, layer4_summary, layer5_dendrite_level1_summary, layer5_summary)


    spine_dendrite_type_label5 = layer5_dendrite_level1_summary.spine_dendrite_type_label; % [1: filopodia, 2: mushroom, 3: long thin, 4: thin, 5: stubby, dendrite_label] Ns x 2
    dendrite_length5  = layer5_dendrite_level1_summary.dendrite_length; % Nd x 1
    dendrite_radius5 = layer5_dendrite_level1_summary.dendrite_radius; % Nd x 1 
    dendrite_each_spine_type_number5 = layer5_dendrite_level1_summary.dendrite_each_spine_type_number; % specifically add the 6th type as the branched spine, simply to check between different layers Nd x 6
    neuron_total_type_number5 = layer5_dendrite_level1_summary.neuron_total_type_number; % Nn x 6

    spine_dendrite_type_label4 = layer4_dendrite_level1_summary.spine_dendrite_type_label; % [1: filopodia, 2: mushroom, 3: long thin, 4: thin, 5: stubby, dendrite_label] Ns x 2
    dendrite_length4  = layer4_dendrite_level1_summary.dendrite_length; % Nd x 1
    dendrite_radius4 = layer4_dendrite_level1_summary.dendrite_radius; % Nd x 1 
    dendrite_each_spine_type_number4 = layer4_dendrite_level1_summary.dendrite_each_spine_type_number; % specifically add the 6th type as the branched spine, simply to check between different layers Nd x 6
    neuron_total_type_number4 = layer4_dendrite_level1_summary.neuron_total_type_number; % Nn x 6

    spine_dendrite_type_label2 = layer2_dendrite_level1_summary.spine_dendrite_type_label; % [1: filopodia, 2: mushroom, 3: long thin, 4: thin, 5: stubby, dendrite_label] Ns x 2
    dendrite_length2  = layer2_dendrite_level1_summary.dendrite_length; % Nd x 1
    dendrite_radius2 = layer2_dendrite_level1_summary.dendrite_radius; % Nd x 1 
    dendrite_each_spine_type_number2 = layer2_dendrite_level1_summary.dendrite_each_spine_type_number; % specifically add the 6th type as the branched spine, simply to check between different layers Nd x 6
    neuron_total_type_number2 = layer2_dendrite_level1_summary.neuron_total_type_number; % Nn x 6


    singleSynHeadVolume5 = layer5_summary.singleSynHeadVolume;
    singleSynMeanHeadRadius5 = layer5_summary.singleSynMeanHeadRadius;
    singleSynNeckLength5 = layer5_summary.singleSynNeckLength;
    singleSynNeckSection5 = layer5_summary.singleSynNeckSection;
    singleSynNeckMeanRadius5 = layer5_summary.singleSynNeckMeanRadius;
    doubleSynHeadVolume5 = layer5_summary.doubleSynHeadVolume;
    doubleSynMeanHeadRadius5 = layer5_summary.doubleSynMeanHeadRadius;
    doubleSynNeckLength5 = layer5_summary.doubleSynNeckLength;
    doubleSynNeckSection5 = layer5_summary.doubleSynNeckSection;
    doubleSynNeckMeanRadius5 = layer5_summary.doubleSynNeckMeanRadius;
    singleSynapticCleftSize5 = layer5_summary.singleSynapticCleftSize;
    % singleDendriteDensity5 = layer5_summary.singleDendriteDensity;
    sinsperimeterRatio5 = layer5_summary.sinsperimeterRatio;
    sinsperimeterWeightedWrappingArea5 = layer5_summary.sinsperimeterWeightedWrappingArea;
    sinspostSynapseTouchingArea5 = layer5_summary.sinspostSynapseTouchingArea;
    sinspostSynapseTouchingRatio5 = layer5_summary.sinspostSynapseTouchingRatio;
    sinspreSynapseTouchingArea5 = layer5_summary.sinspreSynapseTouchingArea;
    sinspreSynapseTouchingRatio5 = layer5_summary.sinspreSynapseTouchingRatio;
    singleSynHeadNeckTouchingArea5 = layer5_summary.singleSynHeadNeckTouchingArea;
    singleSynHeadNeckTouchingRatio5 = layer5_summary.singleSynHeadNeckTouchingRatio;
    % doubleDendriteDensity5 = layer5_summary.doubleDendriteDensity;
    doubleSynapticCleftSize5 = layer5_summary.doubleSynapticCleftSize;
    dousperimeterRatio5 = layer5_summary.dousperimeterRatio;
    dousperimeterWeightedWrappingArea5 = layer5_summary.dousperimeterWeightedWrappingArea;
    douspostSynapseTouchingArea5  = layer5_summary.douspostSynapseTouchingArea;
    douspostSynapseTouchingRatio5 = layer5_summary.douspostSynapseTouchingRatio;
    douspreSynapseTouchingArea5  = layer5_summary.douspreSynapseTouchingArea;
    douspreSynapseTouchingRatio5 = layer5_summary.douspreSynapseTouchingRatio;
    doubleSynHeadNeckTouchingArea5 = layer5_summary.doubleSynHeadNeckTouchingArea;
    doubleSynHeadNeckTouchingRatio5 = layer5_summary.doubleSynHeadNeckTouchingRatio;
    % doubleSynPosition5 = layer5_summary.doubleSynPosition;
    % spineCoordinate5  =layer5_summary.spineCoordinate;

    singleSynHeadVolume2 = layer2_summary.singleSynHeadVolume;
    singleSynMeanHeadRadius2 = layer2_summary.singleSynMeanHeadRadius;
    singleSynNeckLength2 = layer2_summary.singleSynNeckLength;
    singleSynNeckSection2 = layer2_summary.singleSynNeckSection;
    singleSynNeckMeanRadius2 = layer2_summary.singleSynNeckMeanRadius;
    doubleSynHeadVolume2 = layer2_summary.doubleSynHeadVolume;
    doubleSynMeanHeadRadius2 = layer2_summary.doubleSynMeanHeadRadius;
    doubleSynNeckLength2 = layer2_summary.doubleSynNeckLength;
    doubleSynNeckSection2 = layer2_summary.doubleSynNeckSection;
    doubleSynNeckMeanRadius2 = layer2_summary.doubleSynNeckMeanRadius;
    singleSynapticCleftSize2 = layer2_summary.singleSynapticCleftSize;
    sinsperimeterRatio2 = layer2_summary.sinsperimeterRatio;
    sinsperimeterWeightedWrappingArea2 = layer2_summary.sinsperimeterWeightedWrappingArea;
    sinspostSynapseTouchingArea2 = layer2_summary.sinspostSynapseTouchingArea;
    sinspostSynapseTouchingRatio2 = layer2_summary.sinspostSynapseTouchingRatio;
    sinspreSynapseTouchingArea2 = layer2_summary.sinspreSynapseTouchingArea;
    sinspreSynapseTouchingRatio2 = layer2_summary.sinspreSynapseTouchingRatio;
    singleSynHeadNeckTouchingArea2 = layer2_summary.singleSynHeadNeckTouchingArea;
    singleSynHeadNeckTouchingRatio2 = layer2_summary.singleSynHeadNeckTouchingRatio;
    doubleSynapticCleftSize2 = layer2_summary.doubleSynapticCleftSize;
    dousperimeterRatio2 = layer2_summary.dousperimeterRatio;
    dousperimeterWeightedWrappingArea2 = layer2_summary.dousperimeterWeightedWrappingArea;
    douspostSynapseTouchingArea2  = layer2_summary.douspostSynapseTouchingArea;
    douspostSynapseTouchingRatio2 = layer2_summary.douspostSynapseTouchingRatio;
    douspreSynapseTouchingArea2 = layer2_summary.douspreSynapseTouchingArea;
    douspreSynapseTouchingRatio2 = layer2_summary.douspreSynapseTouchingRatio;
    doubleSynHeadNeckTouchingArea2 = layer2_summary.doubleSynHeadNeckTouchingArea;
    doubleSynHeadNeckTouchingRatio2 = layer2_summary.doubleSynHeadNeckTouchingRatio;
    % doubleSynPosition2 = layer2_summary.doubleSynPosition;
    % spineCoordinate2  =layer2_summary.spineCoordinate;
    % singleDendriteDensity2 = layer2_summary.singleDendriteDensity;
    % doubleDendriteDensity2 = layer2_summary.doubleDendriteDensity;

    singleSynHeadVolume4 = layer4_summary.singleSynHeadVolume;
    singleSynMeanHeadRadius4 = layer4_summary.singleSynMeanHeadRadius;
    singleSynNeckLength4 = layer4_summary.singleSynNeckLength;
    singleSynNeckSection4 = layer4_summary.singleSynNeckSection;
    singleSynNeckMeanRadius4 = layer4_summary.singleSynNeckMeanRadius;
    doubleSynHeadVolume4 = layer4_summary.doubleSynHeadVolume;
    doubleSynMeanHeadRadius4 = layer4_summary.doubleSynMeanHeadRadius;
    doubleSynNeckLength4 = layer4_summary.doubleSynNeckLength;
    doubleSynNeckSection4 = layer4_summary.doubleSynNeckSection;
    doubleSynNeckMeanRadius4 = layer4_summary.doubleSynNeckMeanRadius;
    singleSynapticCleftSize4 = layer4_summary.singleSynapticCleftSize;
    sinsperimeterRatio4 = layer4_summary.sinsperimeterRatio;
    sinsperimeterWeightedWrappingArea4 = layer4_summary.sinsperimeterWeightedWrappingArea;
    sinspostSynapseTouchingArea4 = layer4_summary.sinspostSynapseTouchingArea;
    sinspostSynapseTouchingRatio4 = layer4_summary.sinspostSynapseTouchingRatio;
    sinspreSynapseTouchingArea4 = layer4_summary.sinspreSynapseTouchingArea;
    sinspreSynapseTouchingRatio4 = layer4_summary.sinspreSynapseTouchingRatio;
    singleSynHeadNeckTouchingArea4 = layer4_summary.singleSynHeadNeckTouchingArea;
    singleSynHeadNeckTouchingRatio4 = layer4_summary.singleSynHeadNeckTouchingRatio;
    doubleSynapticCleftSize4 = layer4_summary.doubleSynapticCleftSize;
    dousperimeterRatio4 = layer4_summary.dousperimeterRatio;
    dousperimeterWeightedWrappingArea4 = layer4_summary.dousperimeterWeightedWrappingArea;
    douspostSynapseTouchingArea4  = layer4_summary.douspostSynapseTouchingArea;
    douspostSynapseTouchingRatio4 = layer4_summary.douspostSynapseTouchingRatio;
    douspreSynapseTouchingArea4  = layer4_summary.douspreSynapseTouchingArea;
    douspreSynapseTouchingRatio4 = layer4_summary.douspreSynapseTouchingRatio;
    doubleSynHeadNeckTouchingArea4 = layer4_summary.doubleSynHeadNeckTouchingArea;
    doubleSynHeadNeckTouchingRatio4 = layer4_summary.doubleSynHeadNeckTouchingRatio;




%%================================================================================================
% split the dendrites into thick and thin dendrites (plot the histogram)
total_radius = [dendrite_radius2;dendrite_radius4;dendrite_radius5];
[small_radius_id, large_radius_id] = structQuant.gmm_fit_radius(total_radius);
aa = total_radius;
split_point = max(aa(small_radius_id));
small_radius_id_2 = find(dendrite_radius2 < split_point & dendrite_radius2 > 0);
small_radius_id_4 = find(dendrite_radius4 < split_point & dendrite_radius4 > 0);
small_radius_id_5 = find(dendrite_radius5 < split_point & dendrite_radius5 > 0);
large_radius_id_2 = find(dendrite_radius2 > split_point & dendrite_radius2 > 0);
large_radius_id_4 = find(dendrite_radius4 > split_point & dendrite_radius4 > 0);
large_radius_id_5 = find(dendrite_radius5 > split_point & dendrite_radius5 > 0);

spine_dendrite_idx2 = label2idx(spine_dendrite_type_label2(:,2));
spine_dendrite_idx2 = spine_dendrite_idx2(:);
spine_dendrite_idx4 = label2idx(spine_dendrite_type_label4(:,2));
spine_dendrite_idx4 = spine_dendrite_idx4(:);
spine_dendrite_idx5 = label2idx(spine_dendrite_type_label5(:,2));
spine_dendrite_idx5 = spine_dendrite_idx5(:);
spine_small_radius_id_2 = cell2mat(spine_dendrite_idx2(small_radius_id_2));
spine_small_radius_id_4 = cell2mat(spine_dendrite_idx4(small_radius_id_4));
spine_small_radius_id_5 = cell2mat(spine_dendrite_idx5(small_radius_id_5));

spine_large_radius_id_2 = cell2mat(spine_dendrite_idx2(large_radius_id_2));
spine_large_radius_id_4 = cell2mat(spine_dendrite_idx4(large_radius_id_4));
spine_large_radius_id_5 = cell2mat(spine_dendrite_idx5(large_radius_id_5));



%%================================================================================================
% plot the statistics related to dendrite length
structQuant.reset_values_summary_statistics;
singleSynNeckLength2(singleSynNeckLength2 == 0 |isinf(singleSynNeckLength2)|isnan(singleSynNeckLength2)) = [];
singleSynNeckLength2(singleSynNeckLength2 > quantile(singleSynNeckLength2, 0.99)) = [];
singleSynNeckLength4(singleSynNeckLength4 == 0 |isinf(singleSynNeckLength4)|isnan(singleSynNeckLength4)) = [];
singleSynNeckLength4(singleSynNeckLength4 > quantile(singleSynNeckLength4, 0.99)) = [];
singleSynNeckLength5(singleSynNeckLength5 == 0 |isinf(singleSynNeckLength5)|isnan(singleSynNeckLength5)) = [];
singleSynNeckLength5(singleSynNeckLength5 > quantile(singleSynNeckLength5, 0.99)) = [];

data = [mean(singleSynNeckLength2), mean(singleSynNeckLength4), mean(singleSynNeckLength5)];
err = [[std(singleSynNeckLength2)/sqrt(length(singleSynNeckLength2)), std(singleSynNeckLength4)/sqrt(length(singleSynNeckLength4))...
, std(singleSynNeckLength5)/sqrt(length(singleSynNeckLength5))]];
figure;  % Creates a new figure
b = bar(data,'BarWidth', 0.8);
b.FaceColor = 'flat';
set(gca, 'XTickLabel',{'L2/3','L4','L5'})
b.CData(1,:) = [0.8500, 0.3250, 0.0980];
b.CData(2,:) = [0, 0.4470, 0.7410];
b.CData(3,:) = [0.9290, 0.6940, 0.1250];
% b(1).FaceColor = [0.8500, 0.3250, 0.0980];  % Color for Variable 1
% b(2).FaceColor = [0, 0.4470, 0.7410];  % Color for Variable 2
% b(3).FaceColor = [0.9290, 0.6940, 0.1250];  % Color for Variable 3% Plots grouped bar chart
ylabel('neck length (nm)');  % Y-axis label for the values of the variables
title('dendrite spine neck length');  % Chart title
numGroups = size(data, 1);
numBars = size(data, 2);
% Add error bars
hold on;
for i = 1:numBars
    % X positions for error bars
    x = b.XEndPoints(i);
    % Add error bars to each group
    errorbar(x, data(:, i), err(:, i), '.k', 'LineWidth', 1.5);
end


bar_plot_mean = cell(3,1);
bar_plot_mean{1} = data(:,1);
bar_plot_mean{2} = data(:,2);
bar_plot_mean{3} = data(:,3);
bar_plot_test = cell(3,2);
bar_plot_test{1,1} = singleSynNeckLength2;
bar_plot_test{2,1} = singleSynNeckLength4;
bar_plot_test{3,1} = singleSynNeckLength5;
hold on;
[position_cell, pvalueArray] = structQuant.plot_significance_score_cell_cell(bar_plot_mean, bar_plot_test, b);
sigstar(position_cell,pvalueArray)
saveas(gcf, fullfile(plot_save_folder, 'dendrite_spine_neck_length.png'));
close(gcf);


%% bar plot of neck length comparing between dendrite with large radius and small radius
structQuant.reset_values_summary_statistics;
singleSynNeckLength2_small = singleSynNeckLength2(spine_small_radius_id_2);
singleSynNeckLength2_small(singleSynNeckLength2_small == 0) = [];
singleSynNeckLength2_small(singleSynNeckLength2_small > quantile(singleSynNeckLength2_small, 0.99)) = [];
singleSynNeckLength2_small(isnan(singleSynNeckLength2_small)) = [];
singleSynNeckLength2_small(isinf(singleSynNeckLength2_small)) = [];

singleSynNeckLength4_small = singleSynNeckLength4(spine_small_radius_id_4);
singleSynNeckLength4_small(singleSynNeckLength4_small == 0) = [];
singleSynNeckLength4_small(singleSynNeckLength4_small > quantile(singleSynNeckLength4_small, 0.99)) = [];
singleSynNeckLength4_small(isnan(singleSynNeckLength4_small)) = [];
singleSynNeckLength4_small(isinf(singleSynNeckLength4_small)) = [];

singleSynNeckLength5_small = singleSynNeckLength5(spine_small_radius_id_5);
singleSynNeckLength5_small(singleSynNeckLength5_small == 0) = [];
singleSynNeckLength5_small(singleSynNeckLength5_small > quantile(singleSynNeckLength5_small, 0.99)) = [];
singleSynNeckLength5_small(isnan(singleSynNeckLength5_small)) = [];
singleSynNeckLength5_small(isinf(singleSynNeckLength5_small)) = [];

singleSynNeckLength2_large = singleSynNeckLength2(spine_large_radius_id_2);
singleSynNeckLength2_large(singleSynNeckLength2_large == 0) = [];
singleSynNeckLength2_large(singleSynNeckLength2_large > quantile(singleSynNeckLength2_large, 0.99)) = [];
singleSynNeckLength2_large(isnan(singleSynNeckLength2_large)) = [];
singleSynNeckLength2_large(isinf(singleSynNeckLength2_large)) = [];

singleSynNeckLength4_large = singleSynNeckLength4(spine_large_radius_id_4);
singleSynNeckLength4_large(singleSynNeckLength4_large == 0) = [];
singleSynNeckLength4_large(singleSynNeckLength4_large > quantile(singleSynNeckLength4_large, 0.99)) = [];
singleSynNeckLength4_large(isnan(singleSynNeckLength4_large)) = [];
singleSynNeckLength4_large(isinf(singleSynNeckLength4_large)) = [];

singleSynNeckLength5_large = singleSynNeckLength5(spine_large_radius_id_5);
singleSynNeckLength5_large(singleSynNeckLength5_large == 0) = [];
singleSynNeckLength5_large(singleSynNeckLength5_large > quantile(singleSynNeckLength5_large, 0.99)) = [];
singleSynNeckLength5_large(isnan(singleSynNeckLength5_large)) = [];
singleSynNeckLength5_large(isinf(singleSynNeckLength5_large)) = [];

data = [[mean(singleSynNeckLength2_small), mean(singleSynNeckLength4_small), mean(singleSynNeckLength5_small)];
    [mean(singleSynNeckLength2_large), mean(singleSynNeckLength4_large), mean(singleSynNeckLength5_large)]];
err = [[std(singleSynNeckLength2_small)/sqrt(length(singleSynNeckLength2_small)), std(singleSynNeckLength4_small)/sqrt(length(singleSynNeckLength4_small)), std(singleSynNeckLength5_small)/sqrt(length(singleSynNeckLength5_small))];
    [std(singleSynNeckLength2_large)/sqrt(length(singleSynNeckLength2_large)), std(singleSynNeckLength4_large)/sqrt(length(singleSynNeckLength4_large)), std(singleSynNeckLength5_large)/sqrt(length(singleSynNeckLength5_large))]];

figure;  % Creates a new figure
b = bar(data,'BarWidth', 0.8);
b(1).FaceColor = [0.8500, 0.3250, 0.0980];  % Color for Variable 1
b(2).FaceColor = [0, 0.4470, 0.7410];  % Color for Variable 2
b(3).FaceColor = [0.9290, 0.6940, 0.1250];  % Color for Variable 3% Plots grouped bar chart
ylabel('radius (nm)');  % Y-axis label for the values of the variables
title('neck length in thick and thin dendrites');  % Chart title
numGroups = size(data, 1);
numBars = size(data, 2);
% Add error bars
hold on;
for i = 1:numBars
    % X positions for error bars
    x = b(i).XEndPoints;
    % Add error bars to each group
    errorbar(x, data(:, i), err(:, i), '.k', 'LineWidth', 1.5);
end

groupNames = {'smaller dendrite radius', 'larger dendrite radius'}; % Custom names for each group of bars
xticks(1:length(groupNames)); % Set the x-axis ticks to match the number of groups
xticklabels(groupNames);



bar_plot_mean = cell(3,1);
bar_plot_mean{1} = data(:,1);
bar_plot_mean{2} = data(:,2);
bar_plot_mean{3} = data(:,3);
bar_plot_test = cell(3,2);
bar_plot_test{1,1} = singleSynNeckLength2_small;
bar_plot_test{1,2} = singleSynNeckLength2_large;
bar_plot_test{2,1} = singleSynNeckLength4_small;
bar_plot_test{2,2} = singleSynNeckLength4_large;
bar_plot_test{3,1} = singleSynNeckLength5_small;
bar_plot_test{3,2} = singleSynNeckLength5_large;
hold on;
[position_cell, pvalueArray] = plot_significance_score_cell_cell(bar_plot_mean, bar_plot_test, b);
sigstar(position_cell,pvalueArray)
legend('L2/3', 'L4', 'L5')

saveas(gcf, fullfile(plot_save_folder, 'dendrite_spine_neck_length_large_small_radius.png'));
close(gcf);


%%================================================================================================
% plot the dendrite spine head volume 

structQuant.reset_values_summary_statistics;

singleSynHeadVolume2(singleSynHeadVolume2 == 0) = [];
singleSynHeadVolume4(singleSynHeadVolume4 == 0) = [];
singleSynHeadVolume5(singleSynHeadVolume5 == 0) = [];
singleSynHeadVolume2 = singleSynHeadVolume2.*16.*16.*40/10^9;
singleSynHeadVolume4 = singleSynHeadVolume4.*16.*16.*40/10^9;
singleSynHeadVolume5 = singleSynHeadVolume5.*16.*16.*40/10^9;
% x = [singleSynHeadVolume2(:);singleSynHeadVolume4(:);singleSynHeadVolume5(:)];
% x = x.*16.*16.*40/10^9;
% y = [zeros(length(singleSynHeadVolume2(:)),1);ones(length(singleSynHeadVolume4(:)),1);ones(length(singleSynHeadVolume5(:)),1).*2];
data = [mean(singleSynHeadVolume2), mean(singleSynHeadVolume4), mean(singleSynHeadVolume5)];
err = [[std(singleSynHeadVolume2)/sqrt(length(singleSynHeadVolume2)), std(singleSynHeadVolume4)/sqrt(length(singleSynHeadVolume4))...
, std(singleSynHeadVolume5)/sqrt(length(singleSynHeadVolume5))]];
figure;  % Creates a new figure
b = bar(data,'BarWidth', 0.8);
b.FaceColor = 'flat';
set(gca, 'XTickLabel',{'L2/3','L4','L5'})
b.CData(1,:) = [0.8500, 0.3250, 0.0980];
b.CData(2,:) = [0, 0.4470, 0.7410];
b.CData(3,:) = [0.9290, 0.6940, 0.1250];
% b(1).FaceColor = [0.8500, 0.3250, 0.0980];  % Color for Variable 1
% b(2).FaceColor = [0, 0.4470, 0.7410];  % Color for Variable 2
% b(3).FaceColor = [0.9290, 0.6940, 0.1250];  % Color for Variable 3% Plots grouped bar chart
ylabel('volume(\mu m^3)');
title(['volume of dendrite spine head'])
numGroups = size(data, 1);
numBars = size(data, 2);
% Add error bars
hold on;
for i = 1:numBars
    % X positions for error bars
    x = b.XEndPoints(i);
    % Add error bars to each group
    errorbar(x, data(:, i), err(:, i), '.k', 'LineWidth', 1.5);
end


bar_plot_mean = cell(3,1);
bar_plot_mean{1} = data(:,1);
bar_plot_mean{2} = data(:,2);
bar_plot_mean{3} = data(:,3);
bar_plot_test = cell(3,2);
bar_plot_test{1,1} = singleSynHeadVolume2;
bar_plot_test{2,1} = singleSynHeadVolume4;
bar_plot_test{3,1} = singleSynHeadVolume5;
hold on;
[position_cell, pvalueArray] = plot_significance_score_cell_cell(bar_plot_mean, bar_plot_test, b);
sigstar(position_cell,pvalueArray)
saveas(gcf, fullfile(plot_save_folder, 'dendrite_spine_head_volume.png'));
close(gcf);



end