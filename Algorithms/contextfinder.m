% -------------------------------------------------------------------------------%
% Sets up the array of Tagalog phrases by combining transliterated Baybayin      % 
% words with recognized Latin words (whenever detected).                         %     
% Programmed by Rodney Pino at University of the Philippines - Diliman           %
% Programming dates: September 2025 to October 2026                              % 
% -------------------------------------------------------------------------------%

%parent function: Baybayintransliterations.m
function correct_context=contextfinder(single_lines3,output,RW)


%[~, Idx1]=find(output==1);

%LatWords=RW(Idx1);

Process1=cell(size(single_lines3,1),length(output));

z1=0;
if nnz(output)==0
    Process1=single_lines3;
else
    for am=1:length(RW)
    if output(am)==1
        Process1(:,am)=RW(am);
    else
        z1=z1+1;
        Process1(:,am)=single_lines3(:,z1);
    end
    end
end

rowCells = mat2cell(Process1, ones(1, size(Process1,1)), size(Process1,2));
Phrase1 = cellfun(@(row) strjoin(row, ' '), rowCells, 'UniformOutput', false);
Phrase2=cell2mat(Phrase1);
Phrase3=string(Phrase2);

% Three type of functions are available to call the NLP baseline or proprietary models.
% Uncomment the desired model to be used.
%---------------------------------------------------------------------------------------
% Call to integrate proprietary GPT Models for NLP module 
response1=FilNLPProcess_GPTModels(Phrase3); 

% Call to integrate open-source LLM Models for NLP module
%response1=FilNLPProcess_OSLLMs_throughOllama(Phrase3);

% Call to integrate open-source BERT Models for NLP module
%response1=FilNLPProcess_BERTModels(Phrase3);


disp(response1); %display model response
%-----------------------

response1=erase(response1,";");
Phrase4=strsplit(response1); ans1=Phrase4{1}; ans2=Phrase4{length(Phrase4)};

if isequal(ans1(1),'"')
    Phrase4{1}=strrep(ans1,'"','');
    Phrase4{length(Phrase4)}=strrep(ans2,'"','');
end

for kk=1:length(Phrase4)
    Phrase4{kk}=strrep(Phrase4{kk},',','');
    Phrase4{kk}=strrep(Phrase4{kk},'.','');
    Phrase4{kk}=strrep(Phrase4{kk},'!','');
    Phrase4{kk}=strrep(Phrase4{kk},'?','');    
end

Phrase5=cellstr(Phrase4);


for acm=1:length(rowCells)
    if isequal(lower(rowCells{acm}),lower(Phrase5))
        disp('↑↑ Coherent Transliteration ↑↑');
        break
    end
end

correct_context=single_lines3(acm,:);


end
