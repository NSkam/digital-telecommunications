%Generate the required signal and run the lloyd max scalar quantizer and
%the vector quantizer based on k-means. After that compare the two
%implementations.

%Size of the signal
M = 10000;

%The white noise
signal_x = randn(M,1);

%The a,b coefficients for the filter
b = 1;
a = [1 1/2 1/3 1/4 1/5 1/6 ];

%The filtered signal
signal_y = filter(b,a,signal_x);

%Min and Max values allowed
min_value = min(signal_y)+0.1;
max_value = max(signal_y)-0.1;

%Levels for each quantizer. Since we quantize two inputs at the same time
%for the vector quantizer, it will be 2*N for him. This is done to compare
%the two quantizers more efficiently.
N_scalar = [2,3,4];
N_vector = [4,6,8];

%First round for scalar N = 2 and vector N = 4.
x = signal_y;
[xq, centers, D_scalar1] = Lloyd_Max(x, N_scalar(1), min_value, max_value, 0);

y = signal_y;
[idx, C, D_vec1, vec_mat] = Vector_Quantizer_Kmeans(y, N_vector(1), min_value, max_value);

%SQNR Calculation
sqnr_scalar = [];
sqnr_vector = [];
MSE_scalar = [];
MSE_vector = [];

[sqnr_scalar(1), MSE_scalar(1)] = sqnr_mse_calculation_scalar(x, xq, centers, N_scalar(1));
[sqnr_vector(1), MSE_vector(1)] = sqnr_mse_calculation_vector(vec_mat, idx, C);

%Second round for scalar N = 3 and vector N = 6.
x = signal_y;
[xq, centers, D_scalar2] = Lloyd_Max(x, N_scalar(2), min_value, max_value, 0);

y = signal_y;
[idx, C, D_vec2, vec_mat] = Vector_Quantizer_Kmeans(y, N_vector(2), min_value, max_value);

%SQNR Calculation
[sqnr_scalar(2), MSE_scalar(2)] = sqnr_mse_calculation_scalar(x, xq, centers, N_scalar(2));
[sqnr_vector(2), MSE_vector(2)] = sqnr_mse_calculation_vector(vec_mat, idx, C);

%Third round for scalar N = 4 and vector N = 8.
x = signal_y;
[xq, centers, D_scalar3] = Lloyd_Max(x, N_scalar(3), min_value, max_value, 0);

y = signal_y;
[idx, C, D_vec3, vec_mat] = Vector_Quantizer_Kmeans(y, N_vector(3), min_value, max_value);

%SQNR Calculation
[sqnr_scalar(3), MSE_scalar(3)] = sqnr_mse_calculation_scalar(x, xq, centers, N_scalar(3));
[sqnr_vector(3), MSE_vector(3)] = sqnr_mse_calculation_vector(vec_mat, idx, C);

fprintf('For N = 2 bits the scalar SQNR was %f and the MSE was %f, while for N=4 the vector SQNR was %f and the MSE was %f.\n\n',sqnr_scalar(1), MSE_scalar(1),sqnr_vector(1), MSE_vector(1))

fprintf('For N = 3 bits the scalar SQNR was %f and the MSE was %f, while for N=6 the vector SQNR was %f and the MSE was %f.\n\n',sqnr_scalar(2), MSE_scalar(2),sqnr_vector(2), MSE_vector(2))

fprintf('For N = 4 bits the scalar SQNR was %f and the MSE was %f, while for N=8 the vector SQNR was %f and the MSE was %f.\n\n',sqnr_scalar(3), MSE_scalar(3),sqnr_vector(3), MSE_vector(3))
