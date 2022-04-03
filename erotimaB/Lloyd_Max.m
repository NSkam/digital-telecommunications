function [xq, centers, D_scalar, sqnr_vec] = Lloyd_Max(x, N, min_value, max_value,epsilon)
%Lloyd Max quantizer
%    Inputs:
%         x = original signal
%         N = number of bits
%         min_value = minimum value for the outuputs of the signal
%         max_value = maximum value for the outuputs of the signal
%     Outuputs:
%         xq = quantized output signal
%         centers = the quantization centers
%         D = average distortion

%Step 0: Initialize variables and preprocess the signal
D=[-1 1];
k=2;
levels = 2^N;
minv = min_value;
maxv = max_value;
x(x<minv) = minv;
x(x>maxv) = maxv;
if epsilon ==0
    epsilon = eps;
end


%Step 1: Guess the initial reprsentitive levels
initial_levels = (maxv-minv).*rand(levels-2,1) + minv;
centers = [minv transpose(initial_levels) maxv];

centers = sort(centers);

%Step 2: As long as the algorithm doesn't converge repeat the steps:
%     2a: Calculate the decision thresholds
%     2b: Calculate the quantized signal and the median distortion
%     2c: Calculate the new reprsentitives levels

while abs(D(k)-D(k-1))>= epsilon
    
    %The quantized signal
    xq=[];
    
    %The decision thresholds
    T=[];
    
    
    %Step 2a
    for i=1:length(centers)-1
        T(i) = (centers(i) + centers(i+1))/2;
    end
    T = [minv T maxv];

    
    %Step 2b:  
    %Quantized Signal Calculation
    for i=1:size(x)
        for j = 1:length(T)-1
            if x(i)>= T(j) && x(i) <= T(j+1)
                xq(i) = levels+1-j;
            end
        end
    end
    xq = transpose(xq);

    %Distortion Calculation and calculation of total value of signal
    %x in every level and counts the number of values in each level
    Distortion = 0;
    sumx = zeros ( 1 , length (T)-1);
    countx= zeros ( 1 , length (T)-1);
    for i=1:size(x)
        for j = 1:length(T)-1
            if x(i)>= T(j) && x(i) <= T(j+1)
                Distortion = Distortion + (x(i) - centers(j))^2;
                sumx(j) = sumx(j)+ x(i);
                countx(j) = countx(j) + 1;
            end
        end
    end
    
    Average_Distortion = Distortion/length(x);
    D = [D Average_Distortion];
    D_scalar = D;
    k=k+1;
    
    %Step 2c: 
    %Calculate the new reprsentitives levels
    for i=2:length(centers)-1
        centers(i) = sumx(i)/countx(i);
        if isnan(centers(i))
            centers(i) = centers(i-1) + 0.01;
        end
    end
       
    %For 2a)
    sqnr_vec(k-2) = sqnr_mse_calculation_scalar(x, xq, centers, N);
    
end


