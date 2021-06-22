function expstruct = rearnge(structure,rawtrial,avescmat)
    stleng = length(structure);
    triallick = trlck(rawtrial,structure);
    C = cellfun(@length, triallick);
    for i = 1:stleng
        expstruct(i).session = structure(i).name;
        expstruct(i).trial = length(structure(i).TRON);
        expstruct(i).trialtype = avescmat(:,i);
        
        
        expstruct(i).totallick = C(:,i);
        %expstruct(i).totallick = length(structure(i).LICK);
        % need trial lick; just drew the whole lick - solved
        
        expstrucut(i).licktime = triallick(:,i);
        %expstruct(i).licktime = structure(i).LICK;
        % need trial lick; just drew the whole lick
    end
    
end
