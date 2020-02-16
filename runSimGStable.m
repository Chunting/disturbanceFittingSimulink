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
method = 'zpetc';
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','off');
set_param([modelName,'/GStable'],'sys','GStableNew');
sim(modelName,[0 0.3]);
error3 = Err.signals.values;
%%
figure;
h0 = plot(Err.time,[error1,error2,error3]*1e6,'lineWidth',2);
xlabel('time (s)');
ylabel('error (\mum)');

accData = acc.signals.values;
ratio = max(max(abs([error1,error2,error3]*1e6))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
h = legend('$e$','$e_{u_{fb}}$','$\hat{e}$','scaled acc');
h.Interpreter = 'latex';
set(gca,'fontsize',14);