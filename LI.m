function x = LI(fnctn,x1,x2,tol,trace,varargin)
%LI Finds a zero of a function by the linear interpolation method.
% LI('F',X1,X2) finds a zero of the function described by the
% M-file F.M. X1 and X2 are starting points where the function
% has different signs at these points.
% LI('F',X1,X2,TOL,TRACE) uses tolerance TOL for convergence
% test. TRACE=l shows the calculation steps numerically and
% TRACE=2 shows the calculation steps both numerically and
% graphically.
% LI('F',X1,X2,TOL,TRACE,Pl,P2,...) allows for additional
% arguments which are passed to the function F(X,P1,P2, ...).
% Pass an empty matrix for TOL or TRACE to use the default
% value.
% See also FZERO, ROOTS, XOX, NR
% (c) by N. Mostoufi & A. Constantinides
% January 1, 1999
% Initialization
if nargin < 4 | isempty(tol)
tol=1e-6;
end
if nargin < 5 | isempty(trace)
trace = 0;
end
if tol == 0
tol = 1e-6;
end
if (length(x1) > 1) | (~isfinite(x1)) | (length(x2) > 1) | (~isfinite(x2))
error('Second and third arguments must be finite scalars.')
end
if trace
header = ' Iteration x f(x)';
disp(' ' ) 
disp(header)
end
f1 = feval(fnctn,x1,varargin{:});
f2 = feval(fnctn,x2,varargin{:});
iter = 0;
if trace
% Display initial values
%fprintf('%5.Of %l3.6g %l3.6g \n',iter, [x1 f1])
%fprintf('%5.Of %l3.6g %l3.6g \n',iter, [x2 f2])
printf('%d %f %f \n',iter, x1, f1)
printf('%d %f %f \n',iter, x2, f2)
if trace == 2
xpath = [x1 x1 x2 x2];
ypath = [0 f1 f2 0];
end
end
if f1 < 0
xm = x1;
fm = f1;
xp = x2;
fp = f2;
else
xm = x2;
fm = f2;
xp = x1;
fp = f1;
end
iter = iter + 1;
itermax = 100; 
x = xp;
x0 = xm;
% Main iteration loop
while abs(x - x0) > tol & iter <= itermax
x0 = x; 
x = xp - fp * (xm- xp) / (fm - fp);
fnk = feval(fnctn,x,varargin{:});
if fnk < 0 
  xm = x; 
  fm = fnk;
  else
xp = x;
fp = fnk;
end
% Show the results of calculation
if trace
%fprintf('%5.Of %l3.6g %13.6g \n',iter, [x fnk])
printf('%d %f %f \n',iter, x, fnk)
if trace == 2
xpath = [xpath xm xm xp xp];
ypath = [ypath 0 fm fp 0];
end
end
iter = iter + 1;
end
if trace == 2
% Plot the function and path to the root
xmin = min(xpath); 
xmax = max(xpath);
dx = xmax - xmin;
xi = xmin - dx/10;
xf = xmax + dx/10;
yc =[];
for xc = xi : (xf - xi)/99 : xf
yc=[yc feval(fnctn,xc,varargin{:})];
end 
xc = linspace(xi,xf,100); 
ax = linspace(0,0,100);
plot(xc,yc,xpath,ypath,xc,ax,xpath(2:3),ypath(2:3),'*',x,fnk,'o')
axis([xi xf min(yc) max(yc)])
xlabel ('x')
ylabel ('f(x)') 
title('Linear Interpolation : The function and path to the root (* : initial guess ; o : root)')
end
if iter >= itermax
disp('Warning : Maximum iterations reached.')
end