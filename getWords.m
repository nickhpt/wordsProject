function [wordclass_words] = getWords(words_char,string)
%Function was specifically made for nouns, so the names doesnt make sense,
%but it can be used for all word classes. 
incr_sb=0;
numWords=65265;
for j=1:numWords
    current = words_char(j,:);
    sb_idx=strfind(current,string);
    word_length = sb_idx-1;
    
        if(~isempty(sb_idx))
            incr_sb=incr_sb+1;
            wordclass_words{incr_sb}=current(1:word_length);
          
        end
    
end
end

