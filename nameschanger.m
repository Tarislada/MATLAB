cd 'C:\Users\Chang Ko\Documents\gradebook_20202R0136PSYC21600_Homework20_220FraidyRat_2020-12-28-11-57-48';
target = dir('*Homework*');
n = length(target);

for ii = 1:n
    newname = strcat(target(ii).name(23:32),'_',target(ii).name(57:end))
    movefile(target(ii).name,newname);
end