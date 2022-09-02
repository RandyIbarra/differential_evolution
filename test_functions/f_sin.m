% ref https://www.sciencedirect.com/science/article/pii/0004370295001247

% x in [-512, 511]
function [metric] = f_sin(x)
    metric = 0.0;

    n = length(x);
    for i=1:n
        metric = metric + (-x(i))*sin(sqrt(abs(x(i))));
    end
end