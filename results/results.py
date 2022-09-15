
#
# Average function call time in first population 338.000000 sec.
#

# 10 ITERATIONS
# 20 population_size

results = {
    "richer": 0.4130,
    "mgh": 0.4380,
    "clinical": 0.4773,
    "other": 0.4474,
    "inb": 0.5060, 
    "5-shells": 0.450692, # [1,2,3,4,5]*1e3, DELTA = 25, delta = 15
    "5-shells": 0.449855 , # [1,2,3,4,5]*1e3, DELTA = 21, delta = 13
    "optimal": 0.441691, # 1.0000    1.1550    4.3402    3.2500    4.6501    0.0200    0.0135
}


# time in generation (1): 3366.299374
# time in generation (2): 3345.244757
#
#
# time in generation (10): 3355.782403



>> f_protocol_snr_20([1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 17.67, 13], 'richer')
f_protocol_snr_20([1000, 3000, 5000, 10000, 17.67, 13], 'mgh')
f_protocol_snr_20([500, 750, 1200, 1500, 2000, 2500, 17.67, 13], 'clinical')
f_protocol_snr_20([1000, 2500, 4000, 5500, 7000, 18.33, 5], 'other')
f_protocol_snr_20([670, 1250, 2010, 8, 3], 'inb')


 protocolname : richer 

DONE - Training set built in 10 sec.
DONE - Training set built in 10 sec.

ans =

    0.4130



 protocolname : mgh 

DONE - Training set built in 8 sec.
DONE - Training set built in 8 sec.

ans =

    0.4380



 protocolname : clinical 

DONE - Training set built in 9 sec.
DONE - Training set built in 9 sec.

ans =

    0.4773



 protocolname : other 

DONE - Training set built in 8 sec.
DONE - Training set built in 9 sec.

ans =

    0.4474



 protocolname : inb 

DONE - Training set built in 8 sec.
DONE - Training set built in 8 sec.

ans =

    0.5060

IdleTimeout has been reached.
Parallel pool using the 'local' profile is shutting down.
>> f_protocol_snr_20([1000, 20, 15], 'oneshell')


 protocolname : oneshell 

Starting parallel pool (parpool) using the 'local' profile ...
Connected to the parallel pool (number of workers: 8).
DONE - Training set built in 34 sec.
DONE - Training set built in 6 sec.

ans =

    0.5701

IdleTimeout has been reached.
Parallel pool using the 'local' profile is shutting down.
>> 