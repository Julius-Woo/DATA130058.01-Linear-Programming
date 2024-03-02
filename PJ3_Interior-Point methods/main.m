% Interior methods--Mehrotra's Predictor-Corrector Algorithm
% Input: A, b, c, option
% option: [tol, eta, maxiter]
% Output: optsol, optval, info
% info: [status, iteration]
% status (of the primal problem): optimal=1, unbounded=2, infeasible=3, maxiteration=4

function [optsol, optval, info] = main(A, b, c, option)
    [m,n] = size(A);
    tol = option(1);
    eta = option(2);
    maxiter = option(3);

    %find a starting point
    [x, lambda, s] = starting_point(A, b, c);
    rc0 = A'*lambda + s - c;
    rb0 = A*x - b;

    %iterate
    for k = 1:maxiter
        [x, lambda, s, rb, rc] = update(x,lambda, s, A, b, c, eta);
        duality_gap = x'*s / n;

        if norm(rb) > norm(rb0)*1e2
            optsol = [];
            optval = -Inf;
            fprintf('This problem is unbounded!\n')
            info(1) = 2;
            info(2) = k;
            return
        end

        if norm(rc) > norm(rc0)*1e2
            optsol = [];
            optval = [];
            fprintf('This problem is infeasible!\n')
            info(1) = 3;
            info(2) = k;
            return
        end

        
        if duality_gap < tol
            optval = c'*x;
            optsol = x;
            fprintf('This problem has an optimal solution.\n')
            fprintf('The optimal value is: %f\n',optval)
            info(1) = 1;
            info(2) = k;
            return
        end

        if k == maxiter
            fprintf('Exceed maximum iteration.\n')
            info(1) = 4;
            info(2) = k;
        end

    end
  

end