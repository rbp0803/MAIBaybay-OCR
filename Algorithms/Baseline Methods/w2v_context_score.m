function score = w2v_context_score(sentence, emb)
    words = strsplit(lower(sentence));
    
    score = 0;
    count = 0;
    
    for i = 1:length(words)
        if ~isVocabularyWord(emb, words{i}), continue; end
        
        vec_i = word2vec(emb, words{i});
        
        for j = 1:length(words)
            if i == j, continue; end
            if ~isVocabularyWord(emb, words{j}), continue; end
            
            vec_j = word2vec(emb, words{j});
            
            sim = dot(vec_i, vec_j) / (norm(vec_i)*norm(vec_j));
            score = score + sim;
            count = count + 1;
        end
    end

end