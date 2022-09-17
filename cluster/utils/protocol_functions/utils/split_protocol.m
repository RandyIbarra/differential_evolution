function [bvals, tau, delta, smalldelta] = split_protocol(protocol)
    % last two entries are tau and delta.
    n_shells = length(protocol) - 2;
    %get bvals
    bvals = sort(protocol(1:n_shells));
    % get tau and delta
    tau = protocol(n_shells + 1);
    smalldelta = protocol(n_shells + 2);
    % compute delta
    delta = tau + (smalldelta / 3.0);
end