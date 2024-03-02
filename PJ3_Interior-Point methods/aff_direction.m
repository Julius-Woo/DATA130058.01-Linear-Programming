% Compute affine-scaling direction
% used to solve the equation: Mx = t
% M = [0,A',I;A,0,0;S,0,X]
% x = [delta_x; delta_lambda; delta_s]
% t = [-rc, -rb, -r_xs]

function [delta_x, delta_lambda, delta_s] = aff_direction(A, x, s, rb, rc, r_xs)
    [m,~] = size(A);
    D_square = diag(x./s);
    LHS = A*D_square*A';
    RHS = -rb + A*(r_xs./s) - A*((x./s).*rc);
    
    % use original Cholesky -- may be instable
    opts.SYM = true;
    delta_lambda = linsolve(LHS, RHS, opts);
    
    % use modified Cholesky
%     [L_tilde,J] = modchol(LHS,1e-10);
%     delta_lambda = zeros(m,1);
%     J_bar = setdiff(1:m,J);
%     L_Jbar = L_tilde(J_bar,J_bar);
%     delta_lambda(J_bar) = ((L_Jbar)')\(L_Jbar\RHS(J_bar));

    delta_s = -rc - A'*delta_lambda;
    delta_x = -r_xs./s - (x./s).*delta_s;
end