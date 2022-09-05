function [Mdl, metric, model] = setup_and_run_model_training(schemefile, SNR, output_folder, Dsoma, Din_UB, Rsoma_UB, De_UB, seed, protocolname, figsfolder)

    rng(seed); % for reproducibility

    protocol = SchemeToProtocol(schemefile);

    % Calculates the roots for the calculation of the signal for diffusion restricted in spheres under GPD approximation 
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
    model.Nset = 1e5;

    save(fullfile(output_folder, 'model.mat'), 'model'); % Save the model used

    % Build the training set

    % contruimos un conjunto de datos de prueba
    rng(123) % for reproducibility
    [database_train, database_train_noisy, params_train] = build_training_set(model, output_folder);

    % contruimos un conjunto de datos de prueba
    rng(321) % for reproducibility
    [aux_database_train, aux_database_train_noisy, aux_params_train] = build_training_set(model, figsfolder);

    n_trees = 200;
    
    Mdl = train_RF_matlab(database_train_noisy, params_train, n_trees);
    
    MAE = [0,0,0,0,0];

    for i=1:5
        
        pred = predict(Mdl{i},aux_database_train_noisy);
        target = aux_params_train(:,i);
        
        if i == 1 || i == 2                
            pred = cos(pred).^2;
            target = cos(target).^2;
        end
        
        writematrix(pred, strcat(output_folder, num2str(i), '_pred_param.txt'));
        writematrix(target, strcat(output_folder, num2str(i), '_target_param.txt'));

        MAE(i) =  mean(abs(pred-target));
        fprintf("MAE %d : %f \n ", i, MAE(i));
        
    end
    
    metric = MAE(1)*0.35+MAE(2)*0.35+MAE(3)*0.1+MAE(4)*0.1+MAE(5)*0.1;
end
