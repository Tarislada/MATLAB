%% A fuction that analyzes avoidance-escape patterns
% output will be a matrix with 1 as avoidance (exit before attack), 0 as
% escape (exit after attack), and NAN as fillers
% input needs to be rawtrial (result of fuction basicanalysis) and the
% target data in structure with TROF, TRON, ATTK, IROF right under.
% padcat function also needs to exist. can be downloaded with ease.

function  [avescmat,ir2atkmat,irnummat, itimat] = avesc(rawtrial, structure)
    maxtrial =  max(max(rawtrial));
    avescmat = nan(maxtrial,length(structure));
    ir2atkmat = nan(maxtrial,length(structure));
    irnummat = nan(maxtrial,length(structure));
    itimat = nan(maxtrial,length(structure));
    % 1 = avoidance, 0 = escape
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
            tmpitimat = tmptron(2:end)-tmptrof(1:end-1);
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
            
            if length(tmptron) > length(tmptrof)
                tmpitimat = tmptron(2:end)-tmptrof(1:end);
            elseif length(tmptron) < length(tmptrof)
                tmpitimat = tmptron(1:end)-tmptrof(2:end);
            elseif length(tmptron) == length(tmptrof)
                tmpitimat = tmptron(2:end) - tmptrof(1:end-1);
            end
            % �� tron���� trof�� ����? trof���� ���� tron�� ���� iti �ƴѰ�?
            % �׷��� �Ѱ� ���� �׳� (-) ���ϱ� �����Ƽ� ���� ���� �ٲ������
        end
        
        % tmptr = [tmptron tmptrof];
        
        tmppstavesc = zeros(length(tmptr),1);
        tmplatmat = zeros(length(tmptr),1);
        tmpirnummat = zeros(length(tmptr),1);
        
        tmpsize = size(tmptr);
        for ii = 1:tmpsize(1)
            trat = tmpat((tmptr(ii,1)<tmpat) & (tmpat<tmptr(ii,2)));
            trir = tmpir((tmptr(ii,1)<tmpir) & (tmpir<tmptr(ii,2)));
            if or(isempty(trat),isempty(trir))  
                tmppstavesc(ii) = NaN;
                tmplatmat(ii) = NaN;
                tmpirnummat(ii) = NaN;
            else
                tmppstavesc(ii) = trir(1)<trat(1);
                %tmppstavesc(ii) = trir(end)<trat(1);
                % 1 = avoidance, 0 = escape
                % end�� �ϸ� ������ withdrawl �������� �Ǵ�, 1���ϸ� ���� withdrawl ���� �Ǵ�
                tmplatmat(ii) = trir(end)-trat(1);
                tmplatmat(abs(tmplatmat)>8.5) = NaN;
                % <0 avoidance >0 escape
                tmpirnummat(ii) = length(trir);
                % 0 = error
                
            end
             
        end
        avescmat(:,i) = [tmppstavesc; nan((maxtrial - length(tmptr)),1)];
        ir2atkmat(:,i) = [tmplatmat; nan((maxtrial - length(tmptr)),1)];
        irnummat(:,i) = [tmpirnummat; nan((maxtrial - length(tmptr)),1)];
        itimat(:,i) = [tmpitimat; nan((maxtrial - length(tmpitimat)),1)];
    end
end
