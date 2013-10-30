function [ newHistogram ] = histogramGenerate(buckets)

newHistogram = zeros(1, 9);

for j = 1 : length(buckets)

    for i = 1 : length(buckets)

        value = buckets(i,j);
        
        newHistogram(1,value + 1) = newHistogram(1,value + 1) + 1;
    end
end

newHistogram = normr(double(newHistogram));

end
