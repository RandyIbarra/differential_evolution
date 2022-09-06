function [optimal_agent, optimal_value, function_time] = differential_evolution(population, f, n_iterations, diff_weight, cross_prob, lower_b, upper_b)
    % get problem dimension
    dimension = size(population, 2);

    % get population size. each row is an agent.
    population_size = size(population, 1);

    fprintf("\nn iterations: %d\n", n_iterations);
    fprintf("diff_weight: %f\n", diff_weight);
    fprintf("cross_prob: %f\n\n", cross_prob);
    
    cont = population_size + population_size*n_iterations;
    fprintf("number of function calls: %d\n", cont);
    
    % to minimize function calls. save score for every function call to use it later.
    values = zeros(population_size); 
    
    % to save best solution
    optimal_agent = population(1,:); % random agent
    
    starttime = tic;
    optimal_value = f(optimal_agent); % upper_bound
    endtime = toc(starttime);

    fprintf("Function call time %f sec.\n", round(endtime));

    fprintf("\nFirst function value: %f \n\n", optimal_value);
    
    
    % measure function call time
    function_time = endtime;

    for j=2:population_size
        agent = population(j,:);
        
        starttime = tic;
        value = f(agent);
        endtime = toc(starttime);

        fprintf("Function call time %f sec.\n", round(endtime));

        values(j) = value;
        
        function_time = function_time + endtime;

        if value < optimal_value
            optimal_value = value;
            optimal_agent = agent;
            fprintf("\n \n new optimal value: %f \n \n \n", optimal_value);
        end
    end

    fprintf('\nAverage function call time in first population %f sec.\n', round(function_time / population_size));

    rng('default');
    for generation=1:n_iterations
        
        startLoop = tic;

        for j=1:population_size
            
            agent = population(j,:);
            
            % select three subjects
            [agent_a,agent_b,agent_c] = get_target_vectors(population, j);
            aux_agent = agent_a + diff_weight * (agent_b - agent_c);
            
            % ensure that at least one entry is always changed
            R = randi(dimension);
            
            % build new agent from current agent
            new_agent = agent;
            for i=1:dimension
                if (i == R) || (rand() < cross_prob)    
                    aux_value = aux_agent(:, i);
                    % if aux_value is not in the domain, then generate a random number in (lower_b, upper_b)
                    if (aux_value < lower_b(i)) || (upper_b(i) < aux_value)
                        new_agent(:, i) = get_uniform(lower_b(i), upper_b(i));
                    else
                        new_agent(:, i) = aux_value;
                    end   
                end
                % else new_agent(:, i) = agent(i)
            end
            
            value = values(j);

            starttime = tic;
            new_value = f(new_agent);
            endtime = toc(starttime);

            function_time = function_time + endtime;

            if(new_value <= value)
                population(j,:) = new_agent;
                values(j) = new_value;
                if(new_value < optimal_value)
                    optimal_agent = agent;
                    optimal_value = new_value;
                    fprintf("\n \n new optimal value: %f \n \n \n", optimal_value);
                end
            end
        end 

        endLoop = toc(startLoop);
        fprintf('time in generation (%d): %f\n', generation, (endLoop));

    end

    function_time = function_time / cont;
    fprintf('\n function calls time average: %d \n', function_time);

    fprintf('\n optimal value: %f \n', optimal_value);
    fprintf('\n optiml agent\n');
    disp(optimal_agent);

    fprintf('population\n');
    disp(population);
end