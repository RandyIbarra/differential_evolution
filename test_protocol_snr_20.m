clc;
addpath(genpath(fullfile(pwd, 'test_functions')));
addpath(genpath(fullfile(pwd, 'functions')));

% parametros conocidos
dimension = 7; % 6 o 7 dependiendo numero de shells

n_iterations = 10;       % n_iterations
population_size = 20; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

lower_b  = [600.00, 600.00, 600.00, 600.00, 600.00, 10,  3 ];
upper_b = [5000.0, 5000.0, 5000.0, 5000.0, 5000.0, 20, 15];

population = init_protocols_5shells();

fprintf('protocols\n');

[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_protocol_snr_20, n_iterations, diff_weight, cross_prob);