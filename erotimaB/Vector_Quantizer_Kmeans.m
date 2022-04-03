function [idx, C, D_vec, Vector_matrix] = Vector_Quantizer_Kmeans(x, N, min_value, max_value)
%Vector quantizer based on K-means clustering

%levels of the quantization process = number of centroids used for Kmeans
levels = 2^N;

%Filtering the Values greater and less than min and max values given
minv = min_value;
maxv = max_value;

x(x<minv) = minv;
x(x>maxv) = maxv;

%Reshape input signal to matrix of vectors
sig_size = length(x);
matrix_dimension_size = sig_size/2;

Vector_matrix = reshape(x,matrix_dimension_size,2);

%Run Kmeans Algorithm
[idx,C] = kmeans(Vector_matrix, levels);

%Average Distortion Calculation
Total_Distortion = 0;

for i=1:length(Vector_matrix)
    representative_index = idx(i);
    Total_Distortion = Total_Distortion + norm(Vector_matrix(i,:)-C(representative_index,:), 2);
end

D_vec = Total_Distortion/length(x);



