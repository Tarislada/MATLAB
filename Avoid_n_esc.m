currfolder = uigetdir();
datamatrix = BehavDataParser(currfolder);

numtrial = length(datamatrix);
initavesc = zeros(numtrial,1);
finalavesc = zeros(numtrial,1);
numhesi = zeros(numtrial,1);
trdur = zeros(numtrial,1);

for ii = 1:numtrial
    if isempty(datamatrix{ii,2}) || isempty(datamatrix{ii,4})
        continue
    else
        initavesc(ii) = datamatrix{ii,2}(1,2) < datamatrix{ii,4}(2);
        finalavesc(ii) = datamatrix{ii,2}(end,2) < datamatrix{ii,4}(2);
        numhesi(ii) = length(datamatrix{ii,2});
        trdur(ii) = datamatrix{ii,1}(2) - datamatrix{ii,1}(1);
    end
end

hesidata = [trdur, numhesi, initavesc, finalavesc];
hesidata(~any(hesidata,2),:) = [];
matname = erase(currfolder(66:end),'\');
matname = strcat('C:\Users\Chang Ko\Documents\Research\Behavior&lesion\Study 1\Data','\',matname);
csvwrite(matname,hesidata)
hesidata