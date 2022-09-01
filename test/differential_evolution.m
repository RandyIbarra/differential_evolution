function [optimal_agent, optimal_value, function_time] = differential_evolution(population, f, n_iterations, diff_weight, cross_prob)
    % get problem dimension
    dimension = size(population, 2);

    % get population size. each row is an agent.
    population_size = size(population, 1);

    fprintf("\nn iterations: %d\n", n_iterations);
    fprintf("diff_weight: %f\n", diff_weight);
    fprintf("cross_prob: %f\n\n", cross_prob);
    
    cont = population_size + population_size*n_iterations;
    fprintf("n function calls: %d\n", cont);
    
    % to minimize function calls. save score for every function call to use it later.
    values = zeros(population_size); 
    
    % to save best solution
    optimal_agent = population(:,1); % random agent
    fprintf("\nFirst function time call ...\n");
    tic
    optimal_value = f(optimal_agent); % upper_bound
    toc
    fprintf("\nFirst function value: %f \n\n", optimal_value);
    
    
    % measure function call time
    function_time = 0.0;

    for j=2:population_size
        agent = population(j,:);
        
        starttime = tic;
        value = f(agent);
        endtime = toc(starttime);

        values(j) = value;
        
        function_time = function_time + endtime;

        if value < optimal_value
            optimal_value = value;
            optimal_agent = agent;
            fprintf("\nnew optimal value: %f \n\n", optimal_value);
        end
    end

    rng('default');
    for generation=1:n_iterations
        
        startLoop = tic;

        for j=1:population_size
            
            agent = population(j,:);
            
            % select three subjects
            [agent_a,agent_b,agent_c] = get_target_vectors(population);
            aux_agent = agent_a + diff_weight * (agent_b - agent_c);
            
            R = randi(dimension);
            
            % build new agent
            new_agent = agent;
            for i=1:dimension
                if( rand() < cross_prob || i==R )    
                    new_agent(:, i) = aux_agent(:, i);
                end
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
                    fprintf("\nnew optimal value: %f \n\n", optimal_value);
                end
            end
        end 

        endLoop = toc(startLoop);
        fprintf('time in generation (%d): %f\n', generation, (endLoop));

    end

    function_time = function_time / cont;
    disp('\nfunction calls time average');
    disp(function_time);

    disp('best solution');
    disp(optimal_value);
    disp(optimal_agent);

    disp('population');
    disp(population);
end