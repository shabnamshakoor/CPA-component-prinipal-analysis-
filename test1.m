% Import the data
close all;
clear all;
load carsmall;
X = [Weight,Horsepower,Acceleration];
x=X(:,2);
y=X(:,1);

plot (x, y,'o') ;
xlabel('Horsepower', 'FontSize',16);
ylabel('weight','Fontsize',16);
%% %% Traditional fit

 lsline
 %% 
 [outLTS]=LXS(y,x);
 b = outLTS.beta;
hold('on')
plot(x,b(1)+b(2)*x, 'r','LineWidth' ,1);
legend({'Points' 'Least squares fit' 'Robust fit'});
% Automatic outlier detection
% out=FSR(y,X);

%% %% MR: (Multiple regression data): yXplot

close all;
load carsmall;
X = [Weight,Horsepower,Acceleration];
y=X(:,1);
yXplot(y,X(:,2:3));
