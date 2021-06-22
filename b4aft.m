function [b4t,aft] = b4aft(structure, tdate)
%structure = pstrob;
b4tidx = [];
aftidx = [];
for i = 1:length(structure)
    if isempty(str2num(structure(i).name(8:9))) 
        subjectidx = str2num(structure(i).name(8:8));
    else
        subjectidx = str2num(structure(i).name(8:9));
    end
    if str2num(structure(i).name(end-5:end)) < tdate(subjectidx)
%     if str2num(structure(i).name(end-5:end)) < tdate(i)
        
        b4tidx = [b4tidx;i];
    else
        aftidx = [aftidx;i];
    end
    
end    
b4t = structure(b4tidx);
aft = structure(aftidx);
% use regular expression next time - 1 or 2 char before dash
% PostPVT / Pstsham 