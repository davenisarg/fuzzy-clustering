clear all
close all
path(path,'..\..\..\FUZZCLUST')
%data set
iris = load('iris.mat')
iris1 = iris.iris
data.X =iris.iris(:,[1 2 3 4]);


%parameters
param.c=3;
param.m=1.7;
param.e=1e-6;
param.ro=[1.5 1.5 1.5];
param.val=3;
%normalization
%data=clust_normalize(data,'range');
%clustering
result = GKclust(data,param);
%plot(data.X(:,1),data.X(:,2),data.X(:,3),data.X(:,4),'.',result.cluster.v(:,1),result.cluster.v(:,2),result.cluster.v(:,3),result.cluster.v(:,1),'.');
%hold on
%draw contour-map
%new.X=data.X;
%eval=clusteval(new,result,param);
%validation
error = sum(result.cost)./numel(result.cost);
weightedcost = num2str(error,'%.0f')

setosa = iris1(find(iris1(:,5)==1), :);
versicolor = iris1(find(iris1(:,5)==2),:);   % data for class 2
virginica = iris1(find(iris1(:,5)==3), :);   % data for class 3
%load carsmall
%gscatter(c1(:,1),c2(:,2),c3(:,3),'','xos')
%scatter3(c1(:,1),c2(:,2),c3(:,3),)
Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
for j = 1:6
        x = pairs(j, 1); 
        y = pairs(j, 2);   
        subplot(2,3,j);
        plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
             [setosa(:,y) versicolor(:,y) virginica(:,y)], '.');
        for k = 1:3
                text(result.cluster.v(k, pairs(j,1)), result.cluster.v(k,pairs(j,2)), int2str(k), 'FontWeight', 'bold');
        end
        xlabel(Characteristics{x},'FontSize',10); 
        ylabel(Characteristics{y},'FontSize',10);
end
%result = validity(result,data,param);
%result.validity