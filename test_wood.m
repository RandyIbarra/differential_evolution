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

population = init_random(dimension, population_size, lower_b, upper_b);

fprintf('wood\n');

[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_wood, n_iterations, diff_weight, cross_prob);

%{
    1.8883   -2.0543    0.9344    1.2363
    2.4348    2.8236   -2.7857   -2.8090
   -2.2381    2.7430    2.0948   -1.3385
    2.4803   -0.0877    2.6040   -2.7230
    0.7942    1.8017    1.0724   -2.4172
   -2.4148   -2.1487    1.5464    1.9407
   -1.3290   -0.4694    1.4588    1.1690
    0.2813    2.4944   -0.6466   -1.0974
    2.7450    1.7532    0.9329    2.7013
    2.7893    2.7570   -1.9729   -2.7933

wood

n iterations: 1000
diff_weight: 1.500000
cross_prob: 0.500000

number of function calls: 10010

 function calls time average: 6.061538e-06 

 optimal value: 0.078357 

 optiml agent
    0.9181    0.8489    1.0914    1.2081

population
    1.8883   -2.0543    0.9344    1.2363
    1.0238    0.9926    1.0141    1.0040
    1.2389    1.5278    0.6444    0.4328
    1.0756    1.1268    0.9699    0.9723
    0.8760    0.7639    1.0914    1.2081
    1.1186    1.2380    0.8589    0.7653
    1.1558    1.3200    0.8774    0.7506
    1.2454    1.5606    0.7594    0.5813
    1.2377    1.5056    0.6149    0.3933
    1.2735    1.6172    0.6572    0.4116
%}