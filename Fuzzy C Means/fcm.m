%Fuzzy C-means Algorithm
%Inputs:
%******c: Number of clusters
%******X: Data Matrix N_samples*N_features
%******U_up: U updating function 
%******m: Fuzzifier as a real number
%******metric: Distance metric as a function (by default Euclidean)
%******Max: Maximum number of iterations
%******tol: Tolerance

%Outputs: 
%******prediction: Predicted labels of data
%******v: Center  of clusters as a matrix c*N_features

%defining function



function [prediction v] = fcm(c, X, m, metric, Max, tol)
[n, no] = size(X);
U = zeros([c, n]);
%v = repmat(max(X), c, 1).*rand([c, no]); %for random initialization
%v = repmat(max(X), c, 1).*randn([c, no]); %centers selected from Gaussian normal Distribution
%r = randi([1 140],1,3);
v = [50,34,15,2;65,28,46,15;64,32,53,23];
disp(v)
U = rand([c, n]);

for j = 1:n
      U(:, j) = U(:, j)./sum(U(:, j));      
end  

for i = 1:c
      v(i, :) = sum((X.*repmat(U(i, :)'.^m, 1, 4)),1)./sum(U(i, :).^m);
end

v_old = v;
delta = 1e4;
k = 0;
while  (k<Max & delta>tol)
    for i = 1:c
      for j = 1:n
        U(i, j) = 1/sum((metric(X(j, :), v(i, :))./metric(X(j, :), v)).^(2/(m-1)));
      end
    end
    for i = 1:c
       v(i, :) = sum((X.*repmat(U(i, :)'.^m, 1, 4)), 1)./sum(U(i, :).^m);
    end
v_new = v;
delta = max(max(abs(v_new-v_old)));
v_old = v;

k = k+1;
end
prediction = zeros([1, n]);
for i = 1:n
   [M, prediction(i)]=max(U(:, i));
end
disp(prediction)
disp(U)
end