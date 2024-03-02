% Update step
% Input: x, lamda, s, A, b, c, eta
% eta in [0.9, 1.0)
% Output: x_n, lambda_n, s_n, rb_n, rc_n

function [x_n, lambda_n, s_n, rb_n, rc_n] = update(x, lambda, s, A, b, c, eta)
    [~,n] = size(A);
    
    %------------------predictor step-----------------------
    rc = A'*lambda + s - c;
    rb = A*x - b;
    xse = x.*s;

    [delta_x_aff, ~, delta_s_aff] = aff_direction(A, x, s, rb, rc, xse);
    
    % maximum allowable steplengths
    [alpha_aff_pri, alpha_aff_dual] = step_length(x, s, delta_x_aff, delta_s_aff);

    mu = x'*s / n;
    mu_aff = (x + alpha_aff_pri*delta_x_aff)'*(s+alpha_aff_dual*delta_s_aff) / n;
    sigma = (mu_aff/mu)^3; % centering parameter


    %------------------corrector step-----------------------
    xse_n = xse + delta_x_aff.*delta_s_aff - sigma*mu;
    [delta_x, delta_lambda, delta_s] = aff_direction(A, x, s, rb, rc, xse_n);
    [alpha_pri, alpha_dual] = step_length(x, s, delta_x, delta_s, eta);
    
    
    %----------------------update---------------------------
    x_n = x + alpha_pri*delta_x;
    lambda_n = lambda + alpha_dual*delta_lambda;
    s_n = s + alpha_dual*delta_s;

    rc_n = A'*lambda_n + s_n - c;
    rb_n = A*x_n - b;
end


