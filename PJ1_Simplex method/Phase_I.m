% Phase I of the two-phase simplex method.
% input: A, b, tol
% A: m<n, full rank not a must
% output: bas_index, status, A_line_ind, rm
% rm: indices of redundant constraints that should be removed.
% status could be 0(feasible), 3(infeasible)

function [bas_index, status, A_ind, rm]=Phase_I(A,b,tol)
    [m,n]=size(A);
    A_ind = 1; %indicate the linear independence of A's rows
    r = 0; rm=[];

    % check if b is nonnegative
    for i=1:m
        if b(i) < 0
            A(i,:) = -A(i,:);
            b(i) = -b(i);
        end
    end

    % introduce artificial variables
    A = [A, eye(m)];
    c = [zeros(1,n), ones(1,m)]';
    bas_index = n+1:n+m;

    % solve the phase I problem (by means of phase II)
    [~, bas_index, optval, ~, T] = Phase_II(A, b, c, bas_index, tol);
    if optval > tol
        status = 3;
        return;
    else
        status = 0;
        % remove artificial variables
        if isempty(find(bas_index > n, 1))
            return;
        else
            for i=1:m
                if bas_index(i) > n
                    % find a non-zero element in the i-th row
                    for l=2:n+1
                        if T(i,l) ~= 0
                            bas_index(i) = l-1;
                            l = 0;
                            break;
                        end
                    end
                    if l ~= 0
                        r = r+1;
                        A_ind = 0;
                        % the i-th row should be removed
                        rm(r) = i;
                    end
                end
            end
            bas_index(rm)=[];
        end
    end
end
