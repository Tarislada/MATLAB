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
                % trof 가 tron보다 작은경우는 tron이 되기 전에 of를 먼저 한번 했다는 소리
                % 즉, tron이 recording보다 먼저 들어갔거나, 이미 열린 상태에서 시작된 것
                % 두 경우를 분리해야?
            end
            
            if length(tmptron) > length(tmptrof)
                tmpitimat = tmptron(2:end)-tmptrof(1:end);
            elseif length(tmptron) < length(tmptrof)
                tmpitimat = tmptron(1:end)-tmptrof(2:end);
            elseif length(tmptron) == length(tmptrof)
                tmpitimat = tmptron(2:end) - tmptrof(1:end-1);
            end
            % 왜 tron에서 trof를 빼지? trof에서 다음 tron을 빼야 iti 아닌가?
            % 그렇게 한거 맞음 그냥 (-) 곱하기 귀찮아서 수식 순서 바꿔놓은거
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
                % end로 하면 마지막 withdrawl 기준으로 판단, 1로하면 최초 withdrawl 기준 판단
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
