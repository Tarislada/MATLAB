function  tmpvec = avescvec(rawarray,timenumvec,group,subjectnum)
    tmpvec = rawarray(:);
    tmpvec(isnan(tmpvec)) = [];
    
    tmpvec(:,2) = group;
    tmpvec(:,3) = subjectnum;
   
    timenumvec2 = [0 timenumvec];
    timenumvec2(end) = [];
    for ii = 1:length(timenumvec)
        tmpvec(1+sum(timenumvec2(1:ii)):sum(timenumvec(1:ii)),4) = ii;
    end
    
end