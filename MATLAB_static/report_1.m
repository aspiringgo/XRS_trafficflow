clc
clear;
close all;
tic
Tb = readtable('NGSIM__Lankershim_Vehicle_Trajectories.csv');  % read the dataset file

% transfer the actual time
Tb{:,'Actual_Time'} = (Tb{:,'Global_Time'} - 12950 * 24 * 3600 * 1000)/1000/60/60-7;
Tb{:,'Actual_Time_Hour'} = fix(Tb{:,'Actual_Time'}); % Hours
Tb{:,'Actual_Time_Minute'} = fix((Tb{:,'Actual_Time'} - Tb{:,'Actual_Time_Hour'}) * 60); % Mins
Tb{:,'Actual_Time_Second'} = (((Tb{:,'Actual_Time'} - Tb{:,'Actual_Time_Hour'}) * 60) - Tb{:,'Actual_Time_Minute'}) * 60; % Seconds

% summary(Tb);                      % summary on the variables in table

% Select Intersection, Movement, Direction, & O_Zone
% Tb1 = Tb(Tb.Int_ID == 4 & Tb.Movement == 2 & Tb.O_Zone == 107,:); % & Tb.Direction == 4
TbTr1 = Tb(Tb.Int_ID == 4 & Tb.Movement == 1 & Tb.O_Zone == 108,:); % & Tb.Direction == 4

% Select time cycle
% Tb2 = Tb1(Tb1.Actual_Time_Hour + Tb1.Actual_Time_Minute / 60 + Tb1.Actual_Time_Second / 3600 >= 8 + 47 / 60 + 07 / 3600,:);
% Tb3 = Tb2(Tb2.Actual_Time_Hour + Tb2.Actual_Time_Minute / 60 + Tb2.Actual_Time_Second / 3600 <= 8 + 48 / 60 + 47 / 3600,:);

TbTr2 = TbTr1(TbTr1.Actual_Time_Hour + TbTr1.Actual_Time_Minute / 60 + TbTr1.Actual_Time_Second / 3600 >= 8 + 28 / 60 + 47 / 3600,:);
TbTr3 = TbTr2(TbTr2.Actual_Time_Hour + TbTr2.Actual_Time_Minute / 60 + TbTr2.Actual_Time_Second / 3600 <= 8 + 30 / 60 + 27 / 3600,:);


% V_ID = unique(Tb3.Vehicle_ID);
% V_value = numel(V_ID);
% Travel through
V_TrID = unique(TbTr3.Vehicle_ID);
V_Trvalue = numel(V_TrID);
toc
% Signal1_Lt = [16;12;21;18;12;0;13;24;13;12;23;21;31;26;31;31;31;31];
% Signal1_Tr = [76;80;71;74;80;100;79;68;79;80;69;71;62;65;62;61;61;61];
% Signal2_Lt = [10;22;6;11;8;6;0;9;7;11;7;11;11;7;9;9;14;9];
% Signal2_Tr = [62;51;69;32;39;49;51;51;48;42;62;49;55;39;45;53;51;39];
% Signal3_Lt = [7;5;7;0;10;0;0;29;12;5;8;0;5;0;15;6;5;7];
% Signal3_Tr = [85;85;84;100;69;64;100;62;67;75;69;100;86;100;65;84;86;73];
% Signal4_Lt = [5;5;5;5;5;9;5;5;5;8;6;5;11;5;5;5;5;5];
% Signal4_Tr = [72;86;55;75;86;69;54;72;54;83;54;75;69;54;55;53;71;70];
