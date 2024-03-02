% Dual simplex method
% input: A, b, c, bas_index, options
% A: row linearly independent
% options: [tol, maxiter, step_present]
% step_present: =1 if every tableau in each step is presented; =0 otherwise
% output: optsol, optval, B, runhist, info
% optbas: optimal basis index
% runhist: cost in each iteration
% info: [status, iteration]
% status (of the dual problem): optimal=1, unbounded=2, infeasible=3, maxiteration=4

function [optsol, optval, optbas, runhist, info] = main(A, b, c, bas_index, options)
    
    [m,~] = size(A);
    B = A(:,bas_index);
    % check the input conditions
    if rank(A)<m
        fprintf("A has redundant rows!\n");
        optval = [];
        optsol = [];
        return;
    end

    if rank(B)<m
        fprintf("B is not a basis!\n");
        optval = [];
        optsol = [];
        return;
    end

    tol = options(1);
    maxiter = options(2);
    step_present = options(3);

    [optsol,optval,runhist,info] = dualsimplex(A,b,c,bas_index,tol,maxiter,step_present);

    optbas = sort(bas_index);

    % result of the problem
    switch info(1)
        case 1
            fprintf("The primal problem status is optimal.\n");
        case 2
            fprintf("The primal problem is infeasible.\n");
        case 3
            fprintf("The primal problem is either infeasible or unbounded.\n") % never print this
        case 4
            fprintf("Exceed the max iteration.\n")
    end

    % output the optimal case
    if info(1) == 1
        fprintf('The optimal cost is %f.\n', optval);
        fprintf('The optimal solution is:\n');
        optsol
        fprintf('The corresonding basis index is:\n');
        optbas
    end
end