% Initial setup

cd D:\CK-Behav_pvt-200205-175423
tmplist = dir('D:\CK-Behav_pvt-200205-175423');
% cd D:\210603
% tmplist = dir('D:\210603');
%% Collect alldata into one Structure
for i=3:length(tmplist)-1
    try
        tmpname = strcat(tmplist(i).name(4:end-7));
        alldata(i-2).name = tmpname;
        tmpdata = TDTbin2mat(tmplist(i).name,'TYPE',{'epocs'});
        alldata(i-2).data = tmpdata.epocs;
    catch EX
        fprintf('Failed data extraction: %s\nErrorcode: %s\n',tmpname,EX.message);
        continue;
    end
end

%% Delete empty data from structure
emptyIndex = find(arrayfun(@(alldata) isempty(alldata.data),alldata));
alldata(emptyIndex) = [];
tooshort = [];
for ii = 1:length(alldata)
    try 
        if alldata(ii).data.Vid1.onset(end) < 850
            tooshort = [ii tooshort];
        end
    catch EX
        %continue;
    end
end
alldata(tooshort) = [];
deleteindex1 = ...
find(arrayfun(@(alldata) alldata.name(1:end-7)=="PostPVT8",alldata));
deleteindex2 = ...
find(arrayfun(@(alldata) alldata.name(1:end-7)=="pvtbehav2",alldata));
deleteindex3 = ...
find(arrayfun(@(alldata) alldata.name(1:end-7)=="PostPVT4",alldata));
wronglabel1 = find(arrayfun(@(alldata) alldata.name=="PostPVT1-201022",alldata));
wronglabel2 = find(arrayfun(@(alldata) alldata.name=="PostPVT3-201022",alldata));

deleteindex = [deleteindex1, deleteindex2, deleteindex3, wronglabel1, wronglabel2];
alldata(deleteindex) = [];
% name = "pvtbehav"

% name = "pst8"
% read from line 읽을 수 있는지 확인 - 850초 이하 분석에서 제외
% video input onset으로 구현 가능할듯?
%% Data labeling
% label alldata - robot, shuttle, train
% train - X attack, less than 7(?) trials
% shuttle - X attack
% robot - O attack
for i = 1:length(alldata)
    try
        if isfield(alldata(i).data,'ATTK')
            alldata(i).label = "robot";
        elseif length(alldata(i).data.TRON.onset) >7
            alldata(i).label = "shuttle";
        else 
            alldata(i).label = "train";
        end
    catch
        alldata(i).label = "train";
        continue;
    end
    
end
alldata(3).label = "train";
% ? fix this are u mad?
alldata(arrayfun(@(alldata) alldata.name=="PostPVT6-201023",alldata)).label = "shuttle";
%alldata(arrayfun(@(alldata) alldata.name=="PostPVT7-201216",alldata)).label = "shuttle";
 
alldata(arrayfun(@(alldata) alldata.name=="PostPVT10-201217",alldata)).label = "shuttle";
alldata(arrayfun(@(alldata) alldata.name=="PrePVT4-200813",alldata)).label = "robot";
alldata(arrayfun(@(alldata) alldata.name=="PrePVT4-200821",alldata)).label = "robot";
alldata(arrayfun(@(alldata) alldata.name=="PrePVT9-210128",alldata)).label = "robot";
%% Seperate & refine dataset
tmprobotdata = struct([]);
tmpshuttledata = struct([]);
tmptraindata = struct([]);

for i = 1:length(alldata)
    if alldata(i).label == "robot"
        tmprobotdata = [tmprobotdata alldata(i)];
    elseif alldata(i).label == "shuttle"
        tmpshuttledata = [tmpshuttledata alldata(i)];
    else
        tmptraindata = [tmptraindata alldata(i)];
    end
end
robotdata = struct([]);
shuttledata = struct([]);
traindata = struct([]);
for i = 1:length(tmprobotdata)
    try
        robotdata(i).name = tmprobotdata(i).name;
    catch ME
        fprintf('No data - name\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).BLON = tmprobotdata(i).data.BLON.onset;
    catch ME
        fprintf('No data - BLON\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).TRON = tmprobotdata(i).data.TRON.onset;
    catch ME
        fprintf('No data - TRON\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).IRON = tmprobotdata(i).data.IRON.onset;
    catch ME
        fprintf('No data - IRON\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).ATTK = tmprobotdata(i).data.ATTK.onset;
    catch ME
        fprintf('No data - ATT\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).LICK = tmprobotdata(i).data.LICK.onset;
    catch ME
        fprintf('No data - LICK\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).LOFF = tmprobotdata(i).data.LOFF.onset;
    catch ME
        fprintf('No data - LOFF\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).ATOF = tmprobotdata(i).data.ATOF.onset;
    catch ME
        fprintf('No data - ATOF\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).IROF = tmprobotdata(i).data.IROF.onset;
    catch ME
        fprintf('No data - IROF\nErrorcode: %s\n',ME.message);
    end
    try
        robotdata(i).TROF = tmprobotdata(i).data.TROF.onset;
    catch ME
        fprintf('No data - TROF\nErrorcode: %s\n',ME.message);
        robotdata(i).TROF = tmprobotdata(i).data.Vid1.onset(end);
    end
    try
        robotdata(i).BLOF = tmprobotdata(i).data.BLOF.onset;
    catch ME
        fprintf('No data - BROF\nErrorcode: %s\n',ME.message);
    end
end
for i = 1:length(tmpshuttledata)
    try
        shuttledata(i).name = tmpshuttledata(i).name;
    catch ME
        fprintf('No data - name\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).BLON = tmpshuttledata(i).data.BLON.onset;
    catch ME
        fprintf('No data - BLON\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).TRON = tmpshuttledata(i).data.TRON.onset;
    catch ME
        fprintf('No data - TRON\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).IRON = tmpshuttledata(i).data.IRON.onset;
    catch ME
        fprintf('No data - IRON\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).ATTK = tmpshuttledata(i).data.ATTK.onset;
    catch ME
        fprintf('No data - ATT\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).LICK = tmpshuttledata(i).data.LICK.onset;
    catch ME
        fprintf('No data - LICK\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).LOFF = tmpshuttledata(i).data.LOFF.onset;
    catch ME
        fprintf('No data - LOFF\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).ATOF = tmpshuttledata(i).data.ATOF.onset;
    catch ME
        fprintf('No data - ATOF\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).IROF = tmpshuttledata(i).data.IROF.onset;
    catch ME
        fprintf('No data - IROF\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).TROF = tmpshuttledata(i).data.TROF.onset;
    catch ME
        fprintf('No data - TROF\nErrorcode: %s\n',ME.message);
    end
    try
        shuttledata(i).BLOF = tmpshuttledata(i).data.BLOF.onset;
    catch ME
        fprintf('No data - BROF\nErrorcode: %s\n',ME.message);
    end
end
for i = 1:length(tmptraindata)
    try
        traindata(i).name = tmptraindata(i).name;
    catch ME
        fprintf('No data - name\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).BLON = tmptraindata(i).data.BLON.onset;
    catch ME
        fprintf('No data - BLON\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).TRON = tmptraindata(i).data.TRON.onset;
    catch ME
        fprintf('No data - TRON\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).IRON = tmptraindata(i).data.IRON.onset;
    catch ME
        fprintf('No data - IRON\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).ATTK = tmptraindata(i).data.ATTK.onset;
    catch ME
        fprintf('No data - ATT\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).LICK = tmptraindata(i).data.LICK.onset;
    catch ME
        fprintf('No data - LICK\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).LOFF = tmptraindata(i).data.LOFF.onset;
    catch ME
        fprintf('No data - LOFF\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).ATOF = tmptraindata(i).data.ATOF.onset;
    catch ME
        fprintf('No data - ATOF\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).IROF = tmptraindata(i).data.IROF.onset;
    catch ME
        fprintf('No data - IROF\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).TROF = tmptraindata(i).data.TROF.onset;
    catch ME
        fprintf('No data - TROF\nErrorcode: %s\n',ME.message);
    end
    try
        traindata(i).BLOF = tmptraindata(i).data.BLOF.onset;
    catch ME
        fprintf('No data - BROF\nErrorcode: %s\n',ME.message);
    end
end
clear tmprobotdata tmpshuttledata tmptraindata
%% Label all 3 datasets
for i = 1:length(robotdata)
    robotdata(i).label = robotdata(i).name(1:4);
    if or(robotdata(i).name(1:7) == "PrePVT5",robotdata(i).name(1:7) =="PrePVT6")
        robotdata(i).label = "PreS";
    elseif robotdata(i).name(1:8) == "PostPVT5"
        robotdata(i).label = "PreP";
    end
    if robotdata(i).label == "preP"
        robotdata(i).label = "PreP";
    end
end
for i = 1:length(shuttledata)
    shuttledata(i).label = shuttledata(i).name(1:4);
    if or(shuttledata(i).name(1:7) == "PrePVT5",shuttledata(i).name(1:7) =="PrePVT6")
        shuttledata(i).label = "PreS";
    elseif shuttledata(i).name(1:8) == "PostPVT5"
        shuttledata(i).label = "PreP";
    end
    if shuttledata(i).label == "preP"
        shuttledata(i).label = "PreP";
    end
end
for i = 1:length(traindata)
    traindata(i).label = traindata(i).name(1:4);
    if or(traindata(i).name(1:7) == "PrePVT5",traindata(i).name(1:7) =="PrePVT6")
        traindata(i).label = "PreS";
    elseif traindata(i).name(1:8) == "PostPVT5"
        traindata(i).label = "PreP";
    end
    if traindata(i).label == "preP"
        traindata(i).label = "PreP";
    end
end
%{
tmplabel1 = find(arrayfun(@(robotdata) robotdata.name(1:7)=="PrePVT5",robotdata));
tmplabel2 = find(arrayfun(@(robotdata) robotdata.name(1:7)=="PrePVT6",robotdata)); 
tmplabel3 = find(arrayfun(@(robotdata) robotdata.name(1:8)=="PostPVT5",robotdata));
tmplabel4 = find(arrayfun(@(shuttledata) shuttledata.name(1:8)=="PostPVT5",shuttledata));
tmplabel5 = find(arrayfun(@(shuttledata) shuttledata.name(1:8)=="PostPVT5",shuttledata));
tmplabel6 = find(arrayfun(@(shuttledata) shuttledata.name(1:8)=="PostPVT5",shuttledata));
tmplabel7 = find(arrayfun(@(traindata) traindata.name(1:8)=="PostPVT5",traindata));
tmplabel8 = find(arrayfun(@(traindata) traindata.name(1:8)=="PostPVT5",traindata));
tmplabel9 = find(arrayfun(@(traindata) traindata.name(1:8)=="PostPVT5",traindata));

relabel1 = [relabel1 relabel2 relabel3 relabel4 relabel5 relabel6];
relabel2 = [relabel7 relabel8 relabel9];
%}
pstrob = robotdata(arrayfun(@(robotdata) robotdata.label == "Post",robotdata));
prerob = robotdata(arrayfun(@(robotdata) robotdata.label == "PreP",robotdata));
preshrob = robotdata(arrayfun(@(robotdata) robotdata.label == "PreS",robotdata));
pstshrob = robotdata(arrayfun(@(robotdata) robotdata.label == "PstS",robotdata));

psttrain = traindata(arrayfun(@(traindata) traindata.label == "Post",traindata));
pretrain = traindata(arrayfun(@(traindata) traindata.label == "PreP",traindata));
preshtrain = traindata(arrayfun(@(traindata) traindata.label == "PreS",traindata));
pstshtrain = traindata(arrayfun(@(traindata) traindata.label == "PstS",traindata));

pstshtdate = [210115;210115;210427;210418;210417;210418;210423;210423;210423];
psttdate = [201024;201010;201024;0;0;201103;210112;0;210112;201231];

[pstshb4t, pstshaft] = b4aft(pstshrob, pstshtdate);
[pstb4t, pstaft] = b4aft(pstrob, psttdate);

%% Find breaking points
alldatadivind = div(alldata);
robotdatadivind = div(robotdata);
traindatadivind = div(traindata);

prerobdivind = div(prerob);
pstrobdivind = div(pstrob);

pretraindivind = div(pretrain);
psttraindivind = div(psttrain);

preshrobdivind = div(preshrob);
pstshrobdivind = div(pstshrob);
 
preshtraindivind = div(preshtrain);
pstshtraindivind = div(pstshtrain);

pstshb4tdivind = div(pstshb4t);
pstshaftdivind = div(pstshaft);
pstb4tdivind = div(pstb4t);
pstaftdivind = div(pstaft);

%% lick number analysis - need correction according to each seperated dataset

longest = max(alldatadivind(2:end) - alldatadivind(1:end-1)); 

all_rawlick = nan(length(alldatadivind),longest);      % creating NAN array with enough size
all_rawtrial = nan(length(alldatadivind),longest);
all_rawtime = nan(length(alldatadivind),longest);

for ii = 1:length(alldatadivind)-1     % for each subject
    lck = [];   % initialize the lick count on each session
    iter = 1;   % initialize the count of total sessions of a subject
    trl = [];
    for iii = alldatadivind(ii):alldatadivind(ii+1)-1     % for each session of a subject
        try 
            lck = length(alldata(iii).data.LICK.onset);     % extract exact # of licks 
        catch MEL
            fprintf('LICK - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MEL.message);       % if error occurs, tell me where and what 
            lck = 0;
            %continue;   % then just skip that session
        end
        try
            trl = length(alldata(iii).data.TRON.onset);
        catch MET
            fprintf('TRIAL - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,MET.message);
            trl = 0;
            %continue;
        end
        try
            tim = sum(alldata(iii).data.LOFF.onset-alldata(iii).data.LICK.onset);
        catch METI
            fprintf('LICK Time - Failed iteration: session %i of subject # %i\nErrorcode: %s\n',iter,ii,METI.message);
            tim = 0;
            %continue;
        end
        all_rawtime(ii,iter) = tim;
        all_rawtrial(ii,iter) = trl;
        all_rawlick(ii,iter) = lck;     % record the # of licks on the right subject and session
        iter = iter+1;      % next session
   end
end
all_rawlick = all_rawlick';
all_rawtime = all_rawtime';
all_rawtrial = all_rawtrial';

[pstrob_rawlick,pstrob_rawtime,pstrob_rawtrial] = basicanalysis(pstrobdivind, pstrob);
[prerob_rawlick,prerob_rawtime,prerob_rawtrial] = basicanalysis(prerobdivind, prerob);
[psttrain_rawlick,psttrain_rawtime,psttrain_rawtrial] = basicanalysis(psttraindivind, psttrain);
[pretrain_rawlick,pretrain_rawtime,pretrain_rawtrial] = basicanalysis(pretraindivind, pretrain);

[pstshrob_rawlick,pstshrob_rawtime,pstshrob_rawtrial] = basicanalysis(pstshrobdivind, pstshrob);
[preshrob_rawlick,preshrob_rawtime,preshrob_rawtrial] = basicanalysis(preshrobdivind, preshrob);
[pstshtrain_rawlick,pstshtrain_rawtime,pstshtrain_rawtrial] = basicanalysis(pstshtraindivind, pstshtrain);
[preshtrain_rawlick,preshtrain_rawtime,preshtrain_rawtrial] = basicanalysis(preshtraindivind, preshtrain);

[pstb4t_rawlick,pstb4t_rawtime,pstb4t_rawtrial] = basicanalysis(pstb4tdivind, pstb4t);
[pstaft_rawlick,pstaft_rawtime,pstaft_rawtrial] = basicanalysis(pstaftdivind, pstaft);
[pstshb4t_rawlick,pstshb4t_rawtime,pstshb4t_rawtrial] = basicanalysis(pstshb4tdivind, pstshb4t);
[pstshaft_rawlick,pstshaft_rawtime,pstshaft_rawtrial] = basicanalysis(pstshaftdivind, pstshaft);

% Lick, trof 같은거 없으면 공란으로 남기고 넘어가도록
% 지금은 아예 없어짐
% 해결

%% Graph the licks

%% Graph the trials

%% Graph the licktime

%% Graph the escape / avoidance strip / ir 2 atk latency / ir# - only use robot

[pstavesc, pstir2atk, pstirnum, pstiti] = avesc(pstrob_rawtrial,pstrob);
[preavesc, preir2atk, preirnum, preiti] = avesc(prerob_rawtrial,prerob);
 
[pstshavesc, pstshir2atk, pstshirnum, pstshiti] = avesc(pstshrob_rawtrial,pstshrob);
[preshavesc, preshir2atk, preshirnum, preshiti] = avesc(preshrob_rawtrial,preshrob);

[pstshb4tavesc,pstshb4tir2atk,pstshb4tirnum,pstshb4titi] = avesc(pstshb4t_rawtrial, pstshb4t);
[pstshaftavesc,pstshaftir2atk,pstshaftirnum,pstshaftiti] = avesc(pstshaft_rawtrial, pstshaft);

[pstb4tavesc,pstb4tir2atk,pstb4tirnum,pstb4titi] = avesc(pstb4t_rawtrial, pstb4t);
[pstaftavesc,pstaftir2atk,pstaftirnum,pstaftiti] = avesc(pstaft_rawtrial, pstaft);

%% ttest


%% Graph first 5min licks pre vs pst vs sh
%[prerob_min5lick,prerob_min5time,prerob_min5trial] = minanal(prerobdivind,prerob,5);
%[pstrob_min5lick,pstrob_min5time,pstrob_min5trial] = minanal(pstrobdivind,pstrob,5);

%[preshrob_min5lick,preshrob_min5time,preshrob_min5trial] = minanal(preshrobdivind,preshrob,5);
%[pstshrob_min5lick,pstshrob_min5time,pstshrob_min5trial] = minanal(pstshrobdivind,pstshrob,5);

%% Graph the trial open~first lick latency
prerob_latencymat = lick1latency(prerob_rawtrial,prerob)*-1;
pstrob_latencymat = lick1latency(pstrob_rawtrial,pstrob)*-1;

preshrob_latencymat = lick1latency(preshrob_rawtrial,preshrob)*-1;
pstshrob_latencymat = lick1latency(pstshrob_rawtrial,pstshrob)*-1;

%% inter-IR interval


%% 
