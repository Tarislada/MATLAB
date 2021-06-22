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
                % trof �� tron���� �������� tron�� �Ǳ� ���� of�� ���� �ѹ� �ߴٴ� �Ҹ�
                % ��, tron�� recording���� ���� ���ų�, �̹� ���� ���¿��� ���۵� ��
                % �� ��츦 �и��ؾ�?
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
