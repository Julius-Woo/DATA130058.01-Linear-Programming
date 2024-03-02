% test with several cases

%% -------------------Problem 1-------------------
clc,clear;
A = [1,3,0,4,1;1,2,0,-3,1;-1,-4,3,0,0];
b = [2;2;1];
c = [2;3;3;1;-2];
bas_index = [1,2,5];
options = [1e-10,1000,1];
fprintf('-----------------Problem 1: Simple Case (ex3.17)-----------------\n\n')
main(A,b,c,bas_index,options);

%% -------------------Problem 2-------------------
clc,clear;
A = [1,2,0,2,0;0,0,1,3,0;0,8,0,6,1];
b = [100;-2;5];
c = [0;20;0;13;0];
bas_index = [1,3,5];
options = [1e-10,1000,1];
fprintf('\n-----------------Problem 2: Infeasible primal Case-----------------\n\n')
main(A,b,c,bas_index,options);

%% -------------------Problem 3-------------------
clc,clear;
A = [1,-1,1,1,0,-1;-2,1,0,0,1,0;0,1,-2,2,0,1];
b = [5;3;7];
c = [-2;0;-3;5;1;3];
bas_index = [1,5,6];
options = [1e-10,1000,1];
fprintf('\n-----------------Problem 3: Unbounded primal Case-----------------\n\n')
main(A,b,c,bas_index,options);

%% -------------------Problem 4-------------------
% Solve Ax<=b, x>=0, c>=0
% Introduce slack variables and we can easily get an initial basis
clc,clear;
rng(7130203);
m = 100;
n = 500;
A = randn(m, n);
b = randn(m, 1);
c = abs(randn(n, 1));
c1 = [c;zeros(m,1)];
A1 = [A,eye(m)];
bas_index = n+1:m+n;
options = [1e-8,10000,0];
fprintf('\n-----------------Problem 4: Random Case-----------------\n\n')
[optsol, optval, optbas, runhist, info]=main(A1,b,c1,bas_index,options);

% cvx_begin
%     variable x(m+n)
%     minimize(c1'*x)
%     subject to
%         A1*x==b;
%         x>=0;
% cvx_end
lb = zeros(1,n);
ub = 1000*ones(1,n);
[mx,mval] = linprog(c,A,b,[],[],lb,ub);
