% Script for extracting Data from Arduino Serial
% 2020-01-22
% Chang Ko
% 수정사항 - if 문 분기
% licktrain - shuttle - robot - Test

%% Load folder & Get file
currfolder = uigetdir();
filelists = dir(currfolder);
%filecounts = nnz(count(string(filelists),'txt'));
%% Main Phase
lickdata = NaN(4,length(3:length(filelists)));
ltimedata = NaN(4,length(3:length(filelists)));
for i = 3:length(filelists)
    rawdata = textread((filelists(i).name),'%s','delimiter','\n');
    blockst = find(contains(rawdata,'Block started'));
    blockend = find(contains(rawdata,'Block ended'));
    trialst = find(contains(rawdata,'trial : '));
    trialcount = zeros(length(blockst),1);
    lickcount = [];
    datarray = NaN(50,length(blockst));
%% Get lick time 
    lck = find(contains(rawdata,'Lick Time :'));
    lcktime = regexp(rawdata(lck),'\d*','match');
    lcktime = str2double(cat(1,lcktime{:}));
    
    aclick = find(contains(rawdata,'Total Licks :'));
    exactlicks = regexp(rawdata(aclick),'\d*','match');
    exactlicks = str2double(cat(1,exactlicks{:}));
%% Count trials in blocks
    for ii = 1:length(blockst)
        trinbls = blockst(ii)<trialst & trialst<blockend(ii);
        trialcount(ii) = sum(trinbls);
        lickcount = ones(trialcount(ii),1);
%% Count licks in trials
        for iii = 1:trialcount(ii)-1
            tmp = trialst(trinbls);
            lcheck = rawdata(tmp(iii):tmp(iii+1));
            lickcount(iii) = sum(~cellfun(@isempty,regexp(lcheck,'^\d+$')))*10;
        end
        datarray(1:length(lickcount),ii) = lickcount;
        
    end       
    lickdata(1:length(exactlicks),i-2) = exactlicks;
    ltimedata(1:length(lcktime),i-2) = lcktime;
end
% Bug: 한 블락 안에 트라이얼이 하나만 있을때, trialcount(ii)-1 = 0이 되어 포문이 돌아가지 않음

