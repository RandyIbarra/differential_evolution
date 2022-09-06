clc;
addpath(genpath(fullfile(pwd, 'utils')));

% differential evolution parameters
dimension = 4;

n_iterations = 10;       % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

%% TESTING FUNCTIONS

% get boundaries of function to test
[lower_b, upper_b] = boundaries_rosenbrock(dimension);
% initial population: each "entry vector" came from a Unif[lower_b, upper_b]
population = init_random(dimension, population_size, lower_b, upper_b);
% search solution
[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_rosenbrock, n_iterations, diff_weight, cross_prob, lower_b, upper_b);