%% Trial open~first lick latency

function latencymat = lick1latency(rawtrial,structure)
maxtrial =  max(max(rawtrial));
latencymat = nan(maxtrial,length(structure));

    for i = 1:length(structure)
        try
            tmp_tr = [structure(i).TRON structure(i).TROF];
        catch
            tmp_tr = padcat(structure(i).TRON,structure(i).TROF);
            tmp_tr(isnan(tmp_tr)) = 1000;
        end
        
        for ii = 1:size(tmp_tr),1;
            targetlick = structure(i).LICK(tmp_tr(ii,1)< structure(i).LICK & structure(i).LICK<tmp_tr(ii,2));

            if isempty(targetlick)
                continue;
            else                
                latencymat(ii,i) = structure(i).TRON(ii) - targetlick(1);
                
            end
        end
        
    end
    
end
