    rawtrial = prerob_rawtrial;
    structure = prerob;
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
            tmptr = padcat(tmptron,tmptrof);
            if length(tmptron) > length(tmptrof)
                tmpitimat = tmptron(2:end)-tmptrof(1:end);
            else
                tmpitimat = tmptron(1:end)-tmptrof(2:end);
            end
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
                tmppstavesc(ii) = 0;
                tmplatmat(ii) = 0;
                tmpirnummat(ii) = 0;
            else
                tmppstavesc(ii) = trir(end)<trat(1);
                % 1 = avoidance, 0 = escape
                tmplatmat(ii) = trir(end)-trat(1);
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