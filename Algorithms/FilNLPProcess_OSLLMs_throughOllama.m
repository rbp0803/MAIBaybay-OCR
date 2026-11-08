% --------------------------------------------------------------------------------%
% Connects to the Ollama Chat Completions API and returns the response.           %      
% Programmed by Rodney Pino at University of the Philippines - Diliman            %
% Programming dates: July 2026 to October 2026                                    % 
% --------------------------------------------------------------------------------%

%IMPORTANT
% Install Ollama software first, then download the model by running 
% "!ollama pull [modelName]" in the MATLAB Command Window.

%parent function: contextfinder.m
function [response1]=FilNLPProcess_OSLLMs_throughOllama(InputText0)
%InputText0 = an array of filipino phrases with ambiguous words to be
%processed for NLP


systemPrompt="You are a Filipino language expert.";
%Choose a model
%-----------------------------------------------------------
%%Uncomment the line below to enable the qwen2.5:7b-instruct model

model = ollamaChat("qwen2.5:7b-instruct",systemPrompt,TimeOut=100);
%-----------------------------------------------------------
%%Uncomment the line below to enable the chatgph/gph-main model

%model = ollamaChat("chatgph/gph-main",systemPrompt,TimeOut=100);
%-----------------------------------------------------------

fprintf('\nEnabled NLP Model: %s\n\n', model.ModelName);

%Goal and Output Prompts
userPrompt1="Given the following set of Filipino sentences, identify the sentence that is both grammatically correct and contextually appropriate. Please ensure to evaluate both spelling and structure but do not edit:";
userPrompt2="Return strictly the most grammatically correct and contextually accurate sentence from the set. Do not provide explanations, just the selected sentence. ";
%------------------------

input0="";
for zzz = 1:length(InputText0)
input0 = input0 + """" + InputText0(zzz) + """; ";
end
InputText0= strtrim(input0);

userPrompt=userPrompt1 + newline + InputText0 + newline + userPrompt2;
disp('↓↓↓↓ Submitted Prompt Entry ↓↓');
disp(userPrompt);


%extract selected model response
tStart=tic;
[response1,~,info]= generate(model, userPrompt, "Temperature",1, "TopP",1,...
"MaxNumTokens",8192, "TailFreeSamplingZ",1,"MinP",0,"TopK",1,"StopSequences",[],...
"Seed", 1); 
tEnd=toc(tStart)


disp('Input Tokens:')
disp(info.Body.Data.prompt_eval_count)
disp('Output Tokens:')
disp(info.Body.Data.eval_count)
end