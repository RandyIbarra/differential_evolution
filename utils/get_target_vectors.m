% Sea i (logica 1) el indice del agente actual en la epoca G del algoritmo DE (Differential Evolution).
%
% Necesitamos elegir tres indices a,b,c en {1,2,...,pop_size}\{i} distintos. 
%
% Generamos tres enteros distintos a', b' y c' en {1,...,pop-1}.
% Usamos i (en logica 0) como pivote: A i le sumamos a', b' y c'.
% Tomamos residuo modulo <population_size> y sumamos 1.
%
% Observacion: 
% Los tres enteros resultantes son distintos a i, 
% son distintos entre ellos y estan en {1,2,...,pop_size}\{i}.
%
% Con el metodo anterior obtenemos los indices a,b,c en {1,2,...,pop_size}\{i} distintos.
function [agent_a,agent_b,agent_c] = get_target_vectors(population, i)
    population_size = size(population, 1);
    % select three different indices in [1,pop_size-1] (because we don't want to choose i)
    three_indices = randperm(population_size - 1, 3);
    % get indices: first pass i to zero-logical-indexing. At the end, we sum 1 to pass to 1-logical-indexing.
    a = mod((i-1) + three_indices(1), population_size) + 1;
    b = mod((i-1) + three_indices(2), population_size) + 1;
    c = mod((i-1) + three_indices(3), population_size) + 1;
    % las check: this should not happen
    if a==b || b==c || a==c || a==i || b==i || c==i
        fprintf("generated indices are not different \n");
    end
    % get three subjects from indices
    agent_a = population(a, :);
    agent_b = population(b, :);
    agent_c = population(c, :);
end

