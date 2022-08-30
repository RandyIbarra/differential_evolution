addpath(genpath(fullfile(pwd, 'functions')));



% contruimos un conjunto de datos de prueba
rng(123) % for reproducibility
[aux_database_train, aux_database_train_noisy, aux_params_train] = build_training_set(model, figsfolder);



% parametros conocidos
dimension = 7; % 6 o 7 dependiendo numero de shells

n_iterations = 1;       % n_iterations
population_size = 4; % population_size >= 4
diff_weight = 1.5;     % diff_weight \in [0, 2]
cross_prob = 0.5;    % cross_prob \in [0,1]

lower_b  = [600.00, 600.00, 600.00, 600.00, 600.00, 10,  3 ];
upper_b = [5000.0, 5000.0, 5000.0, 5000.0, 5000.0, 20, 15];

% each row is a subject
population = init(dimension, population_size, lower_b, upper_b);
disp(population);
for j=1:population_size
        agent = population(j,:);
        %disp(agent);
        disp(objective_function(agent));
end
% to save best solution
optimal_value = realmax;
optimal_agent = population(:,1);

cont = 0;

rng('default');
for generation=1:n_iterations
    fprintf('GENERATION (%d)\n', generation);
    tic
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
        
        cont = cont + 2;
        value = objective_function(agent);
        new_value = objective_function(new_agent);
        if(new_value <= value)
            population(j,:) = new_agent;
            if(new_value < optimal_value)
                optimal_agent = agent;
                optimal_value = value;
                disp('new solution');
                disp(optimal_value);
                disp(optimal_agent);
            end
        end
    end 
    tac
end

disp('function calls');
disp(cont);
disp('best solution');
disp(optimal_value);
disp(optimal_agent);