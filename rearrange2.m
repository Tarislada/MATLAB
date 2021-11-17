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
% what angers me is that he is trying to bend the rules to his favor to hid
% his incompetance and stupidity, while trying to make me look so. that is
% just outrageous. if u can't win, bend the rules to win. Wow! what a
% thinking! only the most incompetent, most stupid person would think of
% such things

% name/session type/session date/trial type/trial number/total # of licks/lickdata(1,100)
function exptxt = rearrange2(structure,rawtrial,avescmat,divind)
%structure = prerob;
%rawtrial = prerob_rawtrial;
%avescmat = preavesc;
%divind = prerobdivind;

    triallick = trlck(rawtrial,structure);
    C = cellfun(@length, triallick);
    workingtrials = rawtrial(:);
    workingtrials = workingtrials(~isnan(workingtrials));
    
    for i = 1:length(structure)-1
        %tmpstruct = structure(i);
        
        % figuring out trial number of a session and marking it
        trialnum = workingtrials(i);
        tmpcell = cell(trialnum,7);
        % output cell per one structure(one session) is trialnumber(row) by
        % 7+(column)
        tmpcell(:,4) = mat2cell((1:trialnum)',ones(length(1:trialnum),1));
        
        % figuring out av/esc of a trial and marking it
        % todo - reverse the shit because shit wants to
        tmpavesc = avescmat(1:trialnum,i);
        avesc = tmpavesc(1:trialnum);        
        avesc = (avesc-1)*-1;
        avesc(avesc==0)=0;
        tmpcell(:,6) = mat2cell(avesc,ones(length(avesc),1));
        
        % figuring out total number of licks in trials and marking it      
        totlick = C(1:trialnum,i);
        tmpcell(:,5) = mat2cell(totlick,ones(length(totlick),1));
                
        % name
        subjectID = string(regexp(structure(i).name,'^(\w+)-','tokens'));        
        tmpcell(:,1) = {subjectID};        
        
        % marking trial lick 
        tmplick = triallick((1:trialnum)',i);
        tmpfun = @(x) x-x(1);
        newlick = cellfun(tmpfun,tmplick,'UniformOutput',0);
        tmpcell(:,7) = newlick;
        
        % session type
        tmpcell(:,2) = {'R'};
        
        % session ID
        % which row is this session in a column of trials?
        % workingsession = workingtrials(i);
        tmpsession = diff(divind);
        tmpfun2 = @(x) 1:x;
        sessionID = cell2mat(arrayfun(tmpfun2, tmpsession,'UniformOutput',0))';
        tmpcell(:,3) = {sessionID(i)};
        %tmpcell(:,3) = mat2cell((1:length(workingsession))',ones(length(workingsession),1));    
        
        %% filewrite part
        tmptable = cell2table(tmpcell,'VariableNames',{'AnimalID','SessionID','Session_type','Trial_type','Trial_number','Number_of_licks','Lick_time'});
        
        location = 'D:\shitest';
        fileID = strcat(location,'\',structure(i).name);
        writetable(tmptable,fileID,'Filetype','text','Delimiter','tab','WriteVariableNames',0);
        %fprintf(fileID,tmpcell);
        %fclose(fileID);
    end
    
end