This is an implementation of Interior Methods (Mehrotra's Predictor-Corrector Algorithm) in MATLAB, which solves the standard form linear programming problem. All the names of variables are consistent with Numerical Optimization algorithm 14.3.

[start_x, start_lambda, start_s] = starting_point(A, b, c) finds a starting point (start_x, start_lambda, start_s).

Inputs:

	A: input matrix, m*n, m<n, rank(A)=m.
	b: the right hand of equality constraints, m*1.
	c: the cost coefficients of the problem, n*1.

Outputs:

	(start_x, start_lambda, start_s)


[delta_x, delta_lambda, delta_s] = aff_direction(A, x, s, rb, rc, r_xs) computes affine-scaling direction, and is also used to solve the equation: Mx = t, where

M = [0,A',I;A,0,0;S,0,X]
x = [delta_x; delta_lambda; delta_s]
t = [-rc, -rb, -r_xs]


[L_tilde, J] = modchol(M, eps) is the implementation of Modified Cholesky Algorithm by S.J. Wright to prevent ill-conditioned case.

Inputs:

	M: positive (may be ill-conditioned) symmetric matrix;
	eps: a small positive number;

Outputs:

	L_tilde: approximate Cholesky factorization L
	J: index set including the indices of skipped pivots


[alpha_pri, alpha_dual] = step_length(x, s, delta_x, delta_s, eta) calculates the step length in each iteration.

	Inputs: x, s, delta_x, delta_s, eta

	Outputs: alpha_pri, alpha_dual

[x_n, lambda_n, s_n, rb_n, rc_n] = update(x, lambda, s, A, b, c, eta) is an update step in one iteration.

	Inputs: x, lamda, s, A, b, c, eta

	Outputs: x_n, lambda_n, s_n, rb_n, rc_n


[optsol, optval, info] = main(A, b, c, option) is the main body of the whole interior method.

	Inputs: A, b, c, option
		option: [tol, eta, maxiter]
		tol: the tolerance to set zero, such as 1e-10.
		eta: positive number in [0.9,1)
      		maxiter: maximum iteration numbers.

	Outputs: optsol, optval, info
		info: [status, iteration]
		status (of the primal problem): optimal=1, unbounded=2, infeasible=3, maxiteration=4


In the command window, there are also results printed in terms of different cases:

	If the problem is feasible with finite optimal solution, the window outputs the status and the optimal value.

	If the problem is unbounded, it says "This problem is unbounded!"

	If the problem is infeasible, it says "This problem is infeasible!"

	If the iteration number exceeds, it says "Exceed maximum iteration."
	

[test.m](./test.m) is a test file that contains four problems. 
The first problem is a simple case from the textbook ex 3.17; 

the second problem is an infeasible case; 

the third problem is an unbounded case; 

the last problem is a random case, where there is not a seed so that you can feel free to test it. 

Besides, the Gurobi solver is used in every problem to check if the output is right.


Note that in this implementation, the input problem has to be in standard form, and the input matrix A must have full rank.
