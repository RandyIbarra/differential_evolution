% Read matrix from txt file
database_train = readmatrix('/home/leslie/Escritorio/differential_evolution/database_train.txt');
database_train_noisy = readmatrix('/home/leslie/Escritorio/differential_evolution/database_train_noisy.txt');
params_train = readmatrix('/home/leslie/Escritorio/differential_evolution/params_train.txt');

disp(size(database_train_noisy));
disp(size(database_train));
disp(size(params_train));