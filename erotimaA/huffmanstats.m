function [stats] = huffmanstats(prob,avglen)
%Calculates stats about the encoding

%Calculates Entropy
Entropy = prob*log2(1./prob)';

%Calculates the effiency of the encoding
eff = Entropy/avglen;

%Get stats
stats = table(Entropy,avglen,eff,'VariableNames',{'Entropy' 'Average Length' 'efficiency'});
