%{
what I need to show
possible changes in:
  - average trial duration
  - average number of entries into the zone
  - initial based app/avo rate
  - final based app/avo rate

  - pattern of duration change
  - pattern of entry number change
  - group of 3 initial & final avoidance rate(?)
    : how early/rate did escape happen
%}
currfolder = uigetdir();
files = dir(currfolder);
hesimean = [];
for ii = 1:length(files)-2
    targetcsv = csvread(strcat(currfolder,'\',files(ii+2).name));
    hesimean = [hesimean; mean(targetcsv)];
end
hesimean = hesimean';