%Input the file
text = fileread('cvxopt.txt');

%Input English frequencies
p = fileread('frequencies.txt');
p = strsplit(p);

%Initialize and parse english frequencies
prob = [];

for i=2:2:size(p,2)
    prob = [prob,str2double(p{i})];
end

%Create the symbol array
symbols = 'a':'z';
symbols = [symbols, ' '];

%Create the huffman dictionary
[dict ,avglen] = huffmandict(symbols, prob);

%Encode the text
code = huffmanenco(text, dict);

%Decode the code
sig = huffmandeco(code, dict);

if ~isequal(text,sig)
    error('The decoded input is different from the original input')
end

%Get stats
stats = huffmanstats(prob,avglen);

