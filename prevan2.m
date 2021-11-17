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
  
    if  length(posidx) + length(negidx) <= 23
         %trial ���� ���� �м� ���� ����
        neg = [neg; tmpneg];
        pos = [pos; tmppos];
    end
   
    
end
end
%��ճ��� ����, rawdata�״�� �����ؼ� ��赹������

