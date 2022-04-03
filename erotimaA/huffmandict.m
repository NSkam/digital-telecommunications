function [dict ,avglen] = huffmandict(sym, prob)
%Generates a dictionary based on huffman code

%Get the length of the vectors(they are the same)
n = length(prob);

%Sort the probabilities
[p,ind] = sort(prob);

%Combinations matrix
m=zeros(n-1,n);


%Combining the elements. We put the combinded
%element always first
for i=1:n-1
    m(i,:)=[ind(1:n-i+1),zeros(1,i-1)];
    p=[p(1)+p(2),p(3:n),1];
    [p,ind]=sort(p);
end


%The prefix binary tree
tree = repmat(' ',n-1,n^2);

%Initializing the tree
tree(1, n) = '0';
tree(1,n*2) = '1';


%Constructing the tree
for i=2:n-1
    comb_sym_ind = (find(m(n+1-i,:)==1));
    tree(i,1:n-1) = tree(i-1,n*(comb_sym_ind-1)+2:n*(comb_sym_ind));
    tree(i,n)='0';
    tree(i,n+1:2*n-1) = tree(i-1,n*(comb_sym_ind-1)+2:n*(comb_sym_ind));
    tree(i,2*n)='1';
    for j=1:i-1
        other_sym_ind = (find(m(n-i+1,:)==j+1));
        tree(i,(j+1)*n+1:(j+2)*n)=tree(i-1,n*(other_sym_ind-1)+1:n*other_sym_ind);
    end
end

%Extract the codes for each symbol
for i=1:n
    symbol_ind = (find(m(1,:)==i));
    huff_code(i,1:n)= tree(n-1,n*(symbol_ind-1)+1:n*symbol_ind);
end

%Remove some whitespaces
huff_code = strtrim(huff_code);

%Creating the dictionary
dict = cell(n+1,2);

dict{1,1} = {'Symbols'};
dict{1,2} = {'Code'};


for j=2:n+1
    dict{j,1} = sym(:,j-1);
    dict{j,2} = huff_code(j-1,:);
end

%Calculate average length
for i=1:n
    len(i)=length(find(abs(huff_code(i,:))~=32));
    lp(i) = len(i)*prob(i);
end

avglen = sum(lp);
