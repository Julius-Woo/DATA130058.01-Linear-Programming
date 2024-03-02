% Dual simplex with full rank A and given basis index with dual feasibility
% input: A, b, c, bas_index, tol, maxiter, step_present
% output: optsol, optval, runhist, info
% info: [status, iteration]

function [optsol,optval,runhist,info] = dualsimplex(A,b,c,bas_index,tol,maxiter,step_present)

    [m,n] = size(A);
    B = A(:,bas_index);
    c_b = c(bas_index);
    runhist = zeros(1,maxiter);
    info = zeros(1,2);

    % form the initial tableau
    T3 = B\b;
    T4 = B\A;
    T1 = -c_b'*T3;
    T2 = c' - c_b'*T4;
    T0 = [T1,T2];
    T = [T3,T4];

    if any(T2<-tol)
        fprintf("The initial basis is not dual feasible!\n");
        optval = [];
        optsol = [];
        return;
    end

    % iterate
    for k = 1:maxiter
        runhist(k) = -T0(1);
        % check if the current basis is optimal
        if all(T(:,1) >= -tol)
            info(1) = 1;
            optval = -T0(1);
            optsol = zeros(n,1);
            B = A(:, bas_index);
            x_b = B\b;
            optsol(bas_index) = x_b;
            info(2) = k-1;
            return;
        end

        % find the exiting variable x_B(exit)
        for l = 1:m
            if T(l,1) < -tol
                exit = l;
                break;
            end
        end

        % check if the problem is unbounded
        if all(T(exit,2:n+1) >= -tol)
            info(1) = 2;
            optval = 'inf';
            optsol = [];
            bas_index = [];
            return;
        end

        % find the entering variable x_exit
        ratio = '0'; % the ratio of the reduced cost and the pivot element
        for j = 2:n+1
            if T(exit,j) < -tol
                temp = T0(j)/(-T(exit,j));
                if ratio == '0'
                    ratio = temp;
                    enter = j;
                else 
                    if temp < ratio
                        ratio = temp;
                        enter = j;
                    end
                end
            end
        end

        % update the basis
        bas_index(exit) = enter-1;

        % update the tableau
        T(exit,:) = T(exit,:)/T(exit,enter);
        for i = 1:m
            if i ~= exit
                T(i,:) = T(i,:) - T(exit,:)*T(i,enter);
            end
        end
        T0 = T0 - T(exit,:)*T0(enter);

        % print history
        if step_present==1
            fprintf('-----------iterate %d  tableu-----------\n',k);
            T0
            T
        end
    end

    if k == maxiter
        info(1) = 4;
        optval = -T0(1);
        optsol = zeros(n,1);
        B = A(:, bas_index);
        x_b = B\b;
        optsol(bas_index) = x_b;
        info(2) = maxiter-1;
    end
end