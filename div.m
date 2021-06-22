%% A fuction to find the breaking point between subjects
% input needs to be a structure w. field name 'name' in it right under
function divind = div(structure);
    divind = [];
    divider = [];
    for ii = 2:length(structure)
        divider(ii) = convertCharsToStrings(structure(ii-1).name(1:end-7))...
            == convertCharsToStrings(structure(ii).name(1:end-7));
    end
    divind = find(divider==0);
    divind = [divind length(structure)];
    
end
