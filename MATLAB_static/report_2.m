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

% inatiation
Signal1_Lt = [16;12;21;18;12;0;13;24;13;12;23;21;31;26;31;31;31;31];
Signal1_Tr = [76;80;71;74;80;100;79;68;79;80;69;71;62;65;62;61;61;61];
Signal2_Lt = [10;22;6;11;8;6;0;9;7;11;7;11;11;7;9;9;14;9];
Signal2_Tr = [62;51;69;32;39;49;51;51;48;42;62;49;55;39;45;53;51;39];
Signal3_Lt = [7;5;7;0;10;0;0;29;12;5;8;0;5;0;15;6;5;7];
Signal3_Tr = [85;85;84;100;69;64;100;62;67;75;69;100;86;100;65;84;86;73];
Signal4_Lt = [5;5;5;5;5;9;5;5;5;8;6;5;11;5;5;5;5;5];
Signal4_Tr = [72;86;55;75;86;69;54;72;54;83;54;75;69;54;55;53;71;70];

% time cycles
Int1Ts = [28 10; 29 50; 31 30; 33 10; 34 50; 36 30; 38 10; 39 50; 41 30; 43 10; 44 50; 46 30; 48 10; 49 50; 51 30; 53 10; 54 50; 56 30];
Int1Te = [29 50; 31 30; 33 10; 34 50; 36 30; 38 10; 39 50; 41 30; 43 10; 44 50; 46 30; 48 10; 49 50; 51 30; 53 10; 54 50; 56 30; 58 10];
Int2Ts = [28 45; 30 25; 32 05; 33 45; 35 25; 37 05; 38 45; 40 25; 42 05; 43 45; 45 25; 47 05; 48 45; 50 25; 52 05; 53 45; 55 25; 57 05];
Int2Te = [30 25; 32 05; 33 45; 35 25; 37 05; 38 45; 40 25; 42 05; 43 45; 45 25; 47 05; 48 45; 50 25; 52 05; 53 45; 55 25; 57 05; 58 45];
Int3Ts = [28 35; 30 15; 31 55; 33 35; 35 15; 36 55; 38 35; 40 15; 41 55; 43 35; 45 15; 46 55; 48 35; 50 15; 51 55; 53 35; 55 15; 56 55];
Int3Te = [30 15; 31 55; 33 35; 35 15; 36 55; 38 35; 40 15; 41 55; 43 35; 45 15; 46 55; 48 35; 50 15; 51 55; 53 35; 55 15; 56 55; 58 35];
Int4Ts = [28 47; 30 27; 32 07; 33 47; 35 27; 37 07; 38 47; 40 27; 42 07; 43 47; 45 27; 47 07; 48 47; 50 27; 52 07; 53 47; 55 27; 57 07];
Int4Te = [30 27; 32 07; 33 47; 35 27; 37 07; 38 47; 40 27; 42 07; 43 47; 45 27; 47 07; 48 47; 50 27; 52 07; 53 47; 55 27; 57 07; 58 47];
% O_Zone combinations
% Comb = [102; 103; 105; 107];

% Select Intersection, Movement, Direction, & O_Zone
TbLt1 = Tb(Tb.Int_ID == 4 & Tb.Movement == 2 ,:); %& Tb.O_Zone == 107 | 109 & Tb.Direction == 4   % Left turn vehicles
TbTr1 = Tb(Tb.Int_ID == 4 & Tb.Movement == 1 ,:); %& Tb.O_Zone == 108 | 101 & Tb.Direction == 4   % Travel through vehivles
for j = 1:18
    TbLt2 = TbLt1(TbLt1.Actual_Time_Hour + TbLt1.Actual_Time_Minute / 60 + TbLt1.Actual_Time_Second / 3600 >= 8 + Int4Ts(j,1) / 60 + Int4Ts(j,2) / 3600,:); % start time of left turn vehicles
    TbLt3 = TbLt2(TbLt2.Actual_Time_Hour + TbLt2.Actual_Time_Minute / 60 + TbLt2.Actual_Time_Second / 3600 <= 8 + Int4Te(j,1) / 60 + Int4Te(j,2) / 3600,:); % end time of left turn vehicles
    
    TbTr2 = TbTr1(TbTr1.Actual_Time_Hour + TbTr1.Actual_Time_Minute / 60 + TbTr1.Actual_Time_Second / 3600 >= 8 + Int4Ts(j,1) / 60 + Int4Ts(j,2) / 3600,:); % start time of travel through vehicles
    TbTr3 = TbTr2(TbTr2.Actual_Time_Hour + TbTr2.Actual_Time_Minute / 60 + TbTr2.Actual_Time_Second / 3600 <= 8 + Int4Te(j,1) / 60 + Int4Te(j,2) / 3600,:); % end time of travel through vehicles
    
    V_LtID = unique(TbLt3.Vehicle_ID); % all LT unique vehicle ID
    V_LtVol(j,:) = numel(V_LtID); % volume of LT unique vehicles
    V_LtAS(j,:) = sum(TbLt3.v_Vel) / numel(TbLt3.v_Vel); % average speed of all LT vehicles in each time cycle
    
    V_TrID = unique(TbTr3.Vehicle_ID); % all TR unique vehicle ID
    V_TrVol(j,:) = numel(V_TrID); % volume of TR unique vehicles
    V_TrAS(j,:) = sum(TbTr3.v_Vel) / numel(TbTr3.v_Vel); % average speed of all TR vehicles in each time cycle     % feet per sec
end

figure
sz = 50;
c = linspace(1,10,length(V_TrAS));
subplot(1,2,1);scatter3(Signal4_Tr,V_TrVol,V_TrAS,sz,c,'filled');xlabel('Signal');ylabel('Volume');zlabel('Average Speed');% colorbar
subplot(1,2,2);stem3(Signal4_Tr,V_TrVol,V_TrAS,'filled');xlabel('Signal');ylabel('Volume');zlabel('Average Speed');
figure
subplot(1,2,1);scatter3(Signal4_Lt,V_LtVol,V_LtAS,sz,c,'filled');xlabel('Signal');ylabel('Volume');zlabel('Average Speed');% colorbar
subplot(1,2,2);stem3(Signal4_Lt,V_LtVol,V_LtAS,'filled');xlabel('Signal');ylabel('Volume');zlabel('Average Speed');
% figure
% plot()
%     V_LtVolM(:,i) = V_LtVol;
%     V_TrVolM(:,i) = V_TrVol;
%     V_LtASM(:,i) = V_LtAS;
%     V_TrASM(:,i) = V_TrAS;


% V_ID = unique(Tb3.Vehicle_ID);
% V_value = numel(V_ID);
% Travel through
% V_TrID = unique(TbTr3.Vehicle_ID);
% V_Trvalue = numel(V_TrID);
toc