%% first third, second third, final third analysis

function [f3rd, t3rd, fn3rd]= third_analysis(targetarray)
numstrip = sum(~isnan(targetarray),1);
f3index = floor(numstrip ./ 3);
t3index = floor(numstrip .* 2/3);
tmpsize = size(targetarray);
% ���̰� �� �ٸ���. ���� nan �Ҵ� �� �����ؾ� ��
f3rd = nan(max(f3index),tmpsize(2));
t3rd = nan(max(t3index-f3index),tmpsize(2));
fn3rd = nan(max(numstrip-t3index),tmpsize(2));
for i = 1:length(f3index)
    try
        f3rd(:,i) = [targetarray(1:f3index(i),i); nan(size(f3rd,1)-length(targetarray(1:f3index(i),i)),1)];        
    catch
        % 0 ��� - ��ü ���̰� 0,1,2�� ���. 
        % ��ü ���̰� 0 �ΰ�� Nan�� ����� �Ѿ��
        % 1�ΰ�� �� 2�� ���� initial�� �ְ� �ٸ� �� �׷��� NaN���� ����
        f3rd(:,i) = targetarray(1:length(f3rd(:,i)),i);
        % 
    end
end
for ii = 1:length(t3index)
    t3rd(:,ii) = [targetarray(f3index(ii)+1:t3index(ii),ii); nan(size(t3rd,1)-length(targetarray(f3index(ii)+1:t3index(ii),ii)),1)];
end
for iii = 1:length(fn3rd)
    fn3rd(:,iii) = [targetarray(t3index(iii)+1:numstrip(iii),iii); nan(size(fn3rd,1)-length(targetarray(t3index(iii)+1:numstrip(iii),iii)),1)];
end
