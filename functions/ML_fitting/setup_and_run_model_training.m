function [Mdl, train_perf, metric, model] = setup_and_run_model_training(schemefile, SNR, output_folder, Dsoma, Din_UB, Rsoma_UB, De_UB, seed, MLmodel, protocolname, figsfolder)

% Main script to setup and train the Random
% Forest (RF) or multi-layers perceptron (MLP) regressors used to fit the
% SANDI model
%
% Author:
% Dr. Marco Palombo
% Cardiff University Brain Research Imaging Centre (CUBRIC)
% Cardiff University, UK
% 8th December 2021
% Email: palombom@cardiff.ac.uk

addpath(genpath([pwd '/functions']));

rng(seed); % for reproducibility
%mkdir(output_folder); % create the output folder

protocol = SchemeToProtocol(schemefile);

%display(figsfolder);
%display(protocolname);

%% Load data

% Protocol definition
protocol.roots_sphere = BesselJ_RootsSphere(100); % Calculates the roots for the calculation of the signal for diffusion restricted in spheres under GPD approximation 

%% Build the model and the corresponding training set

% Build the SANDI model to fit (as in the Neuroimage 2020) using the parameter transformation introduced in
% doi:10.1016/j.neuroimage.2011.09.081 to ensure that the three signal fractions
% sum up to unity.

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
[database_train, database_train_noisy, params_train] = build_training_set(model, output_folder);

% contruimos un conjunto de datos de prueba
rng(123) % for reproducibility
[aux_database_train, aux_database_train_noisy, aux_params_train] = build_training_set(model, figsfolder);

%disp('Training will be performed with:')
%disp(['   - Dsoma = ' num2str(Dsoma) ' um^2/ms'])
%disp(['   - Rsoma = [' num2str(model.paramsrange(4,1)) ', ' num2str(model.paramsrange(4,2)) '] um'])
%disp(['   - De = [' num2str(model.paramsrange(5,1)) ', ' num2str(model.paramsrange(5,2)) '] um^2/ms'])
%disp(['   - Din = [' num2str(model.paramsrange(3,1)) ', ' num2str(model.paramsrange(3,2)) '] um^2/ms'])

if isempty(MLmodel), MLmodel = 'RF'; end

switch MLmodel
    
    case 'RF'
        %% RF train
        
        %disp('Training using a Random Forest regressor implemented in matlab ')
        
        % --- Using Matlab
        n_trees = 200;
        %disp(['Training the Random Forest with ' num2str(n_trees) ' trees ...'])
        
        Mdl = train_RF_matlab(database_train_noisy, params_train, n_trees);
        train_perf = cell(5,1);
        
        error_relativo = [0,0,0,0,0];
        error_norma = [0,0,0,0,0];
        error = [0,0,0,0,0];
        for i=1:5
            
            pred = predict(Mdl{i},aux_database_train_noisy);
            target = aux_params_train(:,i);
            
            if i == 1 || i == 2
                
                %fprintf("param index = %d,     relative_error = %.03f\n", i,mean(abs(pred-target)./target));
                %fprintf("param index = %d,     MSE = %.03f\n\n", i,dot((pred-target),(pred-target))/length((pred-target)));
                
                pred = cos(pred).^2;
                target = cos(target).^2;
            end
            
            error_relativo(i) =  mean(abs(pred-target)./target);
            error(i) =  dot((pred-target),(pred-target))/length((pred-target));
            
            pred = (pred - model.paramsrange(i,1)) / (model.paramsrange(i,2) - model.paramsrange(i,1));
            target = (target - model.paramsrange(i,1)) / (model.paramsrange(i,2) - model.paramsrange(i,1));
            
            error_norma(i) = dot((pred-target),(pred-target))/length((pred-target));
            
        end 
        
        metric = error(1)*0.35+error(2)*0.35+error(3)*0.1+error(4)*0.1+error(5)*0.1;
        %{
        fprintf("\nf_in:   ---> MSE = %.03f    ----    %.03f\n", error(1), (error(1) - model.paramsrange(1,1)) / (model.paramsrange(1,2) - model.paramsrange(1,1)));
        fprintf("f_ec:   ---> MSE = %.03f    ----    %.03f\n", error(2), (error(2) - model.paramsrange(2,1)) / (model.paramsrange(2,2) - model.paramsrange(2,1)));
        fprintf("D_in:   ---> MSE = %.03f    ----    %.03f\n", error(3), (error(3) - model.paramsrange(3,1)) / (model.paramsrange(3,2) - model.paramsrange(3,1)));
        fprintf("r_s :   ---> MSE = %.03f    ----    %.03f\n", error(4), (error(4) - model.paramsrange(4,1)) / (model.paramsrange(4,2) - model.paramsrange(4,1)));
        fprintf("D_ec:   ---> MSE = %.03f    ----    %.03f\n\n", error(5), (error(5) - model.paramsrange(5,1)) / (model.paramsrange(5,2) - model.paramsrange(5,1)));


        fprintf("f_in:   ---> relativ_err = %.03f\n", error_relativo(1));
        fprintf("f_ec:   ---> relativ_err = %.03f\n", error_relativo(2));
        fprintf("D_in:   ---> relativ_err = %.03f\n", error_relativo(3));
        fprintf("r_s :   ---> relativ_err = %.03f\n", error_relativo(4));
        fprintf("D_ec:   ---> relativ_err = %.03f\n\n", error_relativo(5));
        
        fprintf("\nf_in:   ---> error_normalizado = %.03f\n", error_norma(1));
        fprintf("f_ec:   ---> error_normalizado = %.03f\n", error_norma(2));
        fprintf("D_in:   ---> error_normalizado = %.03f\n", error_norma(3));
        fprintf("r_s :   ---> error_normalizado = %.03f\n", error_norma(4));
        fprintf("D_ec:   ---> error_normalizado = %.03f\n\n", error_norma(5));
        %}
        
        for i=1:5
            train_perf{i} = oobError(Mdl{i});
        end
        %{
        fprintf("f_in:   ---> mean(WMSE_tree) = %.03f    ----    %.03f\n", mean(train_perf{1}),  (mean(train_perf{1}) - model.paramsrange(1,1)) / (model.paramsrange(1,2) - model.paramsrange(1,1)));
        fprintf("f_ec:   ---> mean(WMSE_tree) = %.03f    ----    %.03f\n", mean(train_perf{2}),  (mean(train_perf{2}) - model.paramsrange(2,1)) / (model.paramsrange(2,2) - model.paramsrange(2,1)));
        fprintf("D_in:   ---> mean(WMSE_tree) = %.03f    ----    %.03f\n", mean(train_perf{3}),  (mean(train_perf{3}) - model.paramsrange(3,1)) / (model.paramsrange(3,2) - model.paramsrange(3,1)));
        fprintf("r_s :   ---> mean(WMSE_tree) = %.03f    ----    %.03f\n", mean(train_perf{4}),  (mean(train_perf{4}) - model.paramsrange(4,1)) / (model.paramsrange(4,2) - model.paramsrange(4,1)));
        fprintf("D_ec:   ---> mean(WMSE_tree) = %.03f    ----    %.03f\n", mean(train_perf{5}),  (mean(train_perf{5}) - model.paramsrange(5,1)) / (model.paramsrange(5,2) - model.paramsrange(5,1)));
        %}
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pred_1 = cos(predict(Mdl{1},aux_database_train_noisy)).^2;
        target_1 = cos(aux_params_train(:,1)).^2;

        pred_2 = cos(predict(Mdl{2},aux_database_train_noisy)).^2;
        target_2 = cos(aux_params_train(:,2)).^2;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        pred_3 = predict(Mdl{3},aux_database_train_noisy);
        target_3 = aux_params_train(:,3);

        pred_4 = predict(Mdl{4},aux_database_train_noisy);
        target_4 = aux_params_train(:,4);

        pred_5 = predict(Mdl{5},aux_database_train_noisy);
        target_5 = aux_params_train(:,5);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        error_abs_1 = abs(target_1 - pred_1);
        error_abs_2 = abs(target_2 - pred_2);
        error_abs_3 = abs(target_3 - pred_3);
        error_abs_4 = abs(target_4 - pred_4);
        error_abs_5 = abs(target_5 - pred_5);
        %{
        writetable(array2table(error_abs_1),[figsfolder 'abs_error_1.csv']);
        writetable(array2table(error_abs_2),[figsfolder 'abs_error_2.csv']);
        writetable(array2table(error_abs_3),[figsfolder 'abs_error_3.csv']);
        writetable(array2table(error_abs_4),[figsfolder 'abs_error_4.csv']);
        writetable(array2table(error_abs_5),[figsfolder 'abs_error_5.csv']);

        writetable(array2table(pred_1),[figsfolder 'pred_1.csv']);
        writetable(array2table(pred_2),[figsfolder 'pred_2.csv']);
        writetable(array2table(pred_3),[figsfolder 'pred_3.csv']);
        writetable(array2table(pred_4),[figsfolder 'pred_4.csv']);
        writetable(array2table(pred_5),[figsfolder 'pred_5.csv']);
        
        writetable(array2table(target_1),[figsfolder 'target_1.csv']);
        writetable(array2table(target_2),[figsfolder 'target_2.csv']);
        writetable(array2table(target_3),[figsfolder 'target_3.csv']);
        writetable(array2table(target_4),[figsfolder 'target_4.csv']);
        writetable(array2table(target_5),[figsfolder 'target_5.csv']);
       
        close all;
        % save([output_folder '/trained_RFmodel.mat'], 'Mdl', '-v7.3')
        %}
    case 'MLP'
        %% MLP train
        
        disp('Training using a MLP regressor implemented in matlab ')
        
        % --- Using Matlab
        n_layers = 3;
        n_neurons = 2*min(size(database_train,1),size(database_train,2));

        disp(['Training the MLP with ' num2str(n_layers) ' hidden layers and ' num2str(n_neurons) ' units per layer ...'])
        
        [Mdl, train_perf] = train_MLP_matlab(database_train_noisy, params_train, n_layers, n_neurons);
        
        fprintf("f_in:   ---> best_tperf = %.03f\n", train_perf{1}.best_tperf);
        fprintf("f_ec:   ---> best_tperf = %.03f\n", train_perf{2}.best_tperf);
        fprintf("D_in:   --->  best_tperf = %.03f\n", train_perf{3}.best_tperf);
        fprintf("r_s :   ---> best_tperf = %.03f\n", train_perf{4}.best_tperf);
        fprintf("D_ec:   ---> best_tperf = %.03f\n", train_perf{5}.best_tperf);
        % save([output_folder '/trained_MLPmodel.mat'], 'Mdl', '-v7.3')

    case 'GRNN'
        %% GRNN setup
        
        disp('Training using a Generalized Regression Neural Network implemented in matlab ')
        
        % --- Using Matlab
        
        disp('Training the Generalized Regression Neural Network...')
        Mdl = newgrnn(database_train', params_train', 1./model.SNR);
        train_perf = [];
end

end
