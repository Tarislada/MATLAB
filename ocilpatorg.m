function  tmpvec = ocilpatorg(rawarray,group,subjectnum)
    arraysize = size(rawarray);
    tmpvec = [];
    for ii = 1:arraysize(2)
        tmpvect = rawarray(:,ii);    
        tmpvect(isnan(tmpvect)) = [];
        %tmpvect(tmpvect==0)=[]; % this line is to delete erroneous 0s.
        %include if the raw array is ir2atk time, exclude if it is binary
        %avoid/escape pattern
        
        previousevent = cumsum((tmpvect-1)*-1);
        previousevent = [0; previousevent];
        previousevent(end) = [];
        %find how many zeros have been here before
        
        tmpvect(:,2) = group;
        tmpvect(:,3) = 1:length(tmpvect(:,1));
        tmpvect(:,4) = ii;
        tmpvect(:,5) = subjectnum;
        tmpvect(:,6) = previousevent;
        tmpvec = [tmpvec; tmpvect];
    end   
end