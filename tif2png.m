foldername = 'D:\Brain pictures\CK-PVT';
imglist = dir (foldername);
newdir = 'D:\Brain pictures\test1';
for ii = 3:length(imglist)
   targetfile = strcat(foldername,'\',imglist(ii).name);
   tmpimg = imread(targetfile);
   newname = imglist(ii).name(1:end-4);
   newname(9) = 's';
   newname = strcat(newname,'.png');
   imwrite(tmpimg,strcat(newdir,'\',newname));   
end
