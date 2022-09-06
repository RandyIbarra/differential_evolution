% ref https://www.sciencedirect.com/science/article/pii/0004370295001247

% si n = 2, entonces el minimo es (1,1)

% x in [-2.048, 2.047]
function [metric] = f_rosenbrock(x)
    metric = 0.0;

    n = length(x);
    for i=1:(n / 2)
        metric = metric + 100*(x(2*i-1)^2 - x(2*i))^2 + (x(2*i-1) - 1)^2;
    end
end

%{
dimension = 4;

n_iterations = 10;    % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;   % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_rosenbrock
lower_b = [-2.048, -2.048, -2.048, -2.048];
upper_b = [ 2.047,  2.047,  2.047,  2.047];

>> differential_evolution_test
    1.2883   -1.4026    0.6373    0.8433
    1.6612    1.9266   -1.9018   -1.9176
   -1.5280    1.8716    1.4292   -0.9140
    1.6923   -0.0604    1.7767   -1.8589
    0.5415    1.2291    0.7314   -1.6502
   -1.6486   -1.4670    1.0549    1.3241
   -0.9075   -0.3209    0.9951    0.7973
    0.1915    1.7019   -0.4418   -0.7495
    1.8730    1.1961    0.6362    1.8432
    1.9032    1.8811   -1.3470   -1.9069

Elapsed time is 0.001403 seconds.
Elapsed time is 0.000817 seconds.
Elapsed time is 0.002004 seconds.
Elapsed time is 0.000388 seconds.
Elapsed time is 0.000668 seconds.
Elapsed time is 0.000024 seconds.
Elapsed time is 0.000031 seconds.
Elapsed time is 0.000360 seconds.
Elapsed time is 0.000015 seconds.
Elapsed time is 0.000006 seconds.
GENERATION (1)
f_time: 0.000560
f_time: 0.000369
f_time: 0.000074
f_time: 0.000186
f_time: 0.000641
f_time: 0.000009
f_time: 0.000007
f_time: 0.000006
f_time: 0.000006
f_time: 0.000005
END (1)
time: 0.013324
GENERATION (2)
f_time: 0.000006
f_time: 0.000006
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000007
END (2)
time: 0.001790
GENERATION (3)
f_time: 0.000006
f_time: 0.000008
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
END (3)
time: 0.002740
GENERATION (4)
f_time: 0.000006
f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000007
f_time: 0.000008
f_time: 0.000006
f_time: 0.000006
END (4)
time: 0.001640
GENERATION (5)
f_time: 0.000008
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
new solution
  777.1499

   -0.8443   -0.0604    1.7767    5.8275

f_time: 0.000008
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
END (5)
time: 0.003149
GENERATION (6)
f_time: 0.000007
f_time: 0.000006
f_time: 0.000006
new solution
  753.8997

   -1.0884    2.9264    1.4292    4.1544

f_time: 0.000007
new solution
   76.8209

   -0.8443   -0.0604   -2.3833    5.8275

f_time: 0.000007
f_time: 0.000007
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000007
END (6)
time: 0.002809
GENERATION (7)
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000006
f_time: 0.000004
END (7)
time: 0.001377
GENERATION (8)
f_time: 0.000002
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000004
END (8)
time: 0.000699
GENERATION (9)
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
END (9)
time: 0.000673
GENERATION (10)
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000003
f_time: 0.000002
f_time: 0.000003
f_time: 0.000003
END (10)
time: 0.000637
function calls
   110

best solution
   76.8209

   -0.8443   -0.0604   -2.3833    5.8275

>>
%}