% -------------------------------------------------------------------------------%
% Sets up the array of Tagalog phrases by combining transliterated Baybayin      % 
% words with recognized Latin words (whenever detected).                         %     
% Programmed by Rodney Pino at University of the Philippines - Diliman           %
% Programming dates: September 2025 to April 2026                                % 
% -------------------------------------------------------------------------------%

function correct_context=contextfinder_baselinemethod(single_lines3,output,RW)
tStart=tic;

%============Using Word2Vec-based=======================================================
persistent emb
    if isempty(emb)
        data = load('InsertPath\W2V_emb_Model.mat','emb');
        emb = data.emb;
    end
%=======================================================================================    
%============Using Frequency-based======================================================
% persistent wordCounts
%     if isempty(wordCounts)
%         data = load("InsertPath\Frequency_based_wordCounts.mat", "wordCounts");
%         wordCounts = data.wordCounts;
%     end
%=======================================================================================

%===========Using Trigram============================================================= 
% persistent bigramCounts
%     if isempty(bigramCounts)
%         data = load("InsertPath\Ngram_bigramCounts.mat", "bigramCounts");
%         bigramCounts = data.bigramCounts;
%     end
% persistent trigramCounts
%     if isempty(trigramCounts)
%         data = load("InsertPath\Ngram_trigramCounts.mat", "trigramCounts");
%         trigramCounts = data.trigramCounts;
%     end    
%=====================================================================================


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
sentences=string(Phrase2);

scores = zeros(1, length(sentences));

for i = 1:length(sentences)
   scores(i) = w2v_context_score(sentences(i), emb);
%    scores(i) = Frequency_Based_Scoring(sentences(i), wordCounts);
%    scores(i) = Ngram_LM_Scoring_Function(sentences(i), trigramCounts, bigramCounts);    
end

[~, idx] = max(scores);

iddx = find(scores == max(scores));   % Find all indices equal to max
    if numel(iddx) > 1
        disp('Multiple max values found!');
    end

response1=sentences(idx);

response1=erase(response1,";");
Phrase4=strsplit(response1); ans1=Phrase4{1}; ans2=Phrase4{length(Phrase4)};

if isequal(ans1(1),'"')
    Phrase4{1}=strrep(ans1,'"','');
    Phrase4{length(Phrase4)}=strrep(ans2,'"','');
end

Phrase5=cellstr(Phrase4);

%z2=0;
for acm=1:length(rowCells)
    if isequal(rowCells{acm},Phrase5)
        disp("Chosen: " + sentences(idx))
        break
    end
end

correct_context=single_lines3(acm,:);
%disp('↑↑ Coherent Transliteration ↑↑');

tEnd=toc(tStart)



end