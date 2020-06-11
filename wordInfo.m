function [WordClass] = wordInfo(string)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load('words_char.mat');
numWords=size(words_char,1);

%Get all words. 
%out=getWords(words_char,'sb.,')
%input: 1: Clean words, 2: Word class on the form 'sb.,','vb.,'...
nouns  = getWords(words_char,'sb.,',1);
verbs  = getWords(words_char,'vb.,',1);
prep   = getWords(words_char,'præp.,',1);
adj    = getWords(words_char,'adj.,',1);
adv    = getWords(words_char,'adv.,',1); adv(18) = cellstr("imedens");adv(19)=cellstr("imens");
pron   = getWords(words_char,'pron.,',1);
fork   = getWords(words_char,'fork.',2);
talord = getWords(words_char,'talord',1);
konj = getWords(words_char,'konj.;',3); konj(5) = cellstr("medens");konj=[konj cellstr("mens")];
udr = getWords(words_char,'udråbsord',1);
lyd = getWords(words_char,'lydord',1); lyd(19)=[];lyd(19)=cellstr("mjav");lyd(20)=cellstr("miav");
%Extend with irregular words
irreg_adj=cellstr(["længere","længst","større","størst","yngre","yngst","ældre","ældst","mindre","mindst","bedre","bedst"]);
irreq_nou=cellstr(["mænd","bøger","køer","børn"]);
adj = [adj irreg_adj];
nouns = [nouns irreq_nou];
% %Extend with irregular verbs
fidtest=fopen('irreqverbs3.txt'); 
for i=1:500
cellArray2{i}=fgetl(fidtest);
end
verbs=[verbs cellArray2];
verbs(7675:end)=[];


%Get lengths of the different word classes
j=1;
nlen = length(nouns);
vlen = length(verbs);
plen = length(prep);
ajlen = length(adj);
avlen =length(adv);
prlen =length(pron);
flen = length(fork);
tlen = length(talord);
klen = length(konj);
udrlen = length(udr);
lydlen = length(lyd);

%Create character vector with all the words
wordVec=[nouns verbs prep adj adv pron fork talord konj udr lyd];

%Create the intervals (indicies) in which the words for different wordsclasses are
%located. 
noun_interval=(1:nlen);
verb_interval=(nlen+1:nlen+vlen);
prep_interval=(nlen+vlen+1:nlen+vlen+plen);
adj_interval=(nlen+vlen+plen+1:nlen+vlen+plen+ajlen);
adv_interval=(nlen+vlen+plen+ajlen+1:nlen+vlen+plen+ajlen+avlen);
pro_interval=(nlen+vlen+plen+ajlen+avlen+1:nlen+vlen+plen+ajlen+avlen+prlen);
fork_interval=(nlen+vlen+plen+ajlen+avlen+prlen+1:nlen+vlen+plen+ajlen+avlen+prlen+flen);
talord_interval=(nlen+vlen+plen+ajlen+avlen+prlen+flen+1:nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen);
konj_interval = (nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+1:nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+klen);
udr_interval = (nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+klen+1:nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+klen+udrlen);
lyd_interval = (nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+klen+udrlen+1:nlen+vlen+plen+ajlen+avlen+prlen+flen+tlen+klen+udrlen+lydlen);
%Save intervals to struct
intervals.noun=noun_interval;
intervals.verb=verb_interval;
intervals.prep=prep_interval;
intervals.adj=adj_interval;
intervals.adv=adv_interval;
intervals.pro=pro_interval;
intervals.fork=fork_interval;
intervals.talord=talord_interval;
intervals.konj = konj_interval;
intervals.udr = udr_interval;
intervals.lyd = lyd_interval;
endings = {'en','ene','ende','e','er','erne','et','r','er','r','t','ere','st','est','s','n'};

% %Find index from string
% wordLen = length(string);
% for i=1:length(wordVec)
% idx=strfind(wordVec(i),string);
%     if cell2mat(idx)==1 & length(wordVec{i})==wordLen
%         index(j)=i;
%         j=j+1;
%       
%     end
%     
% end
% index(index==0)=[];
% 
% %Classify word
% for num = {'noun','verb','prep','adj','adv','pro','fork','talord','konj','udr','lyd'}
% result=intersect(index,intervals.(num{1}));
% 
% if ~isempty(result)
%     WordClass = num;
% end
% 
% end


clear index WordClass
%string='elefanten';
wordLen = length(string);
try
    for i=1:length(wordVec)
    idx=strfind(wordVec(i),string);
        if cell2mat(idx)==1 & length(wordVec{i})==wordLen
            index(j)=i;
            j=j+1;

        end

    end
    
    index(index==0)=[];   

    for num = {'noun','verb','prep','adj','adv','pro'}
    result=intersect(index,intervals.(num{1}));

        if ~isempty(result)
            WordClass = num
        end

    end
    
        catch error
        warning('Word not found')
        
        if strcmp(error.identifier,'MATLAB:UndefinedFunction') 
        disp('hi');
        
        %Write outer loop that augments word with endnings and compares
              
          for i=1:length(wordVec)
                idx=contains(string,wordVec(i));
                    if double(idx)==1 &&  length(wordVec{i})<=wordLen+4
                        index(j)=i;                    
                        j=j+1;                      
                    end
          end
          
          index(index==0)=[];
          
          t1 = wordVec(index);
          t2=t1(~cellfun('isempty',t1));
          
          
          for k = 1:length(t2)
          
          stub = wordVec(index);
          stub=stub(~cellfun('isempty',stub));
          
              for n = 1:length(endings)
                aug = strcat(stub(k),endings(n));
                cmp = strcmp(aug,string);               
                
                if cmp == 1
                    %IF true retrieve word index(n)  
                    widx = index(k);
                    disp('Comparison true')
                    for num = {'noun','verb','prep','adj','adv','pro','fork','talord','konj','udr','lyd'}
                        result=intersect(widx,intervals.(num{1}));

                            if ~isempty(result)
                                WordClass = num
                            end

                    end
                    
                break    
                end
                

              end
          
          end
        
        end
        
end

%index(index==0)=[];




end

