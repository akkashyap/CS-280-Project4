function [ feature ] = generatePatchSum(c, patch )

    [h, w] = size(patch);

    stepFunction = floor(c/2);
    
    counter = 0;
        
    feature = [];
    
    if c == 7
       feature = zeros(64,1); 
    end
    
    if c == 4
       feature = zeros(169,1); 
    end
    
    for j = 1:stepFunction:h-c+1
    
        for i=1:stepFunction:w-c+1

            counter = counter + 1;
            
            tile = patch(i:i+c-1, j:j+c-1);

            feature(counter, 1) = sum(sum(tile));
            
        end
    
    end

end
