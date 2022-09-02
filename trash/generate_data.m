clc;

addpath(genpath(fullfile(pwd, '/functions')));

bvalues_filename = fullfile(pwd, '/data/protocol.bval');

smalldelta = 9;
delta = 23;
SNR = 20.0;

Dsoma =  3; 
Din_UB =  3; 
Rsoma_UB = 12; 
De_UB = 3;

output_folder = fullfile(pwd, 'data/Acq_Params_5/');

% function that loads and saves the acquisition parameters in the file ~/Acq_Params/diravg.scheme
load_acquisition_parameters(bvalues_filename, delta, smalldelta, output_folder);

schemefile = fullfile(pwd, 'data/Acq_Params_5/diravg.scheme');

protocol = SchemeToProtocol(schemefile);
protocol.roots_sphere = BesselJ_RootsSphere(100);

f = @(p,prot) (cos(p(1)).^2).*SynthMeasAstroSticks(p(3).*1e-9,prot)' + ...
              (1 - (cos(p(1)).^2) - ((1-(cos(p(1)).^2)).*cos(p(2)).^2)).*SynthMeasSphere([Dsoma.*1e-9 p(4).*1e-6],prot)' + ...
              ((1-(cos(p(1)).^2)).*cos(p(2)).^2).*SynthMeasBall(p(5).*1e-9,prot)';

model = struct;
model.protocol = protocol;
model.noise = 'gaussian'; %'gaussian' to add Gaussian noise; 'rician' to add Rician noise
model.paramsrange = [0 1; 0 1; Dsoma/12 Din_UB; 1 Rsoma_UB; Dsoma/12 De_UB];
model.Nparams = size(model.paramsrange,1);
model.function = f;
model.SNR = SNR;
model.Nset = 5;

% Build the training set
rng(123) % for reproducibility
[database_train, database_train_noisy, params_train] = build_training_set(model, output_folder);

writematrix(database_train_noisy,'data/Acq_Params_5/database_train_noisy_5.txt');
writematrix(database_train,'data/Acq_Params_5/database_train_5.txt');
writematrix(params_train,'data/Acq_Params_5/params_train_5.txt');