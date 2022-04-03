function [sqnr,MSE] = sqnr_mse_calculation_scalar(signal, qindices, qcenters,N)
%SQNR Calculation --> SQNR = P_signal_x / P_quantized_x = E[X^2] / E[~X^2]
%where E[X^2] = mean(signal^2) and E[~X^2] = mean((x - ~x)^2) = mean((x - Q(x))^2) = MSE
levels = 2^N;

%Quantized signal
for j=1:length(qindices)
    final_qindices(j) = levels + 1 - qindices(j);
end

quantized_signal = qcenters(final_qindices);
quantized_signal = transpose(quantized_signal);

%E[X^2] = mean(signal^2)
E_X = mean(signal.^2);

%E[~X^2] = mean((x - ~x)^2)
temp = signal - quantized_signal;
E_X_tilde = mean(temp.^2);

%sqnr calculation in db
sqnr = 10*log10(E_X/E_X_tilde);

%Mean Squared Error
MSE = E_X_tilde;