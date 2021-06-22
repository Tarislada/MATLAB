function refinedmat = nanoutliers(targetarray)
refinedmat = reshape(targetarray, [1 numel(targetarray)]);
[~,outlierindex] = rmoutliers(refinedmat);
refinedmat(outlierindex) = NaN;
refinedmat = reshape(refinedmat, size(targetarray));
end
