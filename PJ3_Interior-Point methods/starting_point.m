% Finding a starting point
% Input
% A: matrix with full row rank
% b: RHS of euqality constaints
% c: cost function coefficients
% Output
% (start_x, start_lambda, start_s)

function [start_x, start_lambda, start_s] = starting_point(A, b, c)
    H = A*A';
    x_tilde = A'*(H\b);
    lambda_tilde = H\(A*c);

    s_tilde = c-A'*lambda_tilde;
    delta_x = max(-1.5*min(x_tilde), 0);
    delta_s = max(-1.5*min(s_tilde), 0);
    x_hat = x_tilde + delta_x;
    hat_s = s_tilde + delta_s;

    xs = x_hat'*hat_s;
    delta_x_new = 0.5*xs/sum(hat_s);
    delta_s_new = 0.5*xs/sum(x_hat);
    start_x = x_hat + delta_x_new;
    start_lambda = lambda_tilde;
    start_s = hat_s + delta_s_new;
end