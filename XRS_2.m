clc
clear
close

% data input
RampA = [500;0;500;600;0;600;700;0;700];
RampB = [0;800;800;0;900;900;0;1000;1000];
predictor = [500 0;0 800;500 800;600 0;0 900;600 900;700 0;0 1000;700 1000];

% Targets [A,B,AB]
Delay= [0.356;3.817;3.325;0.368;11.972;9.778;0.374;15.198;12.023];

% XRS function
% E = x0 + x1.*RampA + x2.*RampB + y1.*RampA.^2 + y2.*RampB.^2 + z12.*RampA.*RampB;

% Create a Fitting Network
hiddenLayerSize = 10;
trainFcn = 'trainbr';
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 75/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,RampA,Delay);

% Test
y = net(predictor);
e = gsubtract(Delay,y);
performance = perform(net,Delay,y,e);
