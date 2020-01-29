% plot single-feature glm training results
% 
% 
% 

clear all;clc;close all;
path = '/Volumes/YURU_SONG/Drosophila_behavior_data/GLM_data/';
group_path = {
    'WT_Light_Dark',... 
	'WT_Or47b_Light', ...
	 'WT_Or47b_Dark'
    };
name_group = {
    'WT Light Dark',... 
	'WT Or47b Light', ...
	 'WT Or47b Dark'
    };
group_sub_type = {
    'WT Light','WT Dark',...
    'WT Light','Or47b Light',...
    'WT Dark','Or47b Dark'
    };
name_behav = {'chase','search'};
name_non_behav = {'non_chase','non_search'};
title_str = { % for zscored
    'relative distance',...% yes    social features
    'anglefrom1to2 nose2ell',...
    'view occluded',...% yes 
    'danglesub',...
    'relative speed',...% yes 
    'dnose2tail',...
    'absolute speed',...% yes    male locomotion features
    'male du ctr',...
    'male dv ctr',...
    'male dtheta',...
    'max wing angle',...%  yes   male wing features
    'male max wing area',...% yes 
    'male wing angle diff',...
    'male dmax wing angle',...
    'female velmag',...%     male locomotion features
    'female du ctr',...
    'female dv ctr',...
    'female dtheta'
    };
%% deviance in training set
% 200 samples per training, the null model deviance D_0 = 200*(-2)*log(0.5) = 277.2589
% group, type, behav
num_group = 3;
num_type = 2; 
num_behav = 2; 
num_trial = 50;
num_feat = 18;
load(['GLM_training_deviance.mat'],'total_dev');
% total_dev = zeros(num_group, num_type, num_behav, num_feat, num_trial);
for group = 1: num_group
    for type = 1: num_type
        for behav = 1: num_behav
            figure((group-1)*num_type*num_behav + (type-1)*num_behav + behav);
            set(gcf,'Units','Normalized','OuterPosition',[0.,0.,.7,.4]);
            dev = squeeze(total_dev(group, type, behav, :, :));
            [~,ind] = sort(mean(dev, 2),'descend');
            bar(1:num_feat, mean(dev(ind, :),2));
            hold on;
            errorbar(1: num_feat,mean(dev(ind, :),2),std(dev(ind,:)')/sqrt(50),'.');
            xticks(1:num_feat);
            xticklabels(title_str(ind));
            xtickangle(25);
            ylabel('deviance explained');%ylim([0,1]);
            set(gca,'FontSize',15);
            title([group_sub_type{(group-1)*num_type + type}, ', ',name_behav{behav}]);
%             disp([group_path{group},' ',group_sub_type{(group-1)*2 + type},' ',name_behav{behav}]);
%             for trial = 1: num_trial
%                 
%                 load([path, 'GLM_',num2str(trial),'_',group_path{group},'_',group_sub_type{(group-1)*2 + type},'_',name_behav{behav},'.mat']);
%                 total_dev(group, type, behav, :,trial) = cell2mat(dev);
%             end
            saveas((group-1)*num_type*num_behav + (type-1)*num_behav + behav,['GLM_deviance_',num2str((group-1)*num_type*num_behav + (type-1)*num_behav + behav)],'jpg');
        end
    end
end


%% visualize filters