This is an implementation of Simplex Method in MATLAB, which solves the standard form linear programming problem.

[Phase_I.m](./Phase_I.m) is the implementation of the first phase of simplex method, which finds the inital basic feasible solution.

Inputs:

	A: input matrix, m*n, m<n, not necessarily with full rank.
	b: the right hand of equality constraints, m*1.
	tol: the tolerance to set zero, such as 1e-10.

Outputs:

	bas_index: a row vector that consists of basic indices of the original A (after removing redundant rows).
	status: 0(feasible), 3(infeasible)
	A_line_ind: == 0 means that A is linearly dependent.
	rm: a row vector that consists of indices of redundant constraints that should be removed.


[Phase_II.m](./Phase_II.m) is the implementation of the second phase of simplex method, which is also used to update the tableau in phase I.

Inputs:

	A: input matrix, m*n, m<n, rank(A)=m.
	b: the right hand of equality constraints, m*1.
	c: the cost coefficients of the problem, n*1.
	bas_index: a row vector that consists of basic indices of A.
	tol: the tolerance to set zero, such as 1e-10.

Outputs:

	optsol: optimal solution
	bas_index: a row vector that consists of basic indices of the optimal solution.
	optval: optimal value
	status: 1(optimal), 2(unbounded), 4(maxiteration)
	T: the tableau except the zeroth row, i.e. B^(-1)[b,A]


[main.m](./main.m) is the full implementation of the two-phase simplex method.

Inputs:

	A: input matrix, m*n, m<n, not necessarily with full rank.
	b: the right hand of equality constraints, m*1.
	c: the cost coefficients of the problem, n*1.
	tol: the tolerance to set zero, such as 1e-10.

Outputs:

	optsol: optimal solution (if the problem is infeasible or unbounded, then it will be returned as [].)
	B: the basis corresponding to the optimal solution.
	optval: optimal value (if the problem is infeasible, it will be returned as []; if unbounded, '-inf')
	status: 1(optimal), 2(unbounded), 3(infeasible), 4(maxiteration)

    In the command window, there are also results printed in terms of different cases:
	If the problem is feasible with finite optimal solution, the window outputs the status, the optimal cost, the optimal solution and its corresonding basis.
	If the problem is unbounded from below, it says "The problem is unbounded from below."
	If the problem is infeasible, it says "The problem is infeasible!"
	In addition, if the matrix A has deficient rank, the output will present "A has linearly dependent rows." with eliminated constraints A and b ahead of other outputs.
	

[test.m](./test.m) is a test file that contains five problems. 
The first problem is a simple case from the textbook ex 3.17; 
the second problem is a rank-deficiency case from eg 3.9; 
the third problem is an infeasible case; 
the fourth problem is an unbounded case; 
the last problem is a random case, where there is not a seed so that you can feel free to test it. Besides, the CVX solver is used to check if the output is right.

Note that in this version of implementation, the input problem has to be in standard form, while the input matrix A does not necessarily have full rank. Moreover, it will be reported whenever there exist redundant constraints.
