%{
check total # of trials

all instances where initial irof is earlier than att = avoidance1
all instances where initial irof is later than att = escape1

all instances where final irof is earlier than att = avoidance 2
all instances where final irof is later after att = escape 2

how many times did rat enter & exit during a trial
how long did each trial take (hesitate to enter)
need: 
  - trof: # of trials, check interval for selecting final exit and entry
  - irof & att: avoidance & escape
%}

%% Import files
datalist = ["ATTK.csv","IROF.csv","TROF.csv","TRON.csv"];
currfolder = uigetdir();
tmp = cell(1,4);
for ii = 1:length(datalist)
    location = strcat(currfolder, '\*',datalist(ii));
    targetfile = dir(location);
    filename = targetfile.name;
    if targetfile.bytes ==0 
        continue
    else
        tmp{ii} = csvread(strcat(currfolder,'\',filename),1,2);
    end 
end
%% Name Datasets
atdata = tmp{1};
irdata = tmp{2};
trofdata = tmp{3};
trondata = tmp{4};
numtrial = length(trofdata);
%% Refine data    
atdata = atdata(:,1);
atdata2 = atdata(:,1);
irdata = irdata(:,1);
trofdata = trofdata(:,1);
trondata = trondata(:,1);
trdata = [trondata(:,1), trofdata(:,1), trofdata(:,1)-trondata(:,1)];
%% Trial & attack validity check
trdeleter = [];
atdeleter = [];
for ii = 1:numtrial
    %need to use while or other forms of loop so i don't have to specify
    %how many times the loop has to loop
    trat = atdata((trondata(ii)<atdata) & (atdata<trofdata(ii)));
    if isempty(trat)
        %trdata(ii,:) = [];
        trdeleter = [trdeleter, ii];
    elseif length(trat) > 1
        %atdata2(ismember(atdata,trat(2:end))) = [];
        atdeleter = [atdeleter; trat(2:end)];
    end 
    % need a condition that checks whether the trial is valid
    % Valid meaning there was at least one attack during trial
    % also, that attack cannot be manual, so
    % check for attack within a trial 
    % if there is no attack, that trial needs to go away
    % if there are more than 1 attack, delete others and only let 
    % the initial attack survive.
end
trdata(trdeleter,:) = [];
atdata(ismember(atdata,atdeleter))=[];
numtrial = length(trdata);
trdur = trdata(:,3);

%% Initial & final exit av/esc
initavesc = zeros(numtrial,1);
finavesc = zeros(numtrial,1);
numhesi = zeros(numtrial,1);
for ii = 1:numtrial
    trir = irdata(trondata(ii)<irdata & irdata<trofdata(ii));
    if isempty(trir)
        continue
    else
        initavesc(ii) = trir(1)<atdata(ii);
        finavesc(ii) = trir(end)<atdata(ii);
        numhesi(ii) = length(trir);
    end
    % 1 = avoidance, 0 = escape
end
datamatrix = [trdur, numhesi, initavesc, finavesc];
matname = erase(currfolder(66:end),'\');
matname = strcat('C:\Users\Chang Ko\Documents\Research\Behavior&lesion\Study 1\Data','\',matname);
csvwrite(matname,datamatrix)