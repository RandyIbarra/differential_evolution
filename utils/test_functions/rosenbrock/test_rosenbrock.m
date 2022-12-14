clc;
addpath(genpath(fullfile(pwd, 'test_functions')));

dimension = 7;

n_iterations = 1000;       % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_rosenbrock
lower_b = [-2.048, -2.048, -2.048, -2.048, -2.048, -2.048, -2.048];
upper_b = [ 2.047,  2.047,  2.047,  2.047,  2.047,  2.047,  2.047];

population = init_random(dimension, population_size, lower_b, upper_b);

fprintf('rosenbrock\n');

[optimal_agent, optimal_value, f_time] = differential_evolution(population, @f_rosenbrock, n_iterations, diff_weight, cross_prob);

%{
    1.2883   -1.4026    0.6373    0.8433   -0.2513   -0.9177    1.0284
    1.6612    1.9266   -1.9018   -1.9176   -0.4855    0.7354   -1.0034
   -1.5280    1.8716    1.4292   -0.9140    1.0868    0.6346    0.0239
    1.6923   -0.0604    1.7767   -1.8589    1.2083   -1.3821    0.8147
    0.5415    1.2291    0.7314   -1.6502   -1.2828   -1.5607    1.6002
   -1.6486   -1.4670    1.0549    1.3241   -0.0424   -0.0072    1.8803
   -0.9075   -0.3209    0.9951    0.7973   -0.2233    1.8822    0.1928
    0.1915    1.7019   -0.4418   -0.7495    0.5987   -0.6541   -1.4803
    1.8730    1.1961    0.6362    1.8432    0.8568    0.3487   -1.4366
    1.9032    1.8811   -1.3470   -1.9069    1.0424   -1.1315   -0.9935

rosenbrock

n iterations: 1000
diff_weight: 1.500000
cross_prob: 0.500000

number of function calls: 10010
Function call time 0.000000 sec.

First function value: 1054.850733 

 function calls time average: 5.915285e-06 

 optimal value: 4.348082 

 optiml agent
   1.0e+03 *

    0.0023    0.0054   -0.0009    0.0008    0.0009    0.0007    2.4400

population
   1.0e+03 *

    0.0013   -0.0014    0.0006    0.0008   -0.0003   -0.0009    0.0010
    0.0029    0.0079    0.0014    0.0017    0.0002    0.0000    1.2813
   -0.0017    0.0032    0.0024    0.0057    0.0000    0.0001   -0.7769
   -0.0007    0.0009    0.0012    0.0014   -0.0001   -0.0003   -3.4873
    0.0005    0.0005   -0.0006    0.0004    0.0007    0.0007   -3.8625
    0.0016    0.0025   -0.0009    0.0008    0.0008    0.0007    2.4400
    0.0027    0.0068   -0.0005    0.0002    0.0003   -0.0001   -7.7096
    0.0023    0.0050    0.0017    0.0029    0.0014    0.0018   -6.0465
    0.0012    0.0012    0.0010    0.0011    0.0005    0.0005   -3.6440
    0.0023    0.0054    0.0010    0.0009    0.0014    0.0019   -3.3352
%}