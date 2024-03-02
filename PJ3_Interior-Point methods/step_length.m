% Calculate the step length in each iteration
% Input: x, s, delta_x, delta_s, eta
% Output: alpha_pri, alpha_dual

function [alpha_pri, alpha_dual] = step_length(x, s, delta_x, delta_s, eta)

    if ~exist('eta', 'var')
        eta = 1;
    end

    alpha_pri = min(1, eta*min(-x(delta_x<0)./delta_x(delta_x<0)));
    alpha_dual = min(1, eta*min(-s(delta_s<0)./delta_s(delta_s<0)));

    if isempty(alpha_pri)
        alpha_pri = 1;
    end
    if isempty(alpha_dual)
        alpha_dual = 1;
    end
    
end