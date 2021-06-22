%% first third, second third, final third analysis

function [f3rd, t3rd, fn3rd]= third_analysis(targetarray)
numstrip = sum(~isnan(targetarray),1);
f3index = floor(numstrip ./ 3);
t3index = floor(numstrip .* 2/3);
tmpsize = size(targetarray);
% 길이가 다 다르다. 사전 nan 할당 후 진행해야 함
f3rd = nan(max(f3index),tmpsize(2));
t3rd = nan(max(t3index-f3index),tmpsize(2));
fn3rd = nan(max(numstrip-t3index),tmpsize(2));
for i = 1:length(f3index)
    try
        f3rd(:,i) = [targetarray(1:f3index(i),i); nan(size(f3rd,1)-length(targetarray(1:f3index(i),i)),1)];        
    catch
        % 0 대비 - 전체 길이가 0,1,2인 경우. 
        % 전체 길이가 0 인경우 Nan을 남기고 넘어가고
        % 1인경우 와 2인 경우는 initial에 넣고 다른 두 그룹은 NaN으로 두자
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
