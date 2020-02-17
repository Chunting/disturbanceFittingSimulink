modelName = 'mainNewTraj';
%%
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.3]);
error1 = Err.signals.values;
%%
method = 'zpetc';
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','off');
set_param([modelName,'/GStable'],'sys','GStable');
sim(modelName,[0 0.3]);
error2 = Err.signals.values;
%%
% method = 'zpetc';
% set_param([modelName,'/ilcSignal'],'commented','on');
% set_param([modelName,'/GStable'],'commented','off');
% set_param([modelName,'/GStable'],'sys','GStableNew');
% sim(modelName,[0 0.3]);
% error3 = Err.signals.values;
%%
figure;
h0 = plot(Err.time,[error1,error2]*1e9,'lineWidth',2);
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs([error1,error2]*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
% h = legend('$e$','$\hat{e}$','scaled acc');
h = legend('����������acc��jerk��snapǰ��','��һ�����ö��ⲹ����ĸ������','scaled acc');
h.Interpreter = 'latex';
set(gca,'fontsize',14);
%%
figure;
h0 = plot(Err.time,error2*1e9,'lineWidth',2);
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs(error2*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
h = legend('��һ�����ö��ⲹ����������','scaled acc');
h.Interpreter = 'latex';
set(gca,'fontsize',14);