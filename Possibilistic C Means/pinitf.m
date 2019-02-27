function U = pinitf(cluster_n, data_n)
U = rand(cluster_n, data_n);
col_sum = sum(U);
u=col_sum(ones(cluster_n, 1), :);
U = U./u;
end