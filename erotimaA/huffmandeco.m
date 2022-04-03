function sig = huffmandeco(code, dict)
%Decodes the input based on a huffman dictionary

%Get the length of the dictionary and code
dict_len = sum(cellfun('size',dict,1));
dict_len = dict_len(2);
code_len = size(code,1);

%Get the symbols code from the dictionary
symbols_code = cell(dict_len,1);
for i = 2:dict_len
    symbols_code{i} = dict{i,2};
end

%Initialize the signal
sig = [];
sig_temp =[];

%Match Dictionary Symbols with Code Symbols and create the decoding
for i = 1:code_len
    for j=1:dict_len
        if strcmp(symbols_code(j),code{i})
            sig_temp =[sig_temp, dict{j,1}];
        end
    end
end
sig = transpose(sig_temp);


%For extension
if size(sig,2)>1
    %Get final text string
    temp =[];

    for i=1:size(sig,1)
        temp = [temp sig(i,1), sig(i,2)];
    end
    sig = temp;
else
    %Get final string
    sig = convertCharsToStrings(sig);
end