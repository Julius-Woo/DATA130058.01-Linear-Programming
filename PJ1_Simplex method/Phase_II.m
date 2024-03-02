% Phase II of the two-phase simplex method. (also core of the simplex method)
% rank(A)=m with known basis index
% input: A, b, c, bas_index, tol
% output: optsol, bas_index, optval, status, T
% status could be 1(optimal), 2(unbounded), 4(maxiteration)

function [optsol, bas_index, optval, status, T] = Phase_II(A, b, c, bas_index, tol)
    [m,n] = size(A);
    B = A(:, bas_index);
    c_b = c(bas_index);
    maxiter = 10000;
    
    %form the initial tableau
    T3 = B\b;
    T4 = B\A;
    T1 = -c_b'*T3;
    T2 = c' - c_b'*T4;
    T0 = [T1,T2];
    T = [T3,T4];
    
    %iterate
    for k = 1:maxiter
        % check if the current basis is optimal
        if all(T0(2:end) >= -tol)
            status = 1;
            optval = -T0(1);
            optsol = zeros(n,1);
            B = A(:, bas_index);
            x_b = B\b;
            optsol(bas_index) = x_b;
            return;
        end

        % find the entering variable
        for j = 2:n+1
            if T0(j) < -tol
                enter = j;
                break;
            end
        end

        % check if the problem is unbounded
        if all(T(:,enter) <= tol)
            status = 2;
            optval = '-inf';
            optsol = [];
            bas_index = [];
            return;
        end

        % find the leaving variable
        ratio = '0'; % the ratio of the leaving variable and the pivot element
        for i = 1:m
            if T(i,enter) > tol
                temp = T(i,1)/T(i,enter);
                if ratio == '0'
                    ratio = temp;
                    exit = i;
                else 
                    if temp < ratio
                        ratio = temp;
                        exit = i;
                    end
                end
            end
        end

        % update the basis
        bas_index(exit) = enter - 1;

        % update the tableau
        T(exit,:) = T(exit,:)/T(exit,enter);
        for i = 1:m
            if i ~= exit
                T(i,:) = T(i,:) - T(exit,:)*T(i,enter);
            end
        end
        T0 = T0 - T(exit,:)*T0(enter);
    end
    if k == maxiter
        status = 4;
    end
end