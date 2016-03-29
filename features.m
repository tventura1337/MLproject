%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: features.m
% Author: Peter Welby
%
% This script extracts features from the training set and saves the design
% matrix to the file "data.mat"
% 
% Additionally, the target classification vector is constructed, with
% target classification '1' for positive reviews, and '0' for negative reviews
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sentiment word lists
POS_INDICATORS = textread("wordlists\\positive-words.txt", "%s", "commentstyle", ";");
NEG_INDICATORS = textread("wordlists\\negative-words.txt", "%s", "commentstyle", ";");


% Example file lists
posfiles = glob("project-data\\pos\\*.txt");
negfiles = glob("project-data\\neg\\*.txt");

% Design matrix
X = [];

% Iterate over all positive example reviews
printf("Processing positive examples...\n");
for i = 1:length(posfiles)
  posex = posfiles{i,1};
  posexText = textread(posex, "%s", "delimiter", " \t\n\b\r", "whitespace", "\".,:!?-;()*");
  negCount = 0;
  posCount = 0;
  
  for j = 1:length(posexText)
    if (ismember(posexText{j,1}, NEG_INDICATORS))
      negCount = negCount + 1;
    elseif (ismember(posexText{j,1}, POS_INDICATORS))
      posCount = posCount + 1;
    else
      continue;  
    endif
  endfor
  % [negCount, posCount] are the extracted features
  X = [X; 1, negCount, posCount];
endfor

% Iterate over all negative example reviews
printf("Processing negative examples...\n");
for i = 1:length(negfiles)
  negex = negfiles{i,1};
  negexText = textread(negex, "%s", "delimiter", " \t\n\b\r", "whitespace", "\".,:!?-;()*");
  negCount = 0;
  posCount = 0;
  
  for j = 1:length(negexText)
    if (ismember(negexText{j,1}, NEG_INDICATORS))
      negCount = negCount + 1;
    elseif (ismember(negexText{j,1}, POS_INDICATORS))
      posCount = posCount + 1;
    else
      continue;
    endif  
  endfor
  % [negCount, posCount] are the extracted features
  X = [X; 1, negCount, posCount];
endfor

% Initialize target classification vector:
% The first 12500 examples are positive, the following 12500 are negative
printf("Initializing target vector...\n");
y = [ones(12500,1);zeros(12500,1)];

% Save the matrices to respective files
printf("Saving matrix data...\n");
save target.mat y
save data.mat X
printf("Done.");

