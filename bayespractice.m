%% ����������� escape�� Ƚ���� ���� avoid �� Ȯ��
% sum�� ���� Ȱ��. Column �� 1,2,3,4,....�� escape Ƚ��
% row �� ����� (0 / 1)

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