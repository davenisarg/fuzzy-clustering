function out = pdistfcm(center, data)
%PDISTFCM Distance measure in possiblistic fuzzy
%c-mean clustering.OUT = PDISTFCM(CENTER,
%DATA) calculates the Euclidean distancebetween
%each row in CENTER and each row in DATA, and
%returns a distance matrix OUT of size M by N,
%where M and N are row dimensions of CENTER
%and DATA, respectively, and OUT(I, J) isthe
%distance between CENTER(I,:) and DATA(J,:).
out = zeros(size(center, 1), size(data, 1));
% fill the output matrix
if size(center, 2) > 1
    for k = 1:size(center, 1)
        out(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)'));
    end
else
for k = 1:size(center, 1)
    out(k, :) = abs(center(k)-data)';
end
end