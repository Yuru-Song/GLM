clear all;clc;close all;

title_str = {
    'Relative distance',...% yes    social features
    'anglefrom1to2 nose2ell',...
    'View occluded',...% yes 
    'danglesub',...
    'Relative speed',...% yes 
    'dnose2tail',...
    'Absolute speed',...% yes    male locomotion features
    'male du ctr',...
    'male dv ctr',...
    'male dtheta',...
    'Max wing angle',...%  yes   male wing features
    'Male max wing area',...% yes 
    'male wing angle diff',...
    'male dmax wing angle',...
    'Female velmag',...%     male locomotion features
    'female du ctr',...
    'female dv ctr',...
    'female dtheta'
    };

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
name_behav = {'chase','search'};
num_feat = 18;
group_type_for_lgd = {
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT_Dark','Or47b_Dark'
    };
normalizer = [.5,1,1,1,.5,.5,.5,.5,.5,1,1,.25,1,1,.5,.5,.5,1];
for behav = 1: 2
    for group = 1:3
       	load([group_path{group},'_BTA_',name_behav{behav},'.mat']);
        figure(behav*3 -3 + group);
        set(gcf,'Units','Normalized','InnerPosition',[-.1,0,1,.2]);
        count = 1;
        for i = [1,5,3,7,11,12,15]
            h = subplot(1,7,count);
            % plot group 1
            options.handle = h;
            options.alpha      = 0.5;
                    options.line_width = 2;
                    options.error      = 'sem';
            options.color_area = [128 193 219]./255;% Blue theme
            options.color_line = [ 52 148 186]./255;
            plot_areaerrorbar(BTA1{i}*normalizer(i),options);
            hold on;
            % plot group 2
            options.color_area = [243 169 114]./255;    % Orange theme
            options.color_line = [236 112  22]./255;
            plot_areaerrorbar(BTA2{i}*normalizer(i),options);
            xticklabels(cellstr(num2str(xticks'/30-5,'%.2f')));
            xlabel('time / s');
%             ylabel('bout count');
            
%             if i == 1
%                 lgd1 = group_type_for_lgd{group*2-1};
%                 lgd1(lgd1 == '_') = ' ';
%                 lgd2 = group_type_for_lgd{group*2};
%                 lgd2(lgd2 == '_') = ' ';
%                 legend(['SEM, ',lgd1], ['AVE, ',lgd1],['SEM, ',lgd2], ['AVE, ',lgd2],'Units','Normalized','Position',[0.1 0. 0.1 0.2]);
%                 title([name_behav{behav},', ',title_str{i}],'FontSize',15);
%             end
            set(gca,'FontSize',12);%ylim([0,300]);
            title([title_str{i}],'FontSize',15);
            saveas(behav*3 -3 + group,[group_path{group},'_',name_behav{behav}],'jpg');
            count = count +1;
        end
    end
end

