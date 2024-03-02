% Modified Cholesky Algorithm by S.J. Wright
% Input
% M: positive (may be ill-conditioned) symmetric matrix
% eps: a small positive number
% Output
% L_tilde: approximate Cholesky factorization L
% J: index set including the indices of skipped pivots

function [L_tilde, J] = modchol(M, eps)
    [~,m] = size(M);
    J = zeros(1,m);
    L_tilde = zeros(m,m);
    for i =1:m
        if M(i,i) <= eps
            J(i) = i;
            M(i,i:m) = 0;
            M(i:m,i) = 0;
        else
            L_tilde(i,i) = sqrt(M(i,i));
            L_tilde(i+1:m,i) = M(i+1:m,i)/L_tilde(i,i);
            for j = i+1:m
                M(j,i+1:m) = M(j,i+1:m) - L_tilde(j,i)*L_tilde(i+1:m,i)';
            end
    
        end
    end
    J = J(J~=0);

end