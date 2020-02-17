%% ģ�Ͳ���
modelTypeName = {'rigidBody','doubleMassNonColocated','doubleMassColocated'};
modelInfo.mass = [5,20]; % �����ֲ�
modelInfo.fr = 700; % ����Ƶ��
modelInfo.dampRatio = 0.03; % �ṹ�����
modelInfo.type = modelTypeName{2}; % ѡ��non-collocated��ʽ��˫������ģ��
fs = 5000; % ����Ƶ��
Ts = 1/fs;
Gp = createPlantModel(modelInfo); % ����ģ��

%% ��ʱ����
delayCount = 2.5; % ����2.5���ŷ����ڵ���ʱ����
s = tf('s');
delayModel = exp(-delayCount*Ts*s);
delayModel = pade(delayModel,2); % ���ö������±ƽ�������ʱ����

%% generate plant model with delay�� ���ɺ���ʱ��ģ��
GpWithDelay = Gp * delayModel;
GpDis = c2d(GpWithDelay,Ts,'zoh');
figure;pzmap(GpDis); % �����㼫��ֲ�ͼ

%% ���뷴��������
load GcDis176Hz.mat;

% %% ideal feedforward coefficients 
% tau = (delayCount + 0.5) * Ts;
% wn = modelInfo.fr * 2 * pi;
% m = modelInfo.mass;
% accCoef = sum(m);
% jerkCoef = 2/3 * sum(m) * tau;
% snapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2)-3.6250e-06;
% % idealAccCoef = sum(m);
% % idealJerkCoef = sum(m) * tau;
% % idealSnapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2);
% %%
% sigma = 2;%�����ı�׼���λm
% varNoise=sigma*sigma;%ע�⣬��������ģ���е�Noise Power ��Ҫ���varNoise*Ts
% noisePower=varNoise*Ts;
% %%
% A1 = 8;
% A2 = 5;
% A3 = 3;