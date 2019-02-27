function [U_new,T_new,center_new,obj_fcn]= pstepfcm(data,center,U,T,cluster_n, expo,a,b,nc,ni)
% PSTEPFCM One step in possiblisticfuzzy c-mean
% clusteringperforms one iteration of pfcm
% clustering, where DATA: matrix of data to be
% clustered. (Each row is a data point.)U:partition
% matrix. (U(i,j) is the MF value of data j in cluster
% j.) CLUSTER_N: number of clusters.EXPO:
% exponent (> 1) for the partition matrix.U_NEW:
%new partition matrix of fcmT_new: new partition
%matrix of pcmCENTER: center of clusters. (Each
% row is a center.) obj_fcn: objective function for
% partition U and T. Note that the situation of
% "singularity" (one of the data points isexactly the
% same as one of the cluster centers)
% isnotchecked.However, it hardly occurs in
% practice.
mf = U.^expo; % MF matrix after exponential
%modification
tf=T.^nc;
tfo=(1-T).^nc;
center_new = (a.*mf+b.*tf)*data./((ones(size(data,2), 1)*sum(a.*mf.'+b.*tf.'))');
dist = distfcm(center, data);
% fill the distance matrix
obj_fcn=sum(sum((dist.^2).*(a.*mf+b.*tf)))+sum(ni.*sum(tfo));
% objective function
tmp = dist.^(-2/(expo-1));
U_new=tmp./(ones(cluster_n,1).*sum(tmp));
tmpt=((b./ni).*dist.^2).^(1./(nc-1));
T_new = 1./(1.+tmpt);