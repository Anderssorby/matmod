from dolfin import *

# Define function space
P2 = VectorElement('P', tetrahedron, 2)
P1 = FiniteElement('P', tetrahedron, 1)
TH = P2 * P1
W = FunctionSpace(mesh, TH)

# Define variational problem
(u, p) = TrialFunctions(W)
(v, q) = TestFunctions(W)
a = inner(grad(u), grad(v))*dx - p*div(v)*dx + div(u)*q*dx
L = dot(f, v)*dx

# Compute solution
w = Function(W)
solve(a == L, w, [bc1, bc0])