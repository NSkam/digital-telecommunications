%Load and parse the cameraman picture
cameraman = load('cameraman.mat');
cameraman_values = cameraman.i;
cameraman_len = length(cameraman_values);

%Transform the cameraman matrix into a vector using reshape
cameraman_vec = reshape(cameraman_values,cameraman_len^2,1);

%Guess the probabilities
[counts,unique] = groupcounts(cameraman_vec);

cameraman_vec_size = length(cameraman_vec);

prob = [];

for i=1:length(counts)
    prob(i) = counts(i)/cameraman_vec_size;
end

%Huffman Encoding
%Create the Dictionary
unique = transpose(unique);
[dict ,avglen] = huffmandict(unique, prob);

%Encode the source
code = huffmanenco(cameraman_vec, dict);

%Convert to array
code_array = cell2mat(code(:,:));

%Remove some whitespaces
code_array = strtrim(code_array);

%Convert Binary to numbers
number_array = code_array-'0';

%reshape the array
number_array = reshape(number_array, 1,65536*16);

%remove the whitespaces
number_array = number_array(number_array~=-16);

%Transmitting the signal
y = bsc(number_array);

%Count the errors
err_cnt = 0;
not_err_cnt =0;

for i=1:length(number_array)
    if number_array(i)~=y(i)
        err_cnt = err_cnt + 1;
    end
    if number_array(i)==y(i)
        not_err_cnt = not_err_cnt + 1;
    end
end

%Calculate the probability p
p_error = err_cnt/length(number_array);
p_correct = not_err_cnt/length(number_array);

%Verify it is correct
if p_error==1-p_correct
    error('Probabilities arent correct');
end

%Calculate the capacity of the channel
H = -p_correct * log2(p_correct) - (1-p_correct)*log2(1-p_correct);

Capacity = 1 - H;
