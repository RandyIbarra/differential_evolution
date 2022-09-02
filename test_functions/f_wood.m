% ref https://pythonhosted.org/algopy/examples/minimization/wood_function_minimization.html
% optimo en [1,1,1,1]

function [metric] = f_wood(x)
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);
    metric = 100*(x1*x1 - x2)^2;
    metric = metric + (x1-1)^2;
    metric = metric + (x3-1)^2;
    metric = metric + 90*(x3*x3 - x4)^2;
    metric = metric + 10.1*((x2-1)^2 + (x4-1)^2);
    metric = metric + 19.8*(x2-1)*(x4-1);

%{
dimension = 4;

n_iterations = 10;    % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;   % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_wood
lower_b = [-3.0, -3.0, -3.0, -3.0];
upper_b = [ 3.0,  3.0,  3.0,  3.0];

>> differential_evolution_test
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

Elapsed time is 0.000889 seconds.
Elapsed time is 0.000189 seconds.
Elapsed time is 0.000260 seconds.
Elapsed time is 0.000281 seconds.
Elapsed time is 0.001559 seconds.
Elapsed time is 0.000015 seconds.
Elapsed time is 0.000007 seconds.
Elapsed time is 0.000006 seconds.
Elapsed time is 0.000007 seconds.
Elapsed time is 0.000005 seconds.
GENERATION (1)
f_time: 0.000334
f_time: 0.000062
f_time: 0.000062
f_time: 0.000184
f_time: 0.000553
f_time: 0.000007
new solution
   6.4483e+03

   -2.4148   -2.1487    1.5464    1.9407

f_time: 0.000007
f_time: 0.000005
f_time: 0.000006
f_time: 0.000005
END (1)
time: 0.010959
GENERATION (2)
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000008
f_time: 0.000009
f_time: 0.000006
f_time: 0.000006
new solution
  798.2350

    0.2813    2.4944   -0.6466   -1.0974

f_time: 0.000006
f_time: 0.000007
END (2)
time: 0.003018
GENERATION (3)
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
new solution
  605.4418

   -1.3290   -0.4694    1.4588    1.1690

f_time: 0.000004
f_time: 0.000003
f_time: 0.000003
END (3)
time: 0.002436
GENERATION (4)
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000004
f_time: 0.000003
f_time: 0.000003
END (4)
time: 0.000806
GENERATION (5)
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000004
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
END (5)
time: 0.001374
GENERATION (6)
f_time: 0.000003
f_time: 0.000005
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000005
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
END (6)
time: 0.001439
GENERATION (7)
f_time: 0.000005
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000005
f_time: 0.000006
END (7)
time: 0.001413
GENERATION (8)
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000006
END (8)
time: 0.001363
GENERATION (9)
f_time: 0.000005
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000006
END (9)
time: 0.001374
GENERATION (10)
f_time: 0.000006
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
f_time: 0.000005
f_time: 0.000006
f_time: 0.000005
f_time: 0.000005
f_time: 0.000006
f_time: 0.000005
END (10)
time: 0.001364
function calls
   110

best solution
  605.4418

   -1.3290   -0.4694    1.4588    1.1690

>> 
%}