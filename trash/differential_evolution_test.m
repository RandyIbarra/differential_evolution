addpath(genpath(fullfile(pwd, 'test_functions')));
clc;

dimension = 4;

n_iterations = 100;    % n_iterations
population_size = 10; % population_size >= 4
diff_weight = 1.5;   % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

% f_sum, f_norm, 
lower_b = [-5.12, -5.12, -5.12, -5.12];
upper_b = [ 5.11,  5.11,  5.11,  5.11];

population = random_init(dimension, population_size, lower_b, upper_b);
values = zeros(population_size); % para ahorrar llamadas a funcion

% to save best solution
optimal_value = realmax;
optimal_agent = population(:,1);
cont = 0;
function_time = 0.0;

for j=1:population_size
	agent = population(j,:);
	
	starttime = tic;
	value = f_sum(agent);
	endtime = toc(starttime);

    function_time = function_time + endtime;

	if value < optimal_value
		optimal_value = value;
		optimal_agent = agent;
        disp('new solution');
        disp(optimal_value);
        %disp(optimal_agent);
	end
	
	values(j) = value;
	cont = cont +1;
end

rng('default');
for generation=1:n_iterations
    
    %fprintf('GENERATION (%d)\n', generation);
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
        
        cont = cont + 1;
        value = values(j);

        starttime = tic;
        new_value = f_sum(new_agent);
        endtime = toc(starttime);

        function_time = function_time + endtime;
        %fprintf('f_time: %f\n', (endtime));


        if(new_value <= value)
            population(j,:) = new_agent;
            values(j) = new_value;
            if(new_value < optimal_value)
                optimal_agent = agent;
                optimal_value = new_value;
                disp('new solution');
                disp(optimal_value);
                %disp(optimal_agent);
            end
        end
    end 

    endLoop = toc(startLoop);
    %fprintf('END (%d)\ntime: %f\n', generation, (endLoop));

end

disp('function calls');
disp(cont);

disp('function calls time average');
disp(function_time / cont);

disp('best solution');
disp(optimal_value);
disp(optimal_agent);


disp('population');
disp(population);