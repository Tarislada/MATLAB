% I think this is plane bull crap
% especially the part where you have to code the lick as the start of a
% visit and code the relative time position of the lick. this disaster of a
% data has been born thanks to the laziness of one person who cannot code
% in any language and is not willing to change his origianl data which only
% contains even more bullcrap and meaningless garbage
% why throw away information for nothing? you would want as much
% information as you can get. I mean you have so little you couldn't figure
% out shit from it so your asking someone else to do it and you want to
% delete information yourself? it's either you're stupid or you're
% incompetent. noting more, noting less.
% name/session type/session date/trial type/trial number/total # of licks/lickdata(1,100)
function exptxt = rearrange(structure,rawtrial,avescmat)
    
    triallick = trlck(rawtrial,structure);
    C = cellfun(@length, triallick);
    for i = 1:length(structure)-1
        %tmpstruct = structure(i);
        
        % figuring out trial number of a session and marking it
        tmptrial = rawtrial(:);
        tmptrial = tmptrial(~isnan(tmptrial));
        trialnum = tmptrial(i);
        tmpcell = cell(trialnum,7);
        % output cell per one structure(one session) is trialnumber(row) by
        % 7+(column)
        tmpcell(:,5) = mat2cell(1:trialnum,ones(1,1:length(trialnum)));
        
        % figuring out av/esc of a trial and marking it
        tmpavesc = avescmat(:);
        tmpavesc = tmpavesc(~isnan(tmptrial));
        avesc = tmpavesc(1:trialnum,i);
        
        tmpcell(:,4) = mat2cell(avesc,ones(1,1:length(avesc)));
        
        % figuring out total number of licks in trials and marking it      
        totlick = C(1:trialnum,i);
        tmpcell(:,6) = mat2cell(totlick,ones(1,1:length(totlick)));
                
        % name
        tmpcell(:,1) = {structure(i).name};        
        
        % marking trial lick 
        tmpcell(:,7) = triallick(1:trialnum,i);
        
        % session type
        tmpcell(:,2) = {'R'};
        % session date
        workingsession = rawtrial(:,i);
        workingsession = workingsession(workingsession~=0);
        
        tmpcell(:,3) = mat2cell(1:length(workingsession),ones(1,1:length(workingsession)));
        
        
        %% filewrite part
        fileID = structure(i).name;
        writecell(tmpcell,'fileID');
        %fprintf(fileID,tmpcell);
        %fclose(fileID);
    end
    
end