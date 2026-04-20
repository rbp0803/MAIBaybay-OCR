function score = Ngram_LM_Scoring_Function(sentence, trigramCounts, bigramCounts)
    words = ["<s>", "<s>", strsplit(lower(sentence)), "</s>"];
    score = 0;
    
    for i = 1:length(words)-2
        w1 = words{i};
        w2 = words{i+1};
        w3 = words{i+2};
        
        trigram = strcat(w1, "_", w2, "_", w3);
        bigram = strcat(w1, "_", w2);
        
        if isKey(trigramCounts, trigram) && isKey(bigramCounts, bigram)
            prob = trigramCounts(trigram) / bigramCounts(bigram);
        else
            prob = 1e-6; % smoothing
        end
        
        score = score + log(prob);
    end
end