function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

for i = 1:K
	single_centroid = zeros(1, n);
	
	inx_for_current_centroid = find(idx == i);
	len = length(inx_for_current_centroid);
	
	points_for_current_centroid = zeros(len, n);

	points_for_current_centroid = X(inx_for_current_centroid(1:len), :);

	single_centroid = sum(points_for_current_centroid) / length(inx_for_current_centroid);

	centroids(i, :) = single_centroid;
end

	








% =============================================================


end

