function [neg, pos] = prevan(targetarray)
%targetarray = pstshir2atk;
neg = [];
pos = [];
%neg = zeros(1,length(targetarray));
%pos = zeros(1,length(targetarray));
negelnum = zeros(1,length(targetarray));
poselnum = zeros(1,length(targetarray));
negstd = zeros(1,length(targetarray));
posstd = zeros(1,length(targetarray));
for i = 1:length(targetarray)

    workingvec = targetarray(:,i);
    tmpvec = workingvec(~isnan(workingvec));
    
    negidx = find(tmpvec<0);
    posidx = find(tmpvec>0);
    
    negidx = negidx+1;
    posidx = posidx+1;
    
    if max(negidx)>length(tmpvec)
        negidx(negidx == max(negidx)) =[];
    end
    if max(posidx)>length(tmpvec)
        posidx(posidx == max(posidx)) =[];
    end
    
    %neg(i) = mean(tmpvec(negidx));
    %pos(i) = mean(tmpvec(posidx));
    negelnum(i) = length(negidx);
    poselnum(i) = length(posidx);
    negstd(i) = std(tmpvec(negidx));
    posstd(i) = std(tmpvec(posidx));
    %if  length(posidx) + length(negidx) > 20
        neg = [neg; tmpvec(negidx)];
        pos = [pos; tmpvec(posidx)];
    %end
    
end
    neg(neg==0) = [];
    pos(pos==0) = [];
%negpos = [neg;pos;negelnum;poselnum;negstd;posstd];
end
%��ճ��� ����, rawdata�״�� �����ؼ� ��赹������
%trial �� 20���ϸ� �м�
