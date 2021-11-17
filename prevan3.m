function [aftav,aftesc] = prevan3(avesc,targetstat,relativityflag)
chkavesc = avesc(~isnan(avesc));
chkstat = targetstat(~isnan(targetstat));
aftav = [];
aftesc = [];
if length(chkavesc) ~= length(chkstat)
    error('avesc and targetstat length is different');
end
for i = 1:length(targetstat)
    tmpavescvec = avesc(:,i);
    workingavescvec = tmpavescvec(~isnan(tmpavescvec));
    tmpstat = targetstat(:,i);
    workingvec = tmpstat(~isnan(tmpstat));
    
    avidx = find(workingavescvec==1);
    escidx = find(workingavescvec==0);

            
        if relativityflag
            if max(escidx) == length(workingvec)
                escidx(end) = [];
            end
            if max(avidx) == length(workingvec)
                avidx(end) = [];
            end
            workingstat = diff(tmpstat);
            tmpaftav = workingstat(avidx);
            tmpaftesc = workingstat(escidx);
        else
            avidx = avidx+1;
            escidx = escidx+1;
            if max(escidx) == length(workingvec)
                escidx(end) = [];
            end
            if max(avidx) == length(workingvec)
                avidx(end) = [];
            end
            tmpaftav = workingstat(avidx);
            tmpaftesc = workingstat(escidx);
        end
        %if length(avidx) + length(escidx) <n
            aftav = [aftav; tmpaftav];
            aftesc = [aftesc; tmpaftesc];
        %end
end

end
