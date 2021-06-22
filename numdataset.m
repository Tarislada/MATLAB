% check folder
currfolder = uigetdir();
location = strcat(currfolder, '\*.png');
filelist = ls(location);
dataset = zeros(length(filelist),28*28+1);
labelset = zeros(length(filelist),10);
% bring file
for ii = 1:length(filelist)
    tmp = strcat(currfolder,'\',filelist(ii,:));        % check file name 
    targetim = imread(tmp);
    if size(targetim,1) ~=28 || size(targetim,2)~=28    % check file size (28x28)
        targetim = imresize(targetim,[28 28]);
    end
    targetim = targetim(:,:,1);
    tempvect = targetim(:);
    label = str2num(filelist(ii,1));
    tempvect = [label,tempvect'];                       % label the file
    dataset(ii,:) = tempvect;                           % save to the matrix
end
csvwrite('handwritingdata.csv',dataset)
