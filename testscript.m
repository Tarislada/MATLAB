array = A_1;
% target array
resultcell = cell(1,max(array(:,4)));
%resultmat = NaN(250,max(array(:,4)));
% predetermine the size of result matrix

for i = 1:max(array(:,4))
    yidx = (array(:,4)==i);
    tmp = array(yidx,1);
    resultcell{1,i} = tmp;
    %resultmat(1:yidx,i) = tmp;
end

% ���� �м��� ���� data orgainization
% group�� training day (X), time(Y)
