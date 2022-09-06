function [lower_b, upper_b] = boundaries_rosenbrock(dimension)
    lower_b = repmat( -2.048, [1,dimension] );
    upper_b = repmat(  2.047, [1,dimension] );
end