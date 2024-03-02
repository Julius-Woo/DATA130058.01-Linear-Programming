% test with several cases

%% -------------------Problem 1-------------------
clc,clear;
tol = 1e-10;
A = [1,3,0,4,1;1,2,0,-3,1;-1,-4,3,0,0];
b = [2;2;1];
c = [2;3;3;1;-2];
fprintf('-----------------Problem 1: Simple Case (ex3.17)-----------------\n\n')
main(A,b,c,tol);

%% -------------------Problem 2-------------------
clc,clear;
tol = 1e-10;
A = [1,2,3,0;-1,2,6,0;0,4,9,0;0,0,3,1];
b = [3;2;5;1];
c = [1;1;1;0];
fprintf('-----------------Problem 2: Rank-deficiency Case (eg3.9)-----------------\n\n')
main(A,b,c,tol);

%% -------------------Problem 3-------------------
clc,clear;
tol = 1e-10;
A = [1,2,3,4,5;-1,-2,-3,0,-55;9,8,7,6,5];
b = [100;2;5];
c = [1;20;85;13;1];
fprintf('\n-----------------Problem 3: Infeasible Case-----------------\n\n')
main(A,b,c,tol);

%% -------------------Problem 4-------------------
clc,clear;
tol = 1e-10;
A = [1,-1,1,1,0,-1;-2,1,0,0,1,0;0,1,-2,2,0,1];
b = [5;3;7];
c = [0;-2;-3;5;1;3];
fprintf('\n-----------------Problem 4: Unbounded Case-----------------\n\n')
main(A,b,c,tol);

%% -------------------Problem 5-------------------
clc,clear;
tol = 1e-10;
m = 5;
n = 15;
A = randn(m, n);
b = randn(m, 1);
c = randn(n, 1);
fprintf('\n-----------------Problem 5: Random Case-----------------\n\n')
main(A,b,c,tol);

% cvx_begin
%     variable x(15)
%     minimize(c'*x)
%     subject to
%         A*x==b;
%         x>=0;
% cvx_end
