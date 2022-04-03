function code = huffmanenco(sig, dict)
%Encodes the input based on a huffman dictionary

%Get the length of the dictionary and signal
dictionary_len = sum(cellfun('size',dict,1));
dict_len = dictionary_len(2);
sig_len = numel(sig);

%Get the symbols from the dictionary
symbols = [dict{2:dict_len,1}];

%For extension
if dictionary_len(1)>dictionary_len(2)
    %Initialize the code
    code = cell(sig_len/2,1);

    %counter
    k=1;

    %Match Dictionary Symbols with Signal Symbols and create the encoding
    for i = 1:sig_len/2
        indx_a = strfind(symbols(1,:),sig(k));
        indx_b = strfind(symbols(2,:),sig(k+1));
        indx=intersect(indx_a,indx_b);
        code{i} = dict{indx+1,2};
        k=k+2;
    end
else
    
    %For regular source
    %Initialize the code
    code = cell(sig_len,1);
    
    %Match Dictionary Symbols with Signal Symbols and create the encoding
    for i = 1:sig_len
        indx = strfind(symbols,sig(i));
        code{i} = dict{indx+1,2};
    end
end