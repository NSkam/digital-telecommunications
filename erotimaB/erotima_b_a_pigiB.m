%Generate the required signal and run the lloyd max scalar quantizer.

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

%Levels for the scalar quantizer.
N_scalar = [2,3,4];
epsilon = 10^(-16);

%First round for scalar N = 2 and epsilon = 10^(-16).
x = signal_x;
[xq, centers, D_scalar1, sqnr_vec1] = Lloyd_Max(x, N_scalar(1), min_value, max_value, epsilon);

%Plot the SQNR to Kmax figure
figure = figure();
plot(1:length(sqnr_vec1),sqnr_vec1)
title('SQNR to Kmax')
xlabel('repetions' )
ylabel('SQNR')

%Second round for scalar N = 3 and epsilon = 10^(-16).
x = signal_x;
[xq, centers, D_scalar3, sqnr_vec2] = Lloyd_Max(x, N_scalar(2), min_value, max_value, epsilon);

%Plot the SQNR to Kmax figure
figure = figure();
plot(1:length(sqnr_vec2),sqnr_vec2)
title('SQNR to Kmax')
xlabel('repetions' )
ylabel('SQNR')

%Third round for scalar N = 4 and epsilon = 10^(-16).
x = signal_x;
[xq, centers, D_scalar5, sqnr_vec3] = Lloyd_Max(x, N_scalar(3), min_value, max_value, epsilon);

%Plot the SQNR to Kmax figure
figure = figure();
plot(1:length(sqnr_vec3),sqnr_vec3)
title('SQNR to Kmax')
xlabel('repetions' )
ylabel('SQNR')
