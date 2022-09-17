function [database_train_noisy, database_test_noisy, params_train, params_test] = generate_train_test_sets(protocol_folder_abs_path, schemefile, Nset, snr)

    % SANDI conventions
    Dsoma = 3; 
    De_UB = 3;
    Din_UB = 3; 
    Rsoma_UB = 12;

    % Calculates the roots for the calculation of the signal for diffusion restricted in spheres under GPD approximation 
    protocol = SchemeToProtocol(schemefile);
    protocol.roots_sphere = BesselJ_RootsSphere(100);

    % SANDI model function
    f = @(p,prot) (cos(p(1)).^2).*SynthMeasAstroSticks(p(3).*1e-9,prot)' + ...
                  (1 - (cos(p(1)).^2) - ((1-(cos(p(1)).^2)).*cos(p(2)).^2)).*SynthMeasSphere([Dsoma.*1e-9 p(4).*1e-6],prot)' + ...
                  ((1-(cos(p(1)).^2)).*cos(p(2)).^2).*SynthMeasBall(p(5).*1e-9,prot)';

    % Build model
    model = struct;
    model.protocol = protocol;
    model.noise = 'gaussian'; %'gaussian' to add Gaussian noise; 'rician' to add Rician noise
    model.paramsrange = [0 1; 0 1; Dsoma/12 Din_UB; 1 Rsoma_UB; Dsoma/12 De_UB];
    model.Nparams = size(model.paramsrange,1);
    model.function = f;
    model.SNR = snr;
    model.Nset = Nset;
    save([protocol_folder_abs_path '/model.mat'], 'model');

    % Build the training set
    rng(123) % for reproducibility
    [database_train, database_train_noisy, params_train] = build_training_set(model, protocol_folder_abs_path);
    save([protocol_folder_abs_path '/database_training_set'], 'database_train_noisy', 'database_train', 'params_train');

    % Build the testing set
    rng(321) % for reproducibility
    [database_test, database_test_noisy, params_test] = build_training_set(model, protocol_folder_abs_path);
    save([protocol_folder_abs_path '/database_testing_set'], 'database_test_noisy', 'database_test', 'params_test');
end