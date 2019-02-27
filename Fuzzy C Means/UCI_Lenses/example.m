clear all
clc
%addpath('fcm')

filename = 'lenses.txt';
delimiterIn = '\t';
lenses = importdata(filename,delimiterIn);

c = 3;
metric = @euclidean;


X = lenses(1:24,  1:4);
X1 = lenses(1:24,  5);

m = 1.7;
Max = 100;
tol = 1e-3;
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
hard = lenses(find(lenses(:,5)==1), :);
soft = lenses(find(lenses(:,5)==2), :);   % data for class 2
no = lenses(find(lenses(:,5)==3), :); 
Characteristics = {'Age','Prescription','astigmatic','tear production rate'};
pairs = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
for j = 1:6,
        x = pairs(j, 1); 
        y = pairs(j, 2);   
        subplot(2,3,j);
        plot([hard(:,x) soft(:,x) no(:,x)],...
             [hard(:,y) soft(:,y) no(:,y)], '.');
        for k = 1:c,
                text(v(k, pairs(j,1)), v(k,pairs(j,2)), int2str(k), 'FontWeight', 'bold');
        end
        xlabel(Characteristics{x},'FontSize',10); 
        ylabel(Characteristics{y},'FontSize',10);
end

for i= 1:24
    if X1(i) == prediction(i)
       pair_counter = pair_counter +1;
    end
end
accuracy = pair_counter/(0.5*m*(m-1));
disp(accuracy)
%prediction