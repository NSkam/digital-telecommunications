function [sqnr,MSE] = sqnr_mse_calculation_vector(signal, qindices, qcenters)
%SQNR Calculation --> SQNR = P_signal_x / P_quantized_x = E[X^2] / E[~X^2]
%where E[X^2] = mean(signal^2) and E[~X^2] = mean((x - ~x)^2) = mean((x - Q(x))^2) = MSE

%Quantized signal
quantized_signal = qcenters(qindices,:);

%E[X^2] = mean(signal^2)
E_X = sum(mean(signal.^2))/2;

%E[~X^2] = mean((x - ~x)^2)
temp = signal - quantized_signal;
E_X_tilde = sum(mean(temp.^2))/2;

%sqnr calculation in db
sqnr = 10*log10(E_X/E_X_tilde);

%Mean Squared Error
MSE = E_X_tilde;