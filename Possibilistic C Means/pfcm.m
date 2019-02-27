function[center,U,T,obj_fcn]=pfcm(data,cluster_n,options)
[center,U,obj_fcn]=fcm(data,cluster_n) %findsN_CLUSTER
if nargin ~= 2 & nargin ~= 3
    error('Too many or too few input arguments!');
end
data_n = size(data, 1);
in_n = size(data, 2);
% Change the following to set default options
default_options = [2;100;1e-1;1;1;4;2];
if nargin == 2
    options = default_options;
else
% If "options" is not fully specified, pad it with
% default values.
if length(options) < 7
    tmp = default_options;
    tmp(1:length(options)) = options;
    options = tmp;
end
% If some entries of "options" are nan's, replace them
% with defaults.
nan_index = find(isnan(options)==1);
options(nan_index) = default_options(nan_index);
if options(1) <= 1
    error('The exponent should be greater than 1!');
end
end
expo = options(1);
max_iter = options(2);
min_impro = options(3);
display = options(4);
a=options(5);
b=options(6);
nc =options(7);
ni=input('enter value of ni');
obj_fcn = zeros(max_iter, 1);
% Array for objective function
center = input('initialize the centre');

U = pinitf(cluster_n, data_n); % Initial fuzzy partition
T = tinitf(cluster_n,data_n); % Initial typicality
%matrix
for i = 1:max_iter
    [U,T,center, obj_fcn(i)] = pstepfcm(data,center,U,T,cluster_n, expo,a,b,nc,ni);
    if display
        fprintf('Iteration count = %d, obj. fcn = %E \n', i,obj_fcn(i));
    end
    % check termination condition
    if i > 1
        if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro
            break;
        end
    end
end
iter_n = i; % Actual number of terations
obj_fcn(iter_n+1:max_iter) = [];

% Plot of objection function
%iter_n = i;         % Actual number of iterations 
%figure;             % New figure
%obj_fcn(iter_n+1:max_iter) = [];% Delete unused elements
%plot(obj_fcn); axis([1 i min(obj_fcn) max(obj_fcn)]);
%title('Objective Function for IRIS Data Clustering');
%xlabel('Numbers of Iterations');