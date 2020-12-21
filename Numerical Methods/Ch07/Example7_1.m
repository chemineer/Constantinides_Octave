% Example7_1.m% Solution to Example 7.1. This program gets the data% from the keyboard, and/or from a data file, performs the % nonlinear regression (using NLR.M) and the statistical % analysis of the results (using STATISTICS.M). The program% gives the results of the calculations numerically and % graphically.(p510)clearclcclose alldisp(' Nonlinear Regression Analysis'), disp(' ')fout = input(' Name of output file for storing results = ');if exist(fout)   error(' Output file already exists. Use another name.')end% Input experimental datadisp(' ')disp(' Experimental data input:')disp('   1 - Enter data from keyboard (point-by-point)')disp('   2 - Enter data from keyboard (in vector form)')disp('   3 - Read data from data file (prepared earlier)')datain = input(' Enter your choice : ');disp(' ')switch dataincase 1   fdata = input(' Name of file for storing the data = ');   if exist ([fdata,'.mat'])      error(' Data file already exists. Use another name.')   end   v = input(' Number of dependent variables = ');   for m = 1:v      countpoints=0;      fprintf('\n Variable %2d\n',m)      datasets=input(' How many data sets for this variable? = ');      for nset = 1:datasets      fprintf('\n   Data set %2d\n',nset)      npoints = input('   How many points in this set? = ');      disp(' ')        for np = 1:npoints           countpoints=countpoints+1;           fprintf('   Point %2d\n',np)           xm = input('   Enter independent value = ');           ym = input('   Enter dependent value   = ');           x(countpoints,m)=xm;           y(countpoints,m)=ym;        end      end      n(m) = countpoints;   end      eval(['save ',fdata ' n x y']) case 2   fdata = input(' Name of file for storing the data = ');   if exist ([fdata,'.mat'])      error(' Data file already exists. Use another name.')   end   v = input(' Number of independent variables = ');   for m = 1:v      fprintf('\n Variable %2d\n',m)      xm = input(' Vector of independent variable = ');      x(1:length(xm),m) = (xm(:).')';      ym = input(' Vector of dependent variable = ');      y(1:length(ym),m) = (ym(:).')';      n(m) = length(ym);   end     eval(['save ',fdata ' n x y']) case 3   fname = input(' Name of file containing the data = ');   eval(['load ', fname])   [r,v] = size(y);enddisp(' ')namex = input(' Name of independent variable = ');for m = 1:v   nam = input([' Name of dependent variable ', int2str(m), ' = ']);   namey(m,1:length(nam))= nam;end% Input type of equation(s)disp(' ')disp(' Type of equation(s)')disp('   1 - Algebraic equation')disp('   2 - Ordinary differential equation')disp('   3 - Both 1 and 2')eqin = input(' Enter your choice : ');disp(' ')switch eqincase 1	% Algebraic equation   fnctn = input(' Name of M-file containing algebraic equation(s) = ');   ODEfile = []; x0 = []; y0 = [];case 2	% ODE   ODEfile = input(' Name of M-file containing differential equation(s) = ');   disp(' ')   x0 = input(' Value of independent variable at boundary condition = ');   y0 = input(' Value(s) of dependent variable(s) at boundary condition = ');   fnctn = [];otherwise% Algebraic and ODE   fnctn = input(' Name of M-file containing algebraic equation(s) = ');   ODEfile = input(' Name of M-file containing differential equation(s) = ');   disp(' ')      x0 = input(' Value of independent variable at boundary condition = ');   y0 = input(' Value(s) of dependent variable(s) at boundary condition = ');end% Input method of solutiondisp(' ')disp(' Method of solution')disp('   1 - Marquardt')disp('   2 - Gauss-Newton')method = input(' Enter your choice : ');disp(' ')b0 = input(' Vector of initial guess of fitting parameters = ');disp(' ')trace = input(' Show results of each iteration (0/1) ? ');if trace == 0   disp(' ')   disp(' Please wait for final results')end% Regression[b, yc, w, JTJ] = NLR(b0, n, x, y, fnctn, ODEfile, x0, y0, ...   method, [], trace);if trace == 1   disp(' ')   disp(' Please wait for final results')end% Statistical properties[sd, cl] = statistics(b, n, x, y, yc, w, JTJ, 95, fout);% Displaying final resultsdisp(' ')disp(' **********************************************************')disp('                    Final Results')disp(' **********************************************************')disp(' ')disp('  No.   Parameter    Standard      95% Confidence interval ')disp('                     deviation     for the parameters      ')disp('                                   lower value  upper value')for m = 1:length(b)   fprintf('  %2d    %10.4e  %10.4e   %10.4e  %10.4e\n',...      m,b(m),sd(m),cl(m,:))enddisp(' ')disp(' **********************************************************')% Plotting the resultsfor m = 1:v   figure(m)   [xx,loc] = sort(x(1:n(m),m));   plot(x(1:n(m),m),y(1:n(m),m),'o',xx,yc(loc,m))   xlabel(namex)   ylabel(namey(m,:))end