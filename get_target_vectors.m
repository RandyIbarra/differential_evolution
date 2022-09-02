function [agent_a,agent_b,agent_c] = get_target_vectors(population)
    population_size = size(population, 1);
    % select three different indices
    three_indices = randperm(population_size,3);
    % get indices
    a = three_indices(1);
    b = three_indices(2);
    c = three_indices(3);
    % get three subjects from indices
    agent_a = population(a, :);
    agent_b = population(b, :);
    agent_c = population(c, :);
end

