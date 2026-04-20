% --------------------------------------------------------------------------------%
% Connects the OpenAI Chat Completions Chat API request and returns its response. %      
% Programmed by Rodney Pino at University of the Philippines - Diliman            %
% Programming dates: September 2025 to April 2026                                 % 
% --------------------------------------------------------------------------------%

%IMPORTANT
%loadenv(".env file with valid OPENAI API Key first")

%parent function: contextfinder.m
function [response1]=FilNLPProcess(InputText0)
%InputText0 = an array of filipino phrases with ambiguous words to be
%processed for NLP

apiKey=getenv("OPENAI_API_KEY");
if isempty(apiKey)
    disp("Missing environment variable: ""OPENAI_API_KEY""." + newline+ "Please load a valid ""OPENAI_API_KEY"" using loadenv function." +newline);
end



systemPrompt="You are a Filipino language expert.";

%The three chatgpt models being tested for the identification of contextually coherent Tagalog phrase

model = openAIChat(systemPrompt,ModelName="gpt-5",TimeOut=100);
%model = openAIChat(systemPrompt,ModelName="gpt-5-mini",TimeOut=100);
%model = openAIChat(systemPrompt,ModelName="gpt-5-nano",TimeOut=100);

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

%tStart=tic;  
tStart=tic;
response1= generate(model, userPrompt);  %extract GPT model response
tEnd=toc(tStart)
end