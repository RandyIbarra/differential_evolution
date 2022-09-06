function population = init_random(dim, pop_size, lower_b, upper_b)
    % set seed to random numbers
    rng('default');
    % each row will be a subject: population is a matrix of <pop_size>-by-<problem_dimension>
    population = zeros(pop_size, dim, 'double');
    for i=1:dim
        % Generate a <population_size>-by-1 column vector of unif. dist. numbers in (lower_b,upper_b).
        population(:, i) = lower_b(i) + (upper_b(i) - lower_b(i)) * rand(pop_size, 1);
    end 
    % each row is a subject
    fprintf("initial population \n");
    disp(population);
end