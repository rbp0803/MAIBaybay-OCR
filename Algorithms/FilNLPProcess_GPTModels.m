% --------------------------------------------------------------------------------%
% Connects the OpenAI Chat Completions Chat API request and returns its response. %      
% Programmed by Rodney Pino at University of the Philippines - Diliman            %
% Programming dates: September 2025 to October 2026                               % 
% --------------------------------------------------------------------------------%

%IMPORTANT
%loadenv(".env file with valid OPENAI API Key first")

%parent function: contextfinder.m
function [response1]=FilNLPProcess_GPTModels(InputText0)
%InputText0 = an array of filipino phrases with ambiguous words to be processed for NLP

apiKey=getenv("OPENAI_API_KEY");
if isempty(apiKey)
    disp('Missing environment variable: "OPENAI_API_KEY"');
end



systemPrompt="You are a Filipino language expert.";

%The four chatgpt models being evaluated for the identification of contextually coherent Tagalog phrase
%-----------------------------------------------------------------------------------------------------
model = openAIChat(systemPrompt,ModelName="gpt-5",TimeOut=100);
%model = openAIChat(systemPrompt,ModelName="gpt-5-mini",TimeOut=100);
%model = openAIChat(systemPrompt,ModelName="gpt-5-nano",TimeOut=100);
%model = openAIChat(systemPrompt,ModelName="gpt-4o-mini",TimeOut=100); Note: GPT-4o-mini has a maximum output limit of 16,384 tokens.


fprintf('\nEnabled NLP Model: %s\n\n', model.ModelName);

%-----------------------------------------------------------
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
disp('↓↓ Submitted Prompt Entry ↓↓');
disp(userPrompt);


%extract GPT model response for gpt-5 family
tStart=tic;
[response1,~,info]= generate(model, userPrompt, "Temperature",1, "TopP",1,"MaxNumTokens",128000,...
    "FrequencyPenalty",0,"PresencePenalty",0,"StopSequences",[], ...
    "Seed",1);  %change seed per iteration
tEnd=toc(tStart)

%extract GPT model response for gpt-4o-mini---------------------------------------------------------
%tStart=tic;
% [response1,~,info]= generate(model, userPrompt, "Temperature",1, "TopP",1,"MaxNumTokens",16384,...
%     "FrequencyPenalty",0,"PresencePenalty",0,"StopSequences",[], ...
%     "Seed",1);  %change seed per iteration
%tEnd=toc(tStart)


disp('Input Tokens:')
disp(info.Body.Data.usage.prompt_tokens)
disp('Output Tokens:')
disp(info.Body.Data.usage.completion_tokens)

end