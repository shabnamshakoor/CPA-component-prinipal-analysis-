/*The code has been used FSDA toolbox in MATLAB so this toolbox should be installed*/

Xtable=readtable('STORES.xlsx','ReadRowNames',true);
X=table2array(Xtable);
nameXvars=Xtable.Properties.VariableNames;

[n,p]=size(X);

Z=zscore(X);
R=cov(Z);
Rtable=array2table(R,'RowNames',nameXvars,'VariableNames',nameXvars);
format bank
disp(Rtable)
format short

[V,La]=eig(R);
la=diag(La);
[aa,indsor]=sort(la,'descend');

V=V(:,indsor);
lasor=la(indsor);
La=diag(lasor);
Y=Z*V;

namePCs=cellstr([repmat('PC',p,1) num2str((1:p)')]);
autoval=[lasor 100*(lasor)/p 100*cumsum(lasor)/p];
namecols={'Sorted_eignvalues' '100*eigenvalues/p' 'cumulative sum as a percentage'};
autovaltable=array2table(autoval,'RowNames', ...
    namePCs,'VariableNames',namecols);
disp(autovaltable)

figure
pareto(autoval(:,1),namePCs)
xlabel('principal Components')
ylabel('Percentage of explained variance (%)')

MatrComp=V*sqrt(La);

MatrComp=MatrComp(:,1:2);

MatrCompt=array2table(MatrComp,"RowNames",nameXvars,"VariableNames",namePCs(1:2));
disp('Correlazioni tra le variabili originarie e le CP')
disp(MatrCompt)

j=1;
disp(['La somma dei quadrati della colonna ' num2str(j) ' della matrice di componenti'])
sum(MatrComp(:,j).^2)
disp(['è uguale all'' autovalore ' num2str(j) '=' num2str(lasor(j))])

xlabels=categorical(nameXvars,nameXvars);

figure
for j=1:2
    subplot(2,1,j)
    b=bar(xlabels, MatrComp(:,j),'g');
    title(['Correlation with PC' num2str(j)])
    % xtips e ytips sono le coordinate numeriche dove inserire le etichette
    % del valore numerico sopra ogni barra
    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    barlabels = string(round(MatrComp(:,j),2));
    text(xtips,ytips,barlabels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
end

disp(['Comunalità: quote di varianza di ogni ' ...
    'variabile spiegate dalle prime due CP'])
Comu=sum(MatrComp.^2,2);

Comutable=array2table(Comu,'RowNames',nameXvars,...
    'VariableNames',{'Comunalità'});
disp(Comutable)

close all
zeroes = zeros(p,1);

quiver(zeroes,zeroes,MatrComp(:,1),MatrComp(:,2))
text(MatrComp(:,1),MatrComp(:,2),nameXvars,...
    'VerticalAlignment','bottom','HorizontalAlignment','center');
xline(0)
yline(0)
xlabel('First PC: indicate stores are not in a good finance condition');
ylabel('Seconda PC: indicate stores are in a good finance conditions');
axis equal

close all
plot(Y(:,1),Y(:,2),'o')
xlabel('First PC: indicate stores are not in a good finance condition');
ylabel('Seconda PC: indicate stores are in a good finance conditions');
text(Y(:,1),Y(:,2),Xtable.Properties.RowNames)
xline(0)
yline(0)

Yst=Y*sqrt(inv(La));
plot(Yst(:,1),Yst(:,2),'o')
xlabel('First PC: indicate stores are not in a good finance condition');
ylabel('Seconda PC: indicate stores are in a good finance conditions');
text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
xline(0)
yline(0)


close all
hold('on')

plot(Yst(:,1),Yst(:,2),'o')
xlabel('First PC: indicate stores are not in a good finance condition');
ylabel('Seconda PC: indicate stores are in a good finance conditions');
text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
axislim=axis;

line([axislim(1);axislim(2)], [0;0], 'Color','black');
line([0;0],[axislim(3);axislim(4)], 'Color','black');

zeroes = zeros(p,1);
quiver(zeroes,zeroes,MatrComp(:,1),MatrComp(:,2))

dx=0.01;
dy=0.01;
text(MatrComp(:,1)+dx,MatrComp(:,2)+dy,nameXvars,'Color','Blue');
axis tight
