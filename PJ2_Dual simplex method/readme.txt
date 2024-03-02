This is an implementation of Dual Simplex Method in MATLAB, which solves the standard form linear programming problem.

[optsol,optval,runhist,info] = dualsimplex(A,b,c,bas_index,tol,maxiter,step_present) finds the optimal solution and cost of the primal problem by dual simplex method.

Inputs:

	A: input matrix, m*n, m<n, rank(A)=m.
	b: the right hand of equality constraints, m*1.
	bas_index: a row vector that consists of basis indices satisfying dual feasibility (i.e. reduced costs >= 0).
	tol: the tolerance to set zero, such as 1e-10.
      maxiter: maximum iteration numbers.
	step_present: 0 or 1. ==1 if every tableau in each step is presented; ==0 otherwise.

Outputs:

	optsol: optimal solution of the primal problem.
	optval: optimal value.
	runhist: cost in each iteration.
	info: [status, iteration_number]
	status (of the dual problem): optimal=1, unbounded=2, infeasible=3, maxiteration=4


[optsol, optval, optbas, runhist, info] = main(A, b, c, bas_index, options) is the full implementation of the dual simplex method.

Inputs:

	A: input matrix, m*n, m<n, rank(A)=m.
	b: the right hand of equality constraints, m*1.
	c: the cost coefficients of the problem, n*1.
	bas_index: a row vector that consists of basis indices satisfying dual feasibility (i.e. reduced costs >= 0).
	options: [tol, maxiter, step_present]

Outputs:

	optsol: optimal solution of the primal problem.(if the dual problem is infeasible or unbounded, then it will be returned as [].)
	optval: optimal value (if the dual problem is infeasible, it will be returned as []; if unbounded, 'inf')
	optbas: optimal basis index.
	runhist: cost in each iteration.
	info: [status, iteration_number]


    In the command window, there are also results printed in terms of different cases:
	If the dual problem is feasible with finite optimal solution, the window outputs the status, the optimal cost, the optimal solution of the primal problem and its corresonding basis indices.
	If the dual problem is unbounded, then the primal one must be infeasible, and it says "The primal problem is infeasible."
	If the dual problem is infeasible, any input will not work. 
	If the iteration number exceeds, it says "Exceed the max iteration."
	

[test.m](./test.m) is a test file that contains five problems. 
The first problem is a simple case from the textbook ex 3.17; 
the second problem is a primal infeasible case; 
the third problem is a primal unbounded case; 
the last problem is a random case, where we solve Ax<=b, x>=0, c>=0 because it is easy to get an initial basis by introducing slack variables. There is not a seed so that you can feel free to test it. Besides, the CVX solver is used to check if the output is right.


Note that in this implementation, the input problem has to be in standard form, and the input matrix A must have full rank. Moreover, we have to know at first a dual feasible initial basis.
