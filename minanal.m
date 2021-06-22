function [minlick,mintime,mintrial] = minanal(divind,structure,minute)
longest = max(divind(2:end) - divind(1:end-1)); 
minlick = nan(length(divind),longest);      % creating NAN array with enough size
mintrial = nan(length(divind),longest);
mintime = nan(length(divind),longest);

tarmin = minute*60;
for ii = 1:length(divind)-1     % for each subject
    minlck = [];   % initialize the lick count on each session
    iter = 1;   % initialize the count of total sessions of a subject
    mintrl = [];
    for iii = divind(ii):divind(ii+1)-1     % for each session of a subject
        try 
            lck = length(structure(iii).LICK(structure(iii).LICK<=tarmin));     % extract exact # of licks 
        catch MEL
            fprintf('LICK - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MEL.message);       % if error occurs, tell me where and what 
            lck = 0;
            %continue;   % then just skip that session
        end
        try
            trl = length(structure(iii).TRON(structure(iii).TRON<=tarmin));
        catch MET
            fprintf('TRIAL - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MET.message);
            trl = 0;
            %continue;
        end
        try
            tim = sum(structure(iii).LOFF(structure(iii).LOFF<=tarmin)-structure(iii).LICK(structure(iii).LICK<=tarmin));
        catch METI
            fprintf('LICK Time - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,METI.message);
            tim = 0;
            %continue;
        end
        mintime(ii,iter) = tim;
        mintrial(ii,iter) = trl;
        minlick(ii,iter) = lck;     % record the # of licks on the right subject and session
        iter = iter+1;      % next session
   end
end
minlick = minlick';
mintime = mintime';
mintrial = mintrial';
end
