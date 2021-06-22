function [neg, pos] = prevan2(targetarray)
%targetarray = pstshir2atk;
neg = [];
pos = [];
for i = 1:length(targetarray)

    workingvec = targetarray(:,i);
    tmpvec = workingvec(~isnan(workingvec));
    tmpvec = tmpvec(tmpvec~=0);
    
    negidx = find(tmpvec<0);
    posidx = find(tmpvec>0);
    
    if max(negidx) == length(tmpvec)
        negidx(end) = [];
    end
    if max(posidx) == length(tmpvec)
        posidx(end) = [];
    end
    
    
    diffvec = diff(tmpvec);
    tmpneg = diffvec(negidx);
    tmppos = diffvec(posidx);
  
    %if  length(posidx) + length(negidx) > 20
        neg = [neg; tmpneg];
        pos = [pos; tmppos];
    %end
    
end
end
%평균내지 말고, rawdata그대로 추출해서 통계돌려보자
%trial 수 20이하만 분석
