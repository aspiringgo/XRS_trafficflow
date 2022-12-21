clc
clear;

% T = readtable('NGSIM__Lankershim_Vehicle_Trajectories.csv');
% M = readmatrix('NGSIM__Lankershim_Vehicle_Trajectories.csv');
% opts.Range = '1:11'
% Demo = readtable('Demo.xlsx',opts);
% Demo(Demo.Global_Time > 1.118935690000000e+12 & Global_Time < 1.118935790000000e+12,:);

% opts.SelectedVariableNames = [1:5]; 
% opts.DataRange = '1:11';
Tb = readtable('MatlabDemo.xlsx');  % read the dataset file

% transfer the actual time
Tb{:,'Actual_Time'} = (Tb{:,'Global_Time'} - 12950 * 24 * 3600 * 1000)/1000/60/60-7;
Tb{:,'Actual_Time_Hour'} = fix(Tb{:,'Actual_Time'}); % Hours
Tb{:,'Actual_Time_Minute'} = fix((Tb{:,'Actual_Time'} - Tb{:,'Actual_Time_Hour'}) * 60); % Mins
Tb{:,'Actual_Time_Second'} = (((Tb{:,'Actual_Time'} - Tb{:,'Actual_Time_Hour'}) * 60) - Tb{:,'Actual_Time_Minute'}) * 60; % Seconds

% a=datestr(8.4712/24,'HH:mm:ss');
% Tb.Actual_Time = datestr(Tb.Actual_Time,'Format','HH:mm:ss');
% summary(Tb);                      % summary on the variables in table
% GlobalTime = Tb(:, 2);
% Tb1 = Tb(Tb.Vehicle_ID == 75,:);  % mind both row and column search

% Select time cycle
Tb1 = Tb(Tb.Actual_Time_Hour + Tb.Actual_Time_Minute / 60 + Tb.Actual_Time_Second / 3600 >= 8 + 29 / 60 + 50 / 3600 & Tb.Actual_Time_Hour + Tb.Actual_Time_Minute / 60 + Tb.Actual_Time_Second / 3600 <= 8 + 31 / 60 + 30 / 3600,:);

V_ID = unique(Tb1.Vehicle_ID);
V_value = numel(V_ID);
