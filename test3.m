close all;
load carsmall;
X = [Weight,Horsepower,Acceleration];
x=X(:,3);
y=X(:,1);
out=fitlm(x,y,'RobustOpts','on');
disp(out)
% xlabel('Horsepower','Acceleration')
%% without envelope
close all;
load carsmall;
X = [Weight,Horsepower,Acceleration];
x=X(:,2:3);
y=X(:,1);
outLM=fitlm(x,y,'exclude','');
res=outLM.Residuals{:,3};
qqplot(res)
%% %% MR: (Multiple regression data): qqplot with envelopes
close all;
load carsmall;
X = [Weight,Horsepower,Acceleration];
% mdl = fitlm(X,MPG);
x=X(:,2:3);
y=X(:,1);
outLM=fitlm(x,y,'exclude','');
res=outLM.Residuals{:,3};
% res=mdl.Residuals{:,3};
% qqplot(res)
qqplotFS(res,'X',X(:,1),'plots',1);
title('qqplot of res')
