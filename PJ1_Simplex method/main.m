% full implementation of the two-phase simplex method
% input: A, b, c, tol
% output: optsol, B, optval, status
% status: feasible=0, optimal=1, unbounded=2, infeasible=3, maxiteration=4
% B: basis

function [optsol, B, optval, status] = main(A,b,c,tol)

    % Phase I
    [bas_index, status, A_ind, rm] = Phase_I(A,b,tol);
    if status == 3
        optsol = [];
        B = [];
        optval = [];
        fprintf('The problem is infeasible!\n');
        return
    end

    % report redundancy
    if A_ind == 0
        fprintf("A has linearly dependent rows.\n")
        A(rm,:) = [];
        b(rm) = [];
        fprintf("The constrains can be eliminated to:\n")
        A,b
    end

    % Phase II
    [optsol, bas_index, optval, status, ~] = Phase_II(A, b, c, bas_index, tol);
    B = A(:, sort(bas_index));

    % result of the problem
    switch status
        case 1
            fprintf("The problem status is optimal.\n");
        case 2
            fprintf("The problem is unbounded from below.\n");
        case 3
            fprintf("The problem is infeasible.\n")
        otherwise
            fprintf("Exceed the max iteration.\n")
    end

    % output the optimal case
    if status == 1
        fprintf('The optimal cost is %f.\n', optval);
        fprintf('The optimal solution is:\n');
        optsol
        fprintf('The corresonding basis is:\n');
        B
    end
end