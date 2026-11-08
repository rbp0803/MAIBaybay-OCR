% --------------------------------------------------------------------------------%
% Loads the pre-trained model from Hugging Face and calculates the Pseudo Log     %
% Likelihood (PLL) for each candidate phrase                                      %      
% Programmed by Rodney Pino at University of the Philippines - Diliman            %
% Programming dates: July 2026 to October 2026                                    % 
% --------------------------------------------------------------------------------%

%IMPORTANT
% Implementing the BERT models requires calling Python functionalities from MATLAB 
% through the transformers library. 
% 1. Ensure a compatible Python environment is configured in MATLAB.
% 2. Install the necessary Python packages (e.g., transformers) before running.
% You may run 'pyenv' in the MATLAB Command Window to check your active Python version.


%parent function: contextfinder.m
function topScorerPhrase_mBERTmultiMDL=FilNLPProcess_BERTModels(candidates)

% 1. Setup Model Name and Import Modules
% Comment the default and uncomment a modelName below to enable a different BERT model.
%---------------------------------------------------------------------------------
modelName = "jcblaise/roberta-tagalog-base"; % Tagalog-specific RoBERTa-base model
%modelName = "jcblaise/roberta-tagalog-large"; % Tagalog-specific RoBERTa-large model
%modelName ="google-bert/bert-base-multilingual-uncased"; % Multilingual BERT (mBERT) model

fprintf('\nEnabled NLP Model: %s\n\n', modelName);

py_auto = py.importlib.import_module('transformers.models.auto.tokenization_auto');

% IMPORT FOR MASKED LANGUAGE MODELING
py_mlm = py.importlib.import_module('transformers.models.auto.modeling_auto'); 
py_torch = py.importlib.import_module('torch');

% 2. Initialize Tokenizer and Masked LM Model
pyTokenizer = py_auto.AutoTokenizer.from_pretrained(modelName);

pyModel = py_mlm.AutoModelForMaskedLM.from_pretrained(modelName); %AutoModelForMaskedLM

pyModel.eval();
py_torch.set_grad_enabled(false);

% Extract the special mask token ID from your working tokenizer
maskID = pyTokenizer.mask_token_id;

scores = zeros(length(candidates), 1);

tStart=tic;
% 4. Scoring Loop (Pseudo-Log-Likelihood)
for c = 1:length(candidates)
    sentence = candidates{c};
    
    % Encode sentence to token IDs using your working python tokenizer
    encoded = pyTokenizer(sentence, pyargs('return_tensors', 'pt'));
    input_ids = encoded.get('input_ids'); 
    
    % Convert the PyTorch tensor directly into a standard MATLAB cell array
    original_ids = cell(input_ids.tolist{1}); 
    num_tokens = length(original_ids);
    
    total_log_prob = 0;
    
    % Loop through tokens to mask them one-by-one
    % Skip position 1 (BOS token) and the last position (EOS token)
    for i = 2:(num_tokens - 1)
        % Create a fresh copy of the tokens in MATLAB
        masked_ids = original_ids;
        
        % Save target token ID
        target_id = original_ids{i}; 
        
        % Replace current index with the mask ID directly in MATLAB (1-indexed)
        masked_ids{i} = maskID;
        
        % Convert the modified cell array back into a PyTorch tensor
        input_tensor = py_torch.tensor(py.list({py.list(masked_ids)}));
        
        % Run the forward pass
        outputs = pyModel(input_tensor);
        logits = outputs.get('logits'); % Shape: [1, SequenceLength, VocabSize]
        
        % Calculate log-probabilities via PyTorch LogSoftmax BEFORE slicing. This applies log_softmax across the VocabSize dimension (dim=2)
        log_probs_tensor = py_torch.nn.functional.log_softmax(logits, pyargs('dim', int64(2)));
        
        % Convert the PyTorch tensor to a MATLAB array by squeezing it, convert to numpy, then convert to a native MATLAB matrix
        matlab_log_probs = double(log_probs_tensor.squeeze(int64(0)).detach().cpu().numpy());

        % WARNING: If the direct conversion above throws a MATLAB/Python data type error, 
        % it is likely due to an underlying Python environment or memory locking issue. 
        % If a system restart doesn't fix it, use the alternative approach boxed below:

        %==========================================================================================================================
        %        % Convert the NumPy array to a Python array, then to a MATLAB double                                             %
        %        flat_probs = double(py.array.array('d', log_probs_tensor.squeeze(int64(0)).detach().cpu().numpy().flatten()));   %
        %        seq_len = num_tokens;                                                                                            % 
        %        vocab_size = length(flat_probs) / seq_len;                                                                       %
        %        % CRITICAL STEP: Reshape back to a 2D matrix matching MATLAB's column-major ordering                             %
        %        % Python is Row-Major (Rows change slowest), so we read it into MATLAB transposed, then flip it.                 %
        %        matlab_log_probs = reshape(flat_probs, vocab_size, seq_len)';                                                    %
        %==========================================================================================================================        
        
        % EXTRACT NATIVELY IN MATLAB (1-Indexed!). Python sequence position (i-1) becomes index 'i' in MATLAB
        % Python target_id remains an integer token pointer (add 1 because Python IDs are 0-indexed)
        matlab_sequence_index = i; 
        matlab_vocab_index = int64(target_id) + 1;
        
        % Extract using native MATLAB matrix indexing (Row = Sequence Position, Col = Vocab Word)
        target_prob = matlab_log_probs(matlab_sequence_index, matlab_vocab_index);
        
        total_log_prob = total_log_prob + target_prob;
    end
    
    scores(c) = total_log_prob;

end
% 5. Determine the winner
[~, bestIdx] = max(scores);

topScorerPhrase_mBERTmultiMDL=candidates(bestIdx);
tEnd=toc(tStart)


end