function  tmpvec = ocilpatorg(rawarray,group,subjectnum)
    arraysize = size(rawarray);
    tmpvec = [];
    for ii = 1:arraysize(2)
        tmpvect = rawarray(:,ii);    
        tmpvect(isnan(tmpvect)) = [];
        tmpvect(tmpvect==0)=[];
        
        tmpvect(:,2) = group;
        tmpvect(:,3) = 1:length(tmpvect(:,1));
        tmpvect(:,4) = ii;
        tmpvect(:,5) = subjectnum;
        tmpvec = [tmpvec; tmpvect];
    end   
end