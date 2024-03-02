% test with several cases

%% -------------------Problem 1-------------------
clc,clear;
A = [1,3,0,4,1;1,2,0,-3,1;-1,-4,3,0,0];
b = [2;2;1];
c = [2;3;3;1;-2];
option = [1e-9,0.95,1000];
fprintf('-----------------Problem 1: Simple Case (ex3.17)-----------------\n\n')
[optsol, optval, info] = main(A,b,c,option);

[optsol_gurobi, optval_gurobi] = linprog(c, [], [], A, b, zeros(numel(c),1), []);
fprintf('optimal value by Gurobi: %f\n', optval_gurobi)

%% -------------------Problem 2-------------------
clc,clear;
A = [1,2,0,2,0;0,0,1,3,0;0,8,0,6,1];
b = [100;-2;5];
c = [0;20;0;13;0];
option = [1e-8,0.9,1000];
fprintf('\n-----------------Problem 2: Infeasible Case-----------------\n\n')
[optsol, optval, info] = main(A,b,c,option);
[optsol_gurobi, optval_gurobi] = linprog(c, [], [], A, b, zeros(numel(c),1), []);
fprintf('optimal value by Gurobi: %f\n', optval_gurobi)

%% -------------------Problem 3-------------------
clc,clear;
A = [1,-1,1,1,0,-1;-2,1,0,0,1,0;0,1,-2,2,0,1];
b = [5;3;7];
c = [-2;0;-3;5;1;3];
option = [1e-8,0.9,1000];
fprintf('\n-----------------Problem 3: Unbounded Case-----------------\n\n')
[optsol, optval, info] = main(A,b,c,option);
[optsol_gurobi, optval_gurobi] = linprog(c, [], [], A, b, zeros(numel(c),1), []);
fprintf('optimal value by Gurobi: %f\n', optval_gurobi)

%% -------------------Problem 4-------------------
clc,clear;
rng(07130203);
m = 200;
n = 300;
A = randn(m, n);
b = randn(m, 1);
c = randn(n, 1);
option = [1e-8,0.9,10000];
fprintf('\n-----------------Problem 4: Random Case-----------------\n\n')
[optsol, optval, info] = main(A,b,c,option);
[optsol_gurobi, optval_gurobi] = linprog(c, [], [], A, b, zeros(n,1), []);
fprintf('optimal value by Gurobi: %f\n', optval_gurobi)
%% -------------------Problem 5 lp_capri-------------------
clc,clear;
fprintf('-----------------Problem 5: lp_capri-----------------\n')
example = load('scrs8.mat');
A = example.A;
b = example.b;
c = example.c;
option = [1e-8,0.9,1000];
[optsol, optval, info] = main(A,b,c,option);
[optsol_gurobi, optval_gurobi] = linprog(c, [], [], A, b, zeros(numel(c),1), []);
fprintf('optimal value by Gurobi: %f\n', optval_gurobi)