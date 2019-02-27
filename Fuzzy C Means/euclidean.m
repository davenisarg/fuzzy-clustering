% A function for calculation of euclidean distance of a point x
function [d] = euclidean(x, Y)
           S = size(Y);
           d = sum((repmat(x, [S(1),1])-Y).^2, 2);
           d = sqrt(d);
end