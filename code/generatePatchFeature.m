function [ feature ] = generatePatchFeature(c, patch )

    cols = double(im2col(patch, [c,c] , 'distinct')); % each column is a patch
    feature= sum(cols)'; %Returns a column vector of features

end

