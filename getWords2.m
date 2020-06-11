function [wordclass_words] = getWords(words_char,string,toggle)
%Function to index different word classes
%Toggle cases
%1: Nouns,verbs,pron,adv,adj around 60k words
%2: All Abbreviations
%3: Conjuctions

switch toggle
    case 1
        incr_sb=0;
        numWords=65265;
        for j=1:numWords
            current = words_char(j,:);
            idx=strfind(current,string);
            word_length = idx-1;

                if(~isempty(idx))
                    incr_sb=incr_sb+1;
                    wordclass_words{incr_sb}=current(1:word_length);

                end
        end

    case 2
        incr=0;
        numWords=65265;
        for j=1:numWords
            current = words_char(j,:);
            idx=strfind(current,string);
            idx(idx==1)=[];
            

                if( ~isempty(idx) && strcmp(current(idx-2),'.') )
                   % if strcmp(current(idx-1),'(')
                        word_length = idx-2;
                        incr=incr+1;
                        
                        wordclass_words{incr}=current(1:word_length);
                   % end

                end
        end
        
    case 3
        incr=0;
        numWords=65265;
        for j=1:numWords
            current = words_char(j,:);
            idx=strfind(current,string);
            idx(idx==1)=[];
            

                if( ~isempty(idx) && ~strcmp(current(idx-1),',') )
                   % if strcmp(current(idx-1),'(')
                        word_length = idx-1;
                        incr=incr+1;
                        wordclass_words{incr}=current(1:word_length);
                   % end

                end
        end
end
    
end


