function protocolname = generate_protocol_name(bvals, tau, delta, snr)

    % bvals: vector<double> (8 bytes per entry) 
    % tau: double
    % delta: double
    % snr: double

    % protocolname: answer string
    protocolname = '';
 
    for i=1:length(bvals)
        % convert double to string
        string_bval = double2str(bvals(i));
        % update string name
        protocolname = strcat(protocolname, string_bval, '_');
    end
    
    % get strings from tau, delta and SNR
    string_tau = double2str(tau);
    string_delta = double2str(delta);
    string_snr = double2str(snr);
    
    % update string name and return
    protocolname = strcat(protocolname, string_tau, 't_', string_delta, 'd_', string_snr, 'snr');
end