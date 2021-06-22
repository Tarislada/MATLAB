function trlick = trlck(rawtrial,structure)
    maxtrial =  max(max(rawtrial));
    trlick = cell(maxtrial,length(structure));
    for i = 1:length(structure)
        try
            tmptron = structure(i).TRON;
            tmptrof = structure(i).TROF; 
            tmplick = structure(i).LICK;
        catch
            continue;
        end
        try
            % length(tmptron) = length(tmptrof);
            tmptr = [tmptron tmptrof];
        catch
            if tmptron(1)<tmptrof(1)
                tmptr = padcat(tmptron,tmptrof);
            else
                tmptrof(1) = [];
                tmptr = padcat(tmptron,tmptrof);
                % trof 가 tron보다 작은경우는 tron이 되기 전에 of를 먼저 한번 했다는 소리
                % 즉, tron이 recording보다 먼저 들어갔거나, 이미 열린 상태에서 시작된 것
                % 두 경우를 분리해야?
            end
            
        end
        
        tmpsize = size(tmptr);
        for ii = 1:tmpsize(1)
            triallick = tmplick((tmptr(ii,1)<tmplick) & (tmplick<tmptr(ii,2)));
            if isempty(triallick)
                triallick = NaN;    
            end
            trlick(ii,i) = {triallick};
        end
        %trlick(1,i) = {structure(i).name};
    end
end
