dataset1 = load('iris.mat')
dataset1 = dataset1.iris
dataset2 = load('fcmdata.dat')
[center,U,T,obj_fcn] = pfcm(dataset1,3);

maxU = max(U);
%Find data points with highest grade of membership
%in cluster1
index1 = find(U(1,:) == maxU);
% Find the data points with highest grade of
%membership in cluster2
index2 = find(U(2,:) == maxU);

setosa = dataset1(find(dataset1(:,5)==1), :);
versicolor = dataset1(find(dataset1(:,5)==2),:);   % data for class 2
virginica = dataset1(find(dataset1(:,5)==3), :);   % data for class 3


Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
for j = 1:6,
        x = pairs(j, 1); 
        y = pairs(j, 2);   
        subplot(2,3,j);
        plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
             [setosa(:,y) versicolor(:,y) virginica(:,y)], '.');
        for k = 1:3
                text(center(k, pairs(j,1)), center(k,pairs(j,2)), int2str(k), 'FontWeight', 'bold');
        end
        xlabel(Characteristics{x},'FontSize',10); 
        ylabel(Characteristics{y},'FontSize',10);
end
