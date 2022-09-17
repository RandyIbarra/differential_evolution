function landscape_analysis_from_optimal_5_shells()

    addpath(genpath(fullfile(pwd, 'utils')));

    agent = [1000.0, 2000.0, 3000.0, 4000.0, 5000.0, 20, 15]; % insert optimal
    count = 0;

    lower = [  600.0, 1600.0, 2600.0, 3600.0, 4500.0, 10,  3];
    upper = [ 1500.0, 2500.0, 3500.0, 4500.0, 5000.0, 20, 15];
    change= [  100.0,  100.0,  100.0,  100.0,  100.0,  1,  1];

    all_posible_entries_to_use = nchoosek([1,2,3,4,5,6,7],2);
    for combination_index=1:size(all_posible_entries_to_use, 1)

        i_entry_index = all_posible_entries_to_use(combination_index, 1);
        j_entry_index = all_posible_entries_to_use(combination_index, 2);

        i_vals = lower(i_entry_index):change(i_entry_index):upper(i_entry_index);
        j_vals = lower(j_entry_index):change(j_entry_index):upper(j_entry_index);

        i_size = length(i_vals);
        j_size = length(j_vals);

        %image = zeros([i_size, j_size]);
        image_name = [double2str(i_entry_index) '_' double2str(j_entry_index)];
        for i=1:i_size
            ival = i_vals(i);
            for j=1:j_size
                jval = j_vals(j);

                aux_agent = agent;
                
                aux_agent(i_entry_index) = ival;
                aux_agent(j_entry_index) = jval;

                count = count + 1;
                
                fprintf("protocol_function([");
                for index=1:length(aux_agent)
                    fprintf("%.02f", aux_agent(index));
                    if index < length(aux_agent)
                        fprintf(",");
                    end
                end
                fprintf("]);\n");
            end
        end
    end
    disp(count);
end