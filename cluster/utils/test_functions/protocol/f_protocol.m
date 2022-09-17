function [metric] = f_protocol(protocol)

    % sort b-values
    protocol(1:(length(protocol) - 2)) = sort(protocol(1:(length(protocol) - 2)));

    % snr as INB data with 8 averages
    SNR = 16.05;

    protocolname = generate_protocol_name(protocol, SNR);
    fprintf('\n\n protocolname : %s \n\n', protocolname);

    Dsoma =  3; 
    Din_UB =  3; 
    Rsoma_UB = 12; 
    De_UB = 3; 
    seed_rng = 1; 

    schemefile = fullfile(pwd, ['protocols/' protocolname '/Acq_Params/diravg.scheme']);
    bvalues_filename = fullfile(pwd, ['protocols/' protocolname '/protocol.bval']);
    outputfolder = fullfile(pwd, ['protocols/' protocolname '/Acq_Params/']);
    figsfolder = fullfile(pwd, ['protocols/' protocolname '/figs/']);
    mkdir(outputfolder);
    mkdir(figsfolder);

    % write bvals into file
    [fid,msg] = fopen(bvalues_filename,'wt');
    assert(fid>=3,msg);
    fprintf(fid,'%.02f ', protocol(1:(length(protocol) - 2)));
    fclose(fid);
    % save DELTA and delta
    tau = protocol(length(protocol) - 1);
    smalldelta = protocol(length(protocol));
    delta = tau + (smalldelta / 3.0);  

    load_acquisition_parameters(bvalues_filename, delta, smalldelta, outputfolder); 
    
    [Mdl, metric] = setup_and_run_model_training(schemefile, SNR, outputfolder, Dsoma, Din_UB, Rsoma_UB, De_UB, seed_rng, protocolname, figsfolder);
end

