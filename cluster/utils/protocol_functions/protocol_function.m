function [metric] = protocol_function(protocol)

    addpath(genpath(fullfile(pwd, 'utils')));

    protocols_folder_path = fullfile(pwd, 'protocols/');
    if ~exist(protocols_folder_path, 'dir')
        mkdir(protocols_folder_path);
    end

    % snr as INB data with 8 averages
    snr = 16.05;
    Nset = 10;

    [bvals, tau, delta, smalldelta] = split_protocol(protocol);

    metric = realmax;
    protocolname = generate_protocol_name(bvals, tau, delta, snr);

    protocol_folder_abs_path = fullfile(protocols_folder_path, protocolname);

    if exist(protocol_folder_abs_path, 'dir')
        fprintf('Protocol has been evaluated: %s \n', protocolname);
    else

        fprintf('\n\n Protocol Name : %s \n\n', protocolname);

        mkdir(protocol_folder_abs_path);

        bvalues_file_path = fullfile(protocol_folder_abs_path, 'protocol.bval');
        schemefile = fullfile(protocol_folder_abs_path, 'diravg.scheme');

        generate_bval_file(bvals, bvalues_file_path);   

        load_acquisition_parameters(bvalues_file_path, delta, smalldelta, protocol_folder_abs_path); 
        
        [database_train_noisy, database_test_noisy, params_train, params_test] = generate_train_test_sets(protocol_folder_abs_path, schemefile, Nset, snr);
        
        starttime = tic;
        [Mdl, metric] = fitting(protocol_folder_abs_path, database_train_noisy, database_test_noisy, params_train, params_test);
        endtime = toc(starttime);
        
        writematrix(metric, fullfile(protocol_folder_abs_path, 'metric.txt'));
        writematrix(endtime, fullfile(protocol_folder_abs_path, 'time.txt'));
    end
end

