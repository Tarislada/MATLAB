function divided = divin23(targetmat)
%targetmat = A;
    targetsize = size(targetmat);
    divided = zeros(3,targetsize(2));
    for i = 1:targetsize(2)
        tmpvec = targetmat(:,i);
        tmpvecmod = tmpvec(~isnan(tmpvec));
        trd = floor(length(tmpvecmod)/3);
        divided(:,i) = [mean(tmpvecmod(1:trd)); mean(tmpvecmod(trd+1:trd*2)); mean(tmpvecmod(trd*2+1:end))];
    end
    
end