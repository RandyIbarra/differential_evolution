% ref https://www.sciencedirect.com/science/article/pii/0004370295001247

% x in [-5.12, 5.11]
function [metric] = f_cos(x)
    n = length(x);

    metric = n * 10.0;
    for i=1:n
        metric = metric + x(i)^2  - 10*cos(2*pi*x(i));
    end
end