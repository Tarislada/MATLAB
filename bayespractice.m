%% 직전시행까지 escape의 횟수에 따라 avoid 할 확률
% sum을 적극 활용. Column 에 1,2,3,4,....등 escape 횟수
% row 에 결과값 (0 / 1)

function bayesmat = bayespractice(avescmat)
        workvec = avescmat(~isnan(avescmat));
        findzero = find(workvec==0);
        bayesmat = nan(2,length(findzero));
        for i = 1:length(findzero)
            
            %tmpvec = workvec(findzero(i):end);
            bayesmat(1,i) = length(findzero)-i;
            %length(find(tmpvec==0));
            %length(findzero(i):length(workvec)) - i;
            % # of avoidance events 
            bayesmat(2,i) = length(findzero(i):length(workvec));
            % # of total events
        end
        addendum = [length(findzero);length(workvec)];
        bayesmat = [addendum bayesmat];
end