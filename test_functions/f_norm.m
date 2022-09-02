% ref https://www.sciencedirect.com/science/article/pii/0004370295001247

% x in [-5.12, 5.11]
function [metric] = f_norm(x)
    metric = dot(x, x);
end

%{

dimension = 4;

n_iterations = 10;    % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;   % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_sum, f_norm, 
lower_b = [-5.12, -5.12, -5.12, -5.12];
upper_b = [ 5.11,  5.11,  5.11,  5.11];

 >> differential_evolution_test
    3.2146   -3.5076    1.5882    2.1029
    4.1463    4.8092   -4.7547   -4.7943
   -3.8209    4.6718    3.5666   -2.2871
    4.2238   -0.1546    4.4348   -4.6477
    1.3490    3.0669    1.8235   -4.1263
   -4.1222   -3.6685    2.6317    3.3040
   -2.2710   -0.8054    2.4822    1.9881
    0.4746    4.2480   -1.1075   -1.8761
    4.6753    2.9843    1.5855    4.6008
    4.7508    4.6956   -3.3688   -4.7676

Elapsed time is 0.000014 seconds.
Elapsed time is 0.000006 seconds.
Elapsed time is 0.000006 seconds.
Elapsed time is 0.000005 seconds.
Elapsed time is 0.000007 seconds.
Elapsed time is 0.000006 seconds.
Elapsed time is 0.000005 seconds.
Elapsed time is 0.000005 seconds.
Elapsed time is 0.000005 seconds.
Elapsed time is 0.000005 seconds.
GENERATION (1)
f_time: 0.000005
f_time: 0.000007
f_time: 0.000008
f_time: 0.000007
f_time: 0.000006
f_time: 0.000009
f_time: 0.000011
f_time: 0.000011
f_time: 0.000011
f_time: 0.000011
END (1)
time: 0.001672
GENERATION (2)
f_time: 0.000012
f_time: 0.000012
f_time: 0.000013
f_time: 0.000012
f_time: 0.000013
f_time: 0.000012
f_time: 0.000014
f_time: 0.000015
f_time: 0.000013
f_time: 0.000014
END (2)
time: 0.002430
GENERATION (3)
f_time: 0.000015
f_time: 0.000009
f_time: 0.000009
f_time: 0.000013
f_time: 0.000015
f_time: 0.000014
f_time: 0.000014
f_time: 0.000014
f_time: 0.000014
f_time: 0.000011
END (3)
time: 0.002285
GENERATION (4)
f_time: 0.000014
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000010
f_time: 0.000009
END (4)
time: 0.001595
GENERATION (5)
f_time: 0.000009
f_time: 0.000010
f_time: 0.000011
f_time: 0.000011
f_time: 0.000007
f_time: 0.000007
f_time: 0.000010
f_time: 0.000010
f_time: 0.000010
f_time: 0.000010
END (5)
time: 0.002012
GENERATION (6)
f_time: 0.000027
f_time: 0.000005
f_time: 0.000005
f_time: 0.000007
f_time: 0.000006
new solution
   31.5773

    1.3490    3.0669    1.8235   -4.1263

f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
END (6)
time: 0.002018
GENERATION (7)
f_time: 0.000006
f_time: 0.000007
f_time: 0.000006
f_time: 0.000008
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000007
END (7)
time: 0.001174
GENERATION (8)
f_time: 0.000005
f_time: 0.000004
f_time: 0.000005
f_time: 0.000006
f_time: 0.000006
f_time: 0.000007
f_time: 0.000013
f_time: 0.000013
f_time: 0.000012
f_time: 0.000013
END (8)
time: 0.001611
GENERATION (9)
f_time: 0.000013
new solution
   20.9749

    3.3170    0.0157    2.3559    2.1029

f_time: 0.000013
f_time: 0.000013
f_time: 0.000012
f_time: 0.000013
f_time: 0.000006
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000007
END (9)
time: 0.002860
GENERATION (10)
f_time: 0.000013
f_time: 0.000008
f_time: 0.000012
f_time: 0.000010
f_time: 0.000009
f_time: 0.000010
f_time: 0.000010
f_time: 0.000010
f_time: 0.000010
f_time: 0.000010
END (10)
time: 0.001786
function calls
   110

best solution
   20.9749

    3.3170    0.0157    2.3559    2.1029

>>    
%}