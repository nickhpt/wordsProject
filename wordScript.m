close all;clear all;clc
% open the file and read lines 
fid=fopen('wordstxtformat.txt'); 
numWords=65265;

%Populate cell array with all the words 
for i=1:numWords
cellArray{i}=fgetl(fid);
end

cellArray(cellfun('isempty',cellArray)) = []; % remove empty cells from mm

%Remove numbers in front of some words, indicating several word-classes for
%one word, 7 must be enough. Also remove some white-spaces
match=["1.","2.","3.","4.","5.","6,","7."," ","' '","''"];
strings_clean = erase(cellArray,match);
%Convert cell array to char
words_char=char(strings_clean);

%Brute force remove all white-spaces by using "regexpprep", but it also
%truncates the string a lot, so it is also appended with D's for dummy, to
%match the original words_char size (65265x724 char)
maxlen=724;
for j=1:numWords
    append_length = maxlen-length(regexprep(words_char(j,:), '\s+', '')) ;
    words_char(j,:) = strcat(regexprep(words_char(j,:), '\s+', ''),repmat('D',1,append_length));    
end


%Get all words. 
%out=getWords(words_char,'sb.,')
%input: 1: Clean words, 2: Word class on the form 'sb.,','vb.,'...
nouns = getWords(words_char,'sb.,');
verbs = getWords(words_char,'vb.,');
prep  = getWords(words_char,'præp.,');
adj   = getWords(words_char,'adj.,');


%Number of words missing; to be declared
missing=numWords - (length(nouns)+length(verbs)+length(prep)+length(adj))

