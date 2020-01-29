function [filter,dev, stat] = glm_single_feat_train(group, type, behav)
% INPUT:
%   group: 1~3
%   type: 1~2
%   behav: 1~2
% 
% OUTPUT:
%   filter: (1, num_feat) cell array, each contains specific filter of a
%       feature
%   
% note: don't forget to shuffle the training set
%       don't forget to penalize the parameter
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
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT_Dark','Or47b_Dark'
    };
name_behav = {'chase','search'};
name_non_behav = {'non_chase','non_search'};
load([path, group_path{group},'_',group_sub_type{(group-1)*2 + type},'_',name_behav{behav},'_zscored_feat_GLM_train.mat']);
load([path, group_path{group},'_',group_sub_type{(group-1)*2 + type},'_',name_behav{behav},'_zscored_feat_GLM_test.mat']);

% shuffle training data
num_train = size(train_X{1},1);
num_feat = numel(train_X);
time_length = size(train_X{1},2);
rng('shuffle');

% train GLM
for j = 1:100
filter = cell(1, num_feat);
    dev = cell(1, num_feat);
    stat = cell(1, num_feat);
for i = 1: num_feat
    shuffle_ind = randperm(num_train);
    
%     [filter{i}, dev{i}, stat{i}] = glmfit(train_X{i}(shuffle_ind,end-30:end),[train_Y(shuffle_ind)',ones(numel(train_Y),1)],'binomial');
%     [filter{i}, dev{i}, stat{i}] = glmfit(train_X{i}(:,end-30:end),[train_Y',ones(numel(train_Y),1)],'binomial');
%     [filter2{i}, dev2{i}, stat2{i}] = glmfit(test_X{i}(:,end-30:end),[test_Y',ones(numel(test_Y),1)],'binomial');
    [filter{i},dev{i}, stat{i}] = mnrfit(train_X{i}(shuffle_ind(1:200),end-60:end),train_Y(shuffle_ind(1:200))' + 1);
%     [filter2{i}, dev2{i}] = mnrfit(test_X{i}(:,end-15:end),test_Y' + 1);
end
    save([path, 'GLM_',num2str(j),'_',group_path{group},'_',group_sub_type{(group-1)*2 + type},'_',name_behav{behav},'.mat'], 'filter', 'dev', 'stat');
end
% summarize GLM performance

% plot figure