clc;
addpath(genpath(fullfile(pwd, 'test_functions')));

dimension = 4;

n_iterations = 1000;       % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_wood
lower_b = [-3.0, -3.0, -3.0, -3.0];
upper_b = [ 3.0,  3.0,  3.0,  3.0];

population = random_init(dimension, population_size, lower_b, upper_b);

fprintf('wood\n');

[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_wood, n_iterations, diff_weight, cross_prob);