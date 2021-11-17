function  tmpvec = ocilpatorg2(avesc,group,divind)
    tmpvec = [];

    session_num = diff(divind);
    startidx = divind(1:end-1);
    subject_num = length(startidx);
for i = 1:subject_num
    rawarray = avesc(:,startidx(i):startidx(i)+session_num(i));
    arraysize = size(rawarray);
    
    for ii = 1:arraysize(2)
        tmpvect = rawarray(:,ii);    
        tmpvect(isnan(tmpvect)) = [];
        
        
        previousevent = cumsum((tmpvect-1)*-1);
        % Originally, 1 = avoidance, 0 = escape
        % but to count with cumsum, had to reverse the signs
        % this is to count, so it has no effect on the 1st and original
        % response
        
        previousevent = [0; previousevent];
        previousevent(end) = [];
        %find how many zeros have been here before
        
        tmpvect(:,2) = group;
        tmpvect(:,3) = 1:length(tmpvect(:,1));
        tmpvect(:,4) = ii;
        tmpvect(:,5) = subject_num;
        tmpvect(:,6) = previousevent;
        tmpvec = [tmpvec; tmpvect];
    end   
end
end
