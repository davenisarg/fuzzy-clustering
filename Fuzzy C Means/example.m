clear all
clc
%addpath('fcm')
load('iris.mat')

c = 3;
metric = @euclidean;
X = iris(1:150,  1:4);
X1 = iris(1:150,  5);
m = 1.7;
Max = 100;
tol = 1e-3;
folds = 10
pair_counter = 0;

%Data Normalization

%[nr nc] = size(X);
%for i = 1:nc
%   for j = 1:nr
%     data(j, i) = (X(j, i)-std(X(:, i)))/mean(X(:, i));
%   end
%end


%Running the Algorithm
[prediction,v] = fcm(c, X, m, metric, Max, tol);
%U
%v
setosa = iris(find(iris(:,5)==1), :);
versicolor = iris(find(iris(:,5)==2),:);   % data for class 2
virginica = iris(find(iris(:,5)==3), :);   % data for class 3
Characteristics = {'sepal length','sepal width','petal length','petal width'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
for j = 1:6,
        x = pairs(j, 1); 
        y = pairs(j, 2);   
        subplot(2,3,j);
        plot([setosa(:,x) versicolor(:,x) virginica(:,x)],...
             [setosa(:,y) versicolor(:,y) virginica(:,y)], '.');
        for k = 1:c,
                text(v(k, pairs(j,1)), v(k,pairs(j,2)), int2str(k), 'FontWeight', 'bold');
        end
        xlabel(Characteristics{x},'FontSize',10); 
        ylabel(Characteristics{y},'FontSize',10);
end

for i= 1:150
    if X1(i) == prediction(i)
        pair_counter = pair_counter +1;
    end
end
accuracy = pair_counter/(0.5*m*(m-1));
disp(accuracy)
%prediction