%Input the file
text = fileread('cvxopt.txt');

%Count each letter
number_text = lower(text) - '0' - 48;
edges = 1:27;

%count(1) -> a, ...., count(26) --> z
counts = histcounts(number_text, edges);

%Count whitespaces
num_of_spaces = 6184 - sum(counts);

counts = [counts,num_of_spaces];

%Compute the probabilities of each letter and whitespace
prob = counts./6184;

if sum(prob) ~= 1
    error('Sum of probabilities must be equal to 1')
end

%Create the symbol array
symbols = 'a':'z';
symbols = [symbols, ' '];

sym = combvec(symbols,symbols);
p = combvec(prob,prob);

sym = char(sym);

final_prob = [];
final_prob=double(final_prob);
final_prob = p(1,:).*p(2,:);

%Create the huffman dictionary
[dict ,avglen] = huffmandict(sym, final_prob);

%Encode the text
code = huffmanenco(text, dict);

%Decode the code
sig = huffmandeco(code, dict);

if ~isequal(text,sig)
    error('The decoded input is different from the original input')
end

%Get stats
stats = huffmanstats(final_prob,avglen);

