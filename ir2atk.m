%% last ir out to atk latency
function [ir2atkmat]=ir2atk(rawtrial,structure)
maxtrial =  max(max(rawtrial));
ir2atkmat = nan(maxtrial,length(structure));

for i = 1:length(structure)
        try
            tmptron = structure(i).TRON;
            tmptrof = structure(i).TROF; 
            tmpat = structure(i).ATTK;
            tmpir = structure(i).IROF;
        catch
            continue;
        end
    
        try
            % length(tmptron) = length(tmptrof);
            tmptr = [tmptron tmptrof];
        catch
            tmptr = padcat(tmptron,tmptrof);
            tmptr(isnan(tmptr)) = 9999;
        end
        repeatnum = size(tmptr);
     for ii = 1:repeatnum(1);
            trat = tmpat((tmptr(ii,1)<tmpat) & (tmpat<tmptr(ii,2)));
            trir = tmpir((tmptr(ii,1)<tmpir) & (tmpir<tmptr(ii,2)));
            if or(isempty(trat),isempty(trir))  
                tmplatmat(ii) = 0;
            else
                tmplatmat(ii) = trir(end)-trat(1);
            end
             % 1 = avoidance, 0 = escape
        end
        ir2atmat(:,i) = [tmplatmat; nan((maxtrial - length(tmptr)),1)];
    end
end