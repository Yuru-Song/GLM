--------------
Jan 28 2020
--------------
Training deviance of single-feature GLM: Run MATLAB program `glm_single_feat_train.m` and `plot_glm_single_feat.m`.
It's weird that the deviance explained is high for 'WT Light Search', 'WT Dark Chase' etc. Maybe there are too many '0' events in the training datasets for those groups.

![](GLM_deviance_1.jpg) ![](GLM_deviance_2.jpg)
![](GLM_deviance_3.jpg) ![](GLM_deviance_4.jpg)
![](GLM_deviance_5.jpg) ![](GLM_deviance_6.jpg)
![](GLM_deviance_7.jpg) ![](GLM_deviance_8.jpg)
![](GLM_deviance_9.jpg) ![](GLM_deviance_10.jpg)
![](GLM_deviance_11.jpg) ![](GLM_deviance_12.jpg)

--------------
Jan 19 2020
--------------
Bout triggered average. Check all the features prior to the initiation of 'chase' and 'search' behaviors. Run MATLAB program `plot_BTA.m`, dependent on `bout_triggered_average.m` and `plot_areaerrorbar.m`.

Maybe the filters from GLM are similar to the BTAs here? 

'chase', WT Light (blue) v.s. WT Dark (orange)

![](WT_Light_Dark_chase.jpg)
![](WT_Light_Dark_chase_zscored.jpg)
non-'chase', WT Light (blue) v.s. WT Dark (orange)

![](WT_Light_Dark_non_chase.jpg)
![](WT_Light_Dark_non_chase_zscored.jpg)
'search', WT Light (blue) v.s. WT Dark (orange)

![](WT_Light_Dark_search.jpg)
![](WT_Light_Dark_search_zscored.jpg)
non-'search', WT Light (blue) v.s. WT Dark (orange)

![](WT_Light_Dark_non_search.jpg)
![](WT_Light_Dark_non_search_zscored.jpg)
'chase', WT Dark (blue) v.s. Or47b Dark (orange)

![](WT_Or47b_Dark_chase.jpg)
![](WT_Or47b_Dark_chase_zscored.jpg)
non-'chase', WT Dark (blue) v.s. Or47b Dark (orange)

![](WT_Or47b_Dark_non_chase.jpg)
![](WT_Or47b_Dark_non_chase_zscored.jpg)
'search', WT Dark (blue) v.s. Or47b Dark (orange)

![](WT_Or47b_Dark_search.jpg)
![](WT_Or47b_Dark_search_zscored.jpg)
non-'search', WT Dark (blue) v.s. Or47b Dark (orange)

![](WT_Or47b_Dark_non_search.jpg)
![](WT_Or47b_Dark_non_search_zscored.jpg)
'chase', WT Light (blue) v.s. Or47b Light (orange)

![](WT_Or47b_Light_chase.jpg)
![](WT_Or47b_Light_chase_zscored.jpg)
non-'chase', WT Light (blue) v.s. Or47b Light (orange)

![](WT_Or47b_Light_non_chase.jpg)
![](WT_Or47b_Light_non_chase_zscored.jpg)
'search', WT Light (blue) v.s. Or47b Light (orange)

![](WT_Or47b_Light_search.jpg)
![](WT_Or47b_Light_search_zscored.jpg)
non-'search', WT Light (blue) v.s. Or47b Light (orange)

![](WT_Or47b_Light_non_search.jpg)
![](WT_Or47b_Light_non_search_zscored.jpg)
--------------
Jan 13 2020
--------------
Trying GLM on binary output, i.e. search or not, chase or not. 

About behavior bout, how to select them? First, look at the time length distribution of these two behaviors. Run MATLAB program `plot_behav_length_stat.m`, dependent on `behav_length_stat.m` and `plot_areaerrorbar.m`.

Shown in the following figure, the second group (WT/Or47b Light) data seems weird. The behaviors are like bread crumbs instead of bread slices. What was going on in these flies' head?

![](behav_length_stat.jpg)

Back to the bout selection, if the 'chase' lasts longer than 0.5s (I determine it arbitrarily, based on the distribution), then count it as a 'chase' bout. Next step: bout triggered average for the 'chase' bouts.

--------------
Jan 07 2020
--------------

1. Behavior selection, do we need all the chase/search behavior?

2. Feature selection, primarily focus 'mfDist', add more features if necessary, for example if the 'mfDist' is noisy being an olfactory proxy, consider further description of female movement as the odor source 

3. GLM first, simple things first.

4. Use lab machine, not mine. Establish the remote access.


--------------
Jan 06 2020
--------------
After many lessons from previous experience, I decided to take detailed record of coding/analysis during a project. Let's see if this will make a difference!
