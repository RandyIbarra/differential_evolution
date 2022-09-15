addpath(genpath(fullfile(pwd, 'utils')));
values = [];
times = [];
for j=1:1
    % random protocol. is the optimal.
    agent = [1000,1155,3250,4340,46501,20,13.5];
    % measure time
    starttime = tic;
    value = f_protocol_snr_20(agent);
    endtime = toc(starttime);

    values = [values, value];
    times = [times, round(endtime)];

    % print results
    fprintf("Function call time \t %f sec.\n", round(endtime));
    fprintf("Function value \t %f \n\n", value);
end
fprintf("Average function call time \t %f sec.\n", mean(times));
fprintf("Variance function value (same point) \t %f \n", var(values));
fprintf("Std function value (same point) \t %f \n", std(values));







% RESULTS
% var = 2.4877e-09, std = 4.9876e-05
%function_value_on_same_protocol = [
%    0.423611;
%    0.423596;
%    0.423534;
%    0.423552;
%    0.423575;
%    0.423587;
%    0.423517;
%    0.423510;
%    0.423493;
%    0.423456;
%];