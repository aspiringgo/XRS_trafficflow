clc
clear;
close all

% data input
RampA = [50;0;50;250;0;250;500;0;500;600;0;600;700;0;700;];
RampB = [0;80;80;0;400;400;0;800;800;0;900;900;0;1000;1000];
RampA1 = [50;250;500;600;700;];
RampB1 = [80;400;800;900;1000];
% C = [];
% logRampA = log(RampA);
% logRampB = log(RampB);

% [A,B,AB]
Delay = [0.294;0.300;0.307;0.332;0.594;0.613;0.356;3.817;3.325;0.368;11.972;9.778;0.374;15.198;12.023];
Delay1 = [0.307;0.613;3.325;9.778;12.023];
vehpass = [2884;2917;2954;3083;3238;3474;3317;3698;4169;3417;3712;4282;3506;3716;4375];
vehspeed = [52.08977772;52.07718847;52.07719;52.05015266;51.71368402;51.68001357;52.05212733;47.91350294;48.45752412;52.06419154;40.35841981;42.19034931;52.04647488;37.99086834;40.38846347];
DelayLatent = [102.9;102.9;102.9;103;190;190;105.7;478.6333333;478.9333333;109.9;10058;10078.4;112.4;167379.1;167389.8];
% Initiatives
x0 = 0;
x1 = 0;
x2 = 0;
% x3 = 0;
y1 = 0;
y2 = 0;
% y3 = 0;
z12 = 0;
% z13 = 0;
% z23 = 0;

% XRS function
E = x0 + x1.*RampA + x2.*RampB + y1.*RampA.^2 + y2.*RampB.^2 + z12.*RampA.*RampB;
% f = fit([RampA RampB],Delay,"poly23");

% training
trainFcn = 'trainbr';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 5;
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,RampA,Delay);

% Test
y = net(RampA);
e = gsubtract(Delay,y);
performance = perform(net,Delay,y,e);

% surface
% plot(f,[RampA,RampB],Delay);
% title('Results for polynomial fitting 23');
% xlabel('Ramp A');
% ylabel('Ramp B');
