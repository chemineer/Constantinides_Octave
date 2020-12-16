function x = NR(fnctn,x0, tol, trace,varargin)
%NR Finds a zero of a function by the Newton-Raphson method.
% NR('F',x0) finds a zero of the function described by the
% M-file F.M. X0 is a starting guess.
% NR('F' ,X0,TOL,TRACE) uses tolerance TOL for convergence
% test. TRACE=l shows the calculation steps numerically and
% TRACE=2 shows the calculation steps both numerically and
% graphically.
% NR('F' ,X0,TOL,TRACE,P1,P2, ..,) allows for additional
% arguments which are passed to the function F(X,Pl,P2, ...)
% Pass an empty matrix for TOL or TRACE to use the default
% value.
% See also FZERO, ROOTS, XOX, LI
% (c) by N. Mostoufi & A. Constantinides
% January 1, 1999
% Initialization
if nargin < 3 | isempty(tol)
tol = 1e-6;
end
if nargin < 4 | isempty(trace)
trace = 0;
end
if tol == 0
tol = 1e-6;
end 
if (length(x0) > 1) : (~isfinite(x0))
error('Second argument must be a finite scaler.')
end
iter = 0;
fnk = feval(fnctn,x0,varargin{:});
if trace
header = 'Iteration x f(x)';
disp(' ') 
disp (header)
%fprintf('%5.0d %13.6g %l3.6g \n',iter, [x0 fnk])
printf('%d %f %f \n',iter, x0, fnk)
if trace == 2
xpath = [x0 x0];
ypath = [0 fnk];
end
end
x = x0;
x0= x + 1;
itermax = 100;
% Main iteration loop
while abs(x - x0) > tol & iter <= itermax
iter = iter + 1;
x0 = x;
% Set dx for differentiation
if x0 ~= 0
  dx = x/100;
else
dx = 1/100;
end
% Differentiation
a = x - dx; fa = feval(fnctn,a,varargin{:});
b = x + dx; fb = feval(fnctn,b,varargin{:});
df = (fb - fa)/(b - a);
% Next approximation of the root
if df == 0 
  x = x0 + max(abs(dx),l.l*tol);
else
x = x0 - fnk/df;
end
fnk = feval (fnctn,x,varargin{:});
% Show the results of calculation
if trace
%fprintf('%5.0d %l3.6g %l3.6g \n' ,iter, [x fnk])
printf('%d %f %f \n',iter, x, fnk)
if trace == 2
xpath = [xpath x x];
ypath = [ypath 0 fnk];
end
end
end
if trace == 2
% Plot the function and path to the root
xmin = min(xpath); 
xmax = max(xpath);
dx = xmax - xmin;
xi = xmin - dx/10;
xf = xmax + dx/10;
yc = []; 
for xc = xi : (xf - xi)/99 : xf
yc = [yc feval(fnctn,xc,varargin{:})];
end
xc = linspace(xi,xf,100); 
ax = linspace(0,0,100); 
plot(xc,yc,xpath,ypath,xc,ax,xpath(1),ypath(2),'*',x,fnk,'o')
axis([xi xf min(yc) max(yc)])
xlabel('x') 
ylabel('f(x)')
title('Newton-Raphson: The function and path to the root (* : initial guess ; o : root)')
end
if iter >= itermax
disp('Warning : Maximum iterations reached.')
end