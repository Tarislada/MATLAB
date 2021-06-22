%% A function that does the basic analysis of the dataset
% output will be raw number of licks, lick time, # of trials for each
% subject, w. each subject as colums and sessions in rows
% input needs to be dividing index (result of function div) and the target
% data in form of structure, with LICK, LOFF, TRON

function [rawlick,rawtime,rawtrial] = basicanalysis(divind, structure)

longest = max(divind(2:end) - divind(1:end-1)); 

rawlick = nan(length(divind),longest);      % creating NAN array with enough size
rawtrial = nan(length(divind),longest);
rawtime = nan(length(divind),longest);

for ii = 1:length(divind)-1     % for each subject
    lck = [];   % initialize the lick count on each session
    iter = 1;   % initialize the count of total sessions of a subject
    trl = [];
    for iii = divind(ii):divind(ii+1)-1     % for each session of a subject
        try 
            lck = length(structure(iii).LICK);     % extract exact # of licks 
        catch MEL
            fprintf('LICK - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MEL.message);       % if error occurs, tell me where and what 
            lck = 0;
            %continue;   % then just skip that session
        end
        try
            trl = length(structure(iii).TRON);
        catch MET
            fprintf('TRIAL - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MET.message);
            trl = 0;
            %continue;
        end
        try
            tim = sum(structure(iii).LOFF-structure(iii).LICK);
        catch METI
            fprintf('LICK Time - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,METI.message);
            tim = 0;
            %continue;
        end
        rawtime(ii,iter) = tim;
        rawtrial(ii,iter) = trl;
        rawlick(ii,iter) = lck;     % record the # of licks on the right subject and session
        iter = iter+1;      % next session
   end
end
rawlick = rawlick';
rawtime = rawtime';
rawtrial = rawtrial';
end
