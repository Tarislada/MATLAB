%% Initial setup

cd D:\CK-Behav_pvt-200205-175423
tmplist = dir('D:\CK-Behav_pvt-200205-175423');
%% Collect alldata into one Structure
for i=3:length(tmplist)-1
    tmpname = strcat(tmplist(i).name(4:end-7));
    alldata(i-2).name = tmpname;
    tmpdata = TDTbin2mat(tmplist(i).name,'TYPE',{'epocs'});
    alldata(i-2).data = tmpdata.epocs;
end
% read from line 읽을 수 있는지 확인 - 850초 이하 분석에서 제외

%% Delete empty data from structure
emptyIndex = find(arrayfun(@(alldata) isempty(alldata.data),alldata));
alldata(emptyIndex) = [];
%% Find breaking points
for ii = 2:length(alldata)
    divider(ii) = convertCharsToStrings(alldata(ii-1).name(1:end-7)) == convertCharsToStrings(alldata(ii).name(1:end-7));
end
divind = find(divider==0);
divind = [1 divind length(alldata)];

%% lick number analysis
lickdata = [];
for ii = 1:length(divind)-1
    tmplick = length(alldata(divind(ii):divind(ii+1)).data.LICK.onset);
    lickdata = padcat(lickdata,tmplick);
end

%%
