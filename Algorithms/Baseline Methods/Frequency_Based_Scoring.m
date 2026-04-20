function score = Frequency_Based_Scoring(sentence, wordCounts)
    words = strsplit(lower(sentence));
    score = 0;
    
    for i = 1:length(words)
        word = words{i};
        
        if isKey(wordCounts, word)
            prob = wordCounts(word);
        else
            prob = 1e-2; % unseen word fallback
        end
        
        score = score + log(prob);
    end
end