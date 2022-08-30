function [metric] = objective_function(protocol)
    %metric = dot(protocol, protocol);
    Dsoma =  3; 
    Din_UB =  3; 
    Rsoma_UB = 12; 
    De_UB = 3; 
    seed_rng = 1; 
    MLmodel = 'RF'; 

    protocolname = 'protocol';
    schemefile = fullfile(pwd, 'protocols/Acq_Params/diravg.scheme');
    bvalues_filename = fullfile(pwd, 'protocols/protocol.bval');
    outputfolder = fullfile(pwd, 'protocols/Acq_Params/');
    figsfolder = fullfile(pwd, 'protocols/figs/');

    % write bvals into file
    [fid,msg] = fopen(bvalues_filename,'wt');
    assert(fid>=3,msg);
    fprintf(fid,'%d ', protocol(1:(length(protocol) - 2)));
    fclose(fid);
    % save DELTA and delta
    tau = protocol(length(protocol) - 1);
    smalldelta = protocol(length(protocol));
    delta = tau + (smalldelta / 3.0);  
    SNR = 10000;

    load_acquisition_parameters(bvalues_filename, delta, smalldelta, outputfolder); 
    
    [Mdl, train_perf, metric] = setup_and_run_model_training(schemefile, SNR, outputfolder, Dsoma, Din_UB, Rsoma_UB, De_UB, seed_rng, MLmodel, protocolname, figsfolder);
end

