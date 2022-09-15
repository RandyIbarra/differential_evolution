
addpath(genpath(fullfile(pwd, 'utils')));

population = best_protocols();

lower = [-500.0, -500.0, -500.0, -500.0, -500.0, -5, -3];
upper = [ 500.0,  500.0,  500.0,  500.0,  500.0,  5,  3];
change= [ 100.0,  100.0,  100.0,  100.0,  100.0,  2,  2];

all_posible_entries_to_use = nchoosek([1,2,3,4,5,6,7],2);

for k=1:size(population, 1)

    agent = population(k,:);

    center_value = f_protocol_snr_20(agent);

    fprintf("agent\n");
    disp(agent);
    fprintf("central value : \t %f ... \n", center_value);

    %TODO: Hacer lo anterior en una matriz que imprimira una cruz con un mapa de calor

    for combination_index=1:size(all_posible_entries_to_use, 1)

        i= all_posible_entries_to_use(combination_index, 1);
        j= all_posible_entries_to_use(combination_index, 2);
        
        changes_1 = [];
        for increment=lower(i):change(i):upper(i)
            if increment~= 0.0
                agent(i) = agent(i) + increment;
                changes_1 = [changes_1, f_protocol_snr_20(agent)];
                agent(i) = agent(i) - increment;
            end
        end

        changes_2 = [];
        for increment=lower(j):change(j):upper(j)
            if increment~= 0.0
                agent(j) = agent(j) + increment;
                changes_2 = [changes_2, f_protocol_snr_20(agent)];
                agent(j) = agent(j) - increment;
            end
        end

        disp('results ...');
        disp([i, j]);
        disp(changes_1);
        disp('================');
        disp(changes_2);
        disp('end ...');

    end

end