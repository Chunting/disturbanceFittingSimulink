close all;
modelName = 'mainNewTraj';
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
accCoef = 0;
jerkCoef = 0;
snapCoef = 0;
%% ��һ��acc,jerk,snapǰ������
sim(modelName,[0 0.18]);
RunSimZPETC;% ���ɵ���ѧϰ�ź�
close all;

accData = acc.signals.values;
jerkData = jerk.signals.values;
snapData = snap.signals.values;
% ��ϵ���ѧϰ�źŵõ�acc, jerk, snapǰ��ϵ��
A = [accData,jerkData,snapData];
b = ilcData;
x = A\b;
accCoef = x(1);
jerkCoef = x(2);
snapCoef = x(3);
%% �ڶ���acc,jerk,snapǰ������
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.18]);
RunSimZPETC; % ���ɵ���ѧϰ�źţ�
close all;
accData = acc.signals.values;
jerkData = jerk.signals.values;
snapData = snap.signals.values;
% ��ϵ���ѧϰ�źţ�
A = [accData,jerkData,snapData];
b = ilcData;
x = A\b;
accCoef = x(1) + accCoef;
jerkCoef = x(2) + jerkCoef;
snapCoef = x(3) + snapCoef;
%% ���������õ�acc,jerk,snapǰ��Ч��
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.18]);
%% �����������õ�acc,jerk,snapǰ�������£��������Ч��
figure;
h0 = plot(Err.time,Err.signals.values*1e9,'lineWidth',2);
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs(error2*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
h = legend('$e$','scaled acc');
h.Interpreter = 'latex';
set(gca,'fontsize',14);