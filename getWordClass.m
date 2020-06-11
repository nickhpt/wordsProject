    function [class] = getWordClass(string)
%Function determines wordclass by checking each of the defined word classes
%script should definitely be rewritten more effectively. 


load('nouns.mat');
load('adj.mat');
load('adv.mat');
load('prep.mat');
load('pron.mat');
load('verbs.mat');

wordLen = length(string);
j=1;
for i=1:length(nouns)
idx=strfind(nouns(i),string);
    if cell2mat(idx)>0 & length(nouns{i})==wordLen
        index_nouns(j)=i;
        j=j+1;
      
    end
end

%Adjectives
j=1;
for i=1:length(adj)
idx=strfind(adj(i),string);
    if cell2mat(idx)>0 & length(adj{i})==wordLen
        index_adj(j)=i;
        j=j+1;
      
    end
end

%Adverbs
j=1;
for i=1:length(adv)
idx=strfind(adv(i),string);
    if cell2mat(idx)>0 & length(adv{i})==wordLen
        index_adv(j)=i;
        j=j+1;
      
    end
end


%Prepositions
j=1;
for i=1:length(prep)
idx=strfind(prep(i),string);
    if cell2mat(idx)>0 & length(prep{i})==wordLen
        index_prep(j)=i;
        j=j+1;
      
    end
end

%Pronouns
j=1;
for i=1:length(pron)
idx=strfind(pron(i),string);
    if cell2mat(idx)>0 & length(pron{i})==wordLen
        index_pron(j)=i;
        j=j+1;
      
    end
end

%Verbs
j=1;
for i=1:length(verbs)
idx=strfind(verbs(i),string);
    if cell2mat(idx)>0 & length(verbs{i})==wordLen
        index_verbs(j)=i;
        j=j+1;
      
    end
end




end

