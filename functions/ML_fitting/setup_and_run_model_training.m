function [Mdl, train_perf, metric, model] = setup_and_run_model_training(
    schemefile, 
    SNR, 
    output_folder, 
    Dsoma, 
    Din_UB, 
    Rsoma_UB, 
    De_UB, 
    seed, 
    MLmodel, 
    protocolname, 
    figsfolder)

addpath(genpath([pwd '/functions']));

rng(seed); % for reproducibility

protocol = SchemeToProtocol(schemefile);

display(protocol.pulseseq);
display(protocol.grad_dirs);
display(protocol.G);
display(protocol.delta);
display(protocol.smalldel);
display(protocol.TE);
display(protocol.totalmeas);

protocol.roots_sphere = BesselJ_RootsSphere(100); % Calculates the roots for the calculation of the signal for diffusion restricted in spheres under GPD approximation 


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

database_train_noisy = readmatrix('/home/alonso/randy/differential_evolution/data/database_train_noisy.txt');
database_train = readmatrix('/home/alonso/randy/differential_evolution/data/database_train.txt');
params_train = readmatrix('/home/alonso/randy/differential_evolution/data/params_train.txt');

aux_database_train_noisy = readmatrix('/home/alonso/randy/differential_evolution/data/aux_database_train_noisy.txt');
aux_database_train = readmatrix('/home/alonso/randy/differential_evolution/data/aux_database_train.txt');
aux_params_train = readmatrix('/home/alonso/randy/differential_evolution/data/aux_params_train.txt');


if isempty(MLmodel), MLmodel = 'RF'; end

switch MLmodel
    
    case 'RF'
        n_trees = 200;
        
        Mdl = train_RF_matlab(database_train_noisy, params_train, n_trees);
        train_perf = cell(5,1);
        
        error_relativo = [0,0,0,0,0];
        error_norma = [0,0,0,0,0];
        error = [0,0,0,0,0];
        for i=1:5
            
            pred = predict(Mdl{i},aux_database_train_noisy);
            target = aux_params_train(:,i);
            
            if i == 1 || i == 2                
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
        
        for i=1:5
            train_perf{i} = oobError(Mdl{i});
        end
        
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
        
    case 'MLP'
        n_layers = 3;
        n_neurons = 2*min(size(database_train,1),size(database_train,2));

        disp(['Training the MLP with ' num2str(n_layers) ' hidden layers and ' num2str(n_neurons) ' units per layer ...'])
        
        [Mdl, train_perf] = train_MLP_matlab(database_train_noisy, params_train, n_layers, n_neurons);
    case 'GRNN'
        Mdl = newgrnn(database_train', params_train', 1./model.SNR);
        train_perf = [];
end

end
