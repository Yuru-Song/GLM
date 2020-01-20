function [BTA1, BTA2] = bout_triggered_average(behav, group, threshold, length)
% INPUT:
%   behav:  1:'chase'	2:'search'
%   group: 1:'WT_Light_Dark/',  2: 'WT_Or47b_Light/', 3: 'WT_Or47b_Dark/'
%   threshold: optional, 1 s for 'chase', 3 s for 'search'
%   length: optional, 5 s for 'chase', 5 s for 'search', 5*30 units
% OUTPUT:
%   BTA: [2, num_features, time_len, 2], 
%           first dimension is two groups of fly
%           last dimension is mean and sem
%       * features: 18 in total before normalization, NaN values replaced by
%       interception
%           # social features
%           data['male_dcenter'],
% 			data['male_anglefrom1to2_nose2ell'],
% 			data['male_anglesub'],
% 			data['male_danglesub'],
% 			data['male_ddcenter'],
% 			data['male_dnose2tail'],
% 			# male locomotion features
% 			data['male_velmag'],
% 			data['male_du_ctr'],
% 			data['male_dv_ctr'],
% 			data['male_dtheta'],
% 			# male wing features
% 			data['male_max_wing_angle'],
% 			data['male_max_wing_area'],
% 			data['male_wing_angle_diff'],
% 			data['male_dmax_wing_angle'],
% 			# female locomotion features
% 			data['female_velmag'],
% 			data['female_du_ctr'],
% 			data['female_dv_ctr'],
% 			data['female_dtheta'],
% @Yuru Song, Jan-19-2019

% paths 
group_path = {
    'WT_Light_Dark',... 
	'WT_Or47b_Light', ...
	 'WT_Or47b_Dark'
    };
group_path_file = {
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT_Dark','Or47b_Dark'
    };
group_type = {
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT','Or47b'
    };
behav_file = ['/Users/yurusong/Documents/StimHMMdata/',group_path{group},'/',...
    group_path{group},'_Behavior_Prediction.mat']; 
load(behav_file);
behaviors1 = eval([group_type{group*2 -1},'_data']);
behaviors2 = eval([group_type{group*2},'_data']);

% defaults
def_thres = [15, 45];
def_leng = [150, 150];

if nargin == 2
    thres = def_thres(behav);
    length = def_leng(behav);
elseif nargin == 3
    length = def_leng(behav);
end

% params
num_feat = 18;
num_fly = numel(behaviors1);
time_BTA1 = cell(num_fly);
time_BTA2 = cell(num_fly);
BTA1 = cell(1, num_feat);
BTA2 = cell(1, num_feat);

% get the timepoints to compute BTA, then features
for i = 1: num_fly
    behav_seq = (behaviors1{i}(behav,:));
    tmp_length = (diff([behav_seq,0])==-1).*cumsum(behav_seq);
    tmp_length = tmp_length(tmp_length>0);
    tmp_length = diff([0, tmp_length]);
    tmp_BTA_time = find(diff([0, behav_seq]) == 1);
    tmp_BTA_time = tmp_BTA_time(tmp_length > thres);
    
    feat_file = ['/Users/yurusong/Documents/StimHMMdata/',group_path{group},'/',...
    group_path{group},'_',group_path_file{group*2-1},'_video_',num2str(i),'_features.mat'];
    load(feat_file);
    
    for j = 1: numel(tmp_BTA_time)
        time = tmp_BTA_time(j);
        if time < length
            tmp_BTA = features(:, 1: time);
            tmp_BTA = [NaN*ones(num_feat,length - time),tmp_BTA];
        else
            tmp_BTA = features(:, time - length + 1: time);
        end
        for k = 1: num_feat
            BTA1{k} = [BTA1{k};tmp_BTA(k,:)]; 
        end
    end
end
for i = 1: num_fly
    behav_seq = (behaviors2{i}(behav,:));
    tmp_length = (diff([behav_seq,0])==-1).*cumsum(behav_seq);
    tmp_length = tmp_length(tmp_length>0);
    tmp_length = diff([0, tmp_length]);
    tmp_BTA_time = find(diff([0, behav_seq]) == 1);
    tmp_BTA_time = tmp_BTA_time(tmp_length > thres);
    feat_file = ['/Users/yurusong/Documents/StimHMMdata/',group_path{group},'/',...
    group_path{group},'_',group_path_file{group*2},'_video_',num2str(i),'_features.mat'];
    load(feat_file);
    for j = 1: numel(tmp_BTA_time)
        time = tmp_BTA_time(j);
        if time < length
            tmp_BTA = features(:, 1: time);
            tmp_BTA = [NaN*ones(num_feat,length - time),tmp_BTA];
        else
            tmp_BTA = features(:, time - length + 1: time);
        end
        for k = 1: num_feat
            BTA2{k} = [BTA2{k};tmp_BTA(k,:)]; 
        end
    end
end

    
