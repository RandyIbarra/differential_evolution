clc;
addpath(genpath(fullfile(pwd, 'test_functions')));

dimension = 7;

n_iterations = 10;       % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_sum
lower_b = [-5.12, -5.12, -5.12, -5.12, -5.12, -5.12, -5.12];
upper_b = [ 5.11,  5.11,  5.11,  5.11,  5.11,  5.11,  5.11];

population = init_random(dimension, population_size, lower_b, upper_b);

fprintf('sum\n');

[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_sum, n_iterations, diff_weight, cross_prob);