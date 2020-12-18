function x = XGX(FunFcn,x0,tol,trace,varargin)%XGX Finds a zero of a function by x=g(x) method.%%   XGX('G',X0) finds the intersection of the curve y=g(x)%   with the line y=x. The function g(x) is  described by the%   M-file G.M. X0 is a starting guess.%	%   XGX('G',X0,TOL,TRACE) uses tolerance TOL for convergence%   test. TRACE=1 shows the calculation steps numerically and%   TRACE=2 shows the calculation steps both numerically and%   graphically.%%   XGX('G',X0,TOL,TRACE,P1,P2,...) allows for additional%   arguments which are passed to the function G(X,P1,P2,...).%   Pass an empty matrix for TOL or TRACE to use the default%   value.%%   See also FZERO, ROOTS, NR, LI% (c) N. Mostoufi & A. Constantinides% January 1, 1999% Initializationif nargin < 3 | isempty(tol)   tol = 1e-6;endif nargin < 4 | isempty(trace)   trace = 0;endif tol == 0   tol = 1e-6;endif (length(x0) > 1) | (~isfinite(x0))   error('Second argument must be a finite scalar.')endif trace   header = ' Iteration       x            g(x)';  disp(header)  if trace == 2     xpath = [x0];     ypath = [0];  endendx = x0;x0 = x + 1;iter = 1;itermax = 100;% Main iteration loopwhile abs(x - x0) > tol & iter <= itermax   x0 = x;   fnk = feval(FunFcn,x0,varargin{:});      % Next approximation of the root   x = fnk;      % Show the results of calculation   if trace      fprintf('%5.0f   %13.6g %13.6g \n',iter, [x0 fnk])      if trace == 2         xpath = [xpath x0 x];         ypath = [ypath fnk x];      end   end   iter = iter + 1;endif trace == 2   % Plot the function and path to the root   xmin = min(xpath);   xmax = max(xpath);   dx = xmax - xmin;   xi = xmin - dx/10;   xf = xmax + dx/10;   yc = [];   for xc = xi : (xf - xi)/99 : xf      yc=[yc feval(FunFcn,xc,varargin{:})];   end   xc = linspace(xi,xf,100);   plot(xc,yc,xpath,ypath,xpath(2),ypath(2),'*', ...      x,fnk,'o',[xi xf],[xi,xf],'--')   axis([xi xf min(yc) max(yc)])   xlabel('x')   ylabel('g(x) [-- : y=x]')   title('x=g(x) : The function and path to the root (* : initial guess ; o : root)')endif iter >= itermax   disp('Warning : Maximum iterations reached.')end