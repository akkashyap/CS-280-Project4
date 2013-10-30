function [ angle ] = findGradient( dx, dy )

height = size(dx,1);
width = size(dx,2);


angle = ones(height, width); 
magnitude = ones(height, width);

for i = 1:height
    for j = 1:width
        singleDX = dx(i,j);
        singleDY = dy(i,j);
        if singleDX == 0 && singleDY == 0
            angle(i,j) = 0;
        else
            angle(i,j) = atand(singleDY/ singleDX); %atan for radians. To get degrees use atand. straing atan2
        end
        magnitude(i,j) = sqrt( singleDX^2 + singleDY^2);
    end
end

%ROUNDING FOR DIRECTION  Bound between - 90 and 90. 
%add 90 bound between 0 and 180.
% Divde by 20 and floor
for i = 1:height
    for j = 1:width
        oldValue = angle(i,j);
        oldValue = abs(double(oldValue + 89.9999));
        oldValue = oldValue / 20.0;
        oldValue = floor(oldValue);
        angle(i,j) = oldValue;
    end
end

angle = uint8(angle);

end

