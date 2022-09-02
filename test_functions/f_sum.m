% ref https://www.sciencedirect.com/science/article/pii/0004370295001247

% x in [-5.12, 5.11]
function [metric] = f_sum(x)
    metric = dot(floor(x), ones(size(x)));
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

Elapsed time is 0.000025 seconds.
Elapsed time is 0.000012 seconds.
Elapsed time is 0.000014 seconds.
Elapsed time is 0.000012 seconds.
Elapsed time is 0.000011 seconds.
Elapsed time is 0.000011 seconds.
Elapsed time is 0.000011 seconds.
Elapsed time is 0.000011 seconds.
Elapsed time is 0.000010 seconds.
Elapsed time is 0.000010 seconds.
GENERATION (1)
f_time: 0.000010
f_time: 0.000009
f_time: 0.000009
new solution
     0

   -3.8209    4.6718    3.5666   -2.2871

f_time: 0.000009
new solution
     2

    4.2238   -0.1546    4.4348   -4.6477

f_time: 0.000009
new solution
     0

    1.3490    3.0669    1.8235   -4.1263

f_time: 0.000008
new solution
    -4

   -4.1222   -3.6685    2.6317    3.3040

f_time: 0.000009
new solution
    -1

   -2.2710   -0.8054    2.4822    1.9881

f_time: 0.000009
new solution
     0

    0.4746    4.2480   -1.1075   -1.8761

f_time: 0.000009
f_time: 0.000008
new solution
    -1

    4.7508    4.6956   -3.3688   -4.7676

END (1)
time: 0.001484
GENERATION (2)
f_time: 0.000013
f_time: 0.000013
new solution
    -2

    4.1463    4.8092   -4.7547   -4.7943

f_time: 0.000013
new solution
    -7

   11.8817    4.6718   -6.9530  -14.2599

f_time: 0.000013
f_time: 0.000016
new solution
   -38

    1.3490  -31.0575    5.8620  -11.7698

f_time: 0.000017
f_time: 0.000017
new solution
   -14

   28.0941   -0.8054  -20.4505  -19.1860

f_time: 0.000014
new solution
    -4

    0.4746   -5.6445    4.4307   -1.8761

f_time: 0.000014
f_time: 0.000013
END (2)
time: 0.001955
GENERATION (3)
f_time: 0.000014
f_time: 0.000013
f_time: 0.000013
f_time: 0.000013
new solution
   -21

   -3.6805  -15.3823    4.4348   -4.6477

f_time: 0.000014
f_time: 0.000013
f_time: 0.000014
new solution
   -44

 -158.7802   -0.8054  110.6478    6.9356

f_time: 0.000014
new solution
   -91

 -124.4883   32.2217    4.4307   -1.8761

f_time: 0.000014
new solution
     0

  -24.0401    2.9843   16.5906    7.3275

f_time: 0.000016
new solution
   -21

  -59.9619    4.6956   40.1343   -4.7676

END (3)
time: 0.002076
GENERATION (4)
f_time: 0.000013
new solution
     2

    3.2146   -3.5076    1.5882    2.1029

f_time: 0.000013
new solution
    -2

  -53.0668   15.3713   42.8329   -4.7943

f_time: 0.000013
f_time: 0.000012
f_time: 0.000013
f_time: 0.000013
f_time: 0.000016
new solution
  -123

 -221.7353   24.0059   72.3977    3.9633

f_time: 0.000017
new solution
  -600

 -600.1809   -0.9468    4.4307   -1.8761

f_time: 0.000016
new solution
  -148

 -145.5560  -44.3478   16.5906   27.8588

f_time: 0.000018
new solution
   -58

  -59.9619  -32.0787   40.1343   -4.7676

END (4)
time: 0.002294
GENERATION (5)
f_time: 0.000017
f_time: 0.000016
new solution
  -739

 -812.3316   15.3713   25.3691   34.9562

f_time: 0.000017
new solution
   -22

  -93.9489    4.6718   65.3365    3.0427

f_time: 0.000016
f_time: 0.000016
f_time: 0.000016
new solution
   -13

   -4.1222  -12.7616    2.6317    3.3040

f_time: 0.000017
f_time: 0.000016
f_time: 0.000015
f_time: 0.000015
END (5)
time: 0.002173
GENERATION (6)
f_time: 0.000015
new solution
  -393

 -472.6381   12.9360   66.3017    2.1029

f_time: 0.000013
f_time: 0.000012
f_time: 0.000012
f_time: 0.000012
f_time: 0.000013
f_time: 0.000012
new solution
       -1113

   1.0e+03 *

   -1.0817    0.0240   -0.0573    0.0040

f_time: 0.000013
f_time: 0.000013
f_time: 0.000012
new solution
       -2715

   1.0e+03 *

   -2.8899   -0.0321    0.1821    0.0269

END (6)
time: 0.001504
GENERATION (7)
f_time: 0.000012
f_time: 0.000012
new solution
       -1755

   1.0e+03 *

   -1.9111    0.1050    0.1094   -0.0561

f_time: 0.000013
f_time: 0.000013
f_time: 0.000013
f_time: 0.000012
f_time: 0.000012
new solution
       -4528

   1.0e+03 *

   -4.7411    0.2693   -0.0573    0.0040

f_time: 0.000013
new solution
  -604

 -600.1809   -0.9468    4.4307   -5.2753

f_time: 0.000012
new solution
       -1705

   1.0e+03 *

   -1.7845    0.0626    0.0166    0.0022

f_time: 0.000013
END (7)
time: 0.001743
GENERATION (8)
f_time: 0.000013
new solution
       -2779

   1.0e+03 *

   -2.8247    0.1216   -0.0760    0.0021

f_time: 0.000013
new solution
       -4626

   1.0e+03 *

   -4.7857    0.1050    0.1094   -0.0533

f_time: 0.000013
f_time: 0.000009
f_time: 0.000009
new solution
  -104

  102.1735  -46.9358  -78.0476  -79.8588

f_time: 0.000009
new solution
  -184

   -4.1222   37.5078 -196.5200  -18.8855

f_time: 0.000009
f_time: 0.000008
new solution
       -5432

   1.0e+03 *

   -5.4287    0.0762    0.0044   -0.0828

f_time: 0.000009
new solution
       -6945

   1.0e+03 *

   -6.5446    0.2295   -0.6306    0.0022

f_time: 0.000009
END (8)
time: 0.001695
GENERATION (9)
f_time: 0.000013
f_time: 0.000013
f_time: 0.000014
f_time: 0.000013
f_time: 0.000014
f_time: 0.000013
f_time: 0.000014
f_time: 0.000013
new solution
       -6263

   1.0e+03 *

   -5.4287   -0.6930    0.0044   -0.1439

f_time: 0.000018
f_time: 0.000016
new solution
       -6234

   1.0e+03 *

   -5.1105    0.0240   -1.5906    0.4454

END (9)
time: 0.001726
GENERATION (10)
f_time: 0.000017
new solution
       -3369

   1.0e+03 *

   -2.8247    0.1216   -0.6669    0.0021

f_time: 0.000018
new solution
       -8847

   1.0e+03 *

   -9.0165    0.5281   -0.5835    0.2264

f_time: 0.000018
f_time: 0.000017
f_time: 0.000017
new solution
      -10445

   1.0e+03 *

   -9.9743    0.4521   -1.0253    0.1041

f_time: 0.000018
new solution
       -3973

   1.0e+03 *

   -4.2943   -0.2769    0.8745   -0.2740

f_time: 0.000018
new solution
       -4741

   1.0e+03 *

   -4.7411    0.2693   -0.2707    0.0040

f_time: 0.000018
new solution
      -11105

   1.0e+04 *

   -1.0732   -0.0693    0.1494   -0.1171

f_time: 0.000018
f_time: 0.000017
END (10)
time: 0.002488
function calls
   110

best solution
      -11105

   1.0e+04 *

   -1.0732   -0.0693    0.1494   -0.1171

>> 
%}