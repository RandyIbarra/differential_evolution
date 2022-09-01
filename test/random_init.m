function population = random_init(dim, pop_size, lower_b, upper_b)
    rng('default');
    population = zeros(pop_size, dim, 'double');
    for i=1:dim
    	% each row is a subject
        population(:, i) = lower_b(i) + (upper_b(i) - lower_b(i)) * rand(pop_size, 1);
    end 
    disp(population);
end