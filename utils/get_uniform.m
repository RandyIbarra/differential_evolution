% returns a colum vector or a single scalar with uniform distribution in (l_b, u_b)
function random_number = get_uniform(lower_b, upper_b)
    if length(lower_b) ~= length(upper_b)
        fprintf("length is not the same \n");
    end
    if size(lower_b, 1) == 1
        lower_b = lower_b';
        upper_b = upper_b';
    end
    random_number = lower_b+(upper_b - lower_b).*rand(length(upper_b), 1);
end