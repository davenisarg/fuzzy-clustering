function T = pinitf(cluster_n, data_n)
T = rand(cluster_n, data_n);
col_sum = sum(T);
u=col_sum(ones(cluster_n, 1), :);
T = T./u;
end