% Example6_3.m% Solution to Example 6-3. This program calculates and plots% the temperature profiles of a furnace wall by solving the% two-dimensional unsteady-state energy balance equation using% the function PARABOLIC2D.M.(p419)clearbcdialog = [' Lower x boundary condition:'   ' Upper x boundary condition:'   ' Lower y boundary condition:'   ' Upper y boundary condition:'];clcdisp(' Solution of two-dimensional parabolic')disp(' partial differential equation.')disp(' ')width = input(' Width of the plate (x-direction) (m) = ');length = input(' Length of the plate  (y-direction) (m) = ');tmax = input(' Maximum time (hr) = ')*3600;p = input(' Number of divisions in x-direction = ');q = input(' Number of divisions in y-direction = ');r = input(' Number of divisions in t-direction = ');alpha = input(' Thermal diffusivity of the wall = ');   redo = 1;while redo   clc   clf   T0 = input(' Initial temperature of the wall (deg C) = ');   u0 = T0*ones(p+1,q+1);	% Matrix of initial condition      disp(' ')   disp(' Boundary conditions:')   for k = 1:4      disp(' ')      disp(bcdialog(k,:))      disp(' 1 - Dirichlet')      disp(' 2 - Neumann')      disp(' 3 - Robbins')      bc(k,1) = input(' Enter your choice : ');      if bc(k,1) < 3         bc(k,2) = input(' Value = ');      end      switch bc(k,1)      case 3         disp(' u'' = (beta) + (gamma)*u')         bc(k,2) = input(' Constant    (beta)  = ');         bc(k,3) = input(' Coefficient (gamma) = ');      case 1         switch k         case 1            u0(1,:) = bc(k,2)*ones(1,q+1);         case 2            u0(p+1,:) = bc(k,2)*ones(1,q+1);         case 3            u0(:,1) = bc(k,2)*ones(p+1,1);         case 4            u0(:,q+1) = bc(k,2)*ones(p+1,1);         end      end   end      % Calculating concentration profile   [x,y,t,T] = parabolic2D(p,q,r,width/p,length/q,tmax/r,...      alpha,u0,bc);   r = max(size(t))-1;	% Time step may be changed by the solver   disp(' ')   disp(' Which version of MATLAB are you using?')   disp(' 0 - The Student Edition')   disp(' 1 - The Complete Edition')   ver = input(' Choose either 0 or 1: ');   maxt = max(max(max(T)));   mint = min(min(min(T)));   switch ver   case 0      for kr = 1:3         for kc = 1:3            m1 = (kr-1)*3+kc;            m2 = fix(r/8*(m1-1)+1);            subplot(3,3,m1), surf(y/length,x/width,T(:,:,m2))            view(135,45)            axis([0 1 0 1 0 maxt])            if kr == 2 & kc == 1               zlabel('Temperature (deg C)')            end            if kr == 3 & kc == 2               xlabel('y/Length')               ylabel('x/Width')            end            ttl = [num2str(t(m2)/3600) 'h'];            title(ttl)         end      end   case 1      disp(' ')      disp(' Are you patient enough to see a movie of temperature')      mv = input(' profile evolution (0/1)? ');     if mv       % Making movie of temperature profile evolution       M = moviein(r);       for k = 1:r+1          surf(y/length,x/width,T(:,:,k))          axis([0 1 0 1 0 maxt])          view(135,45)          shading interp          ylabel('x/Width')          xlabel('y/Length')          zlabel('Temperature (deg C)')          M(:,k) = getframe;       end       movie(M,5)     else	% Show results in 9 succeeding frames      for kr = 1:3         for kc = 1:3            m1 = (kr-1)*3+kc;            m2 = fix(r/8*(m1-1)+1);            subplot(3,3,m1), surf(y/length,x/width,T(:,:,m2))            view(135,45)            axis([0 1 0 1 0 maxt])            if kr == 2 & kc == 1               zlabel('Temperature (deg C)')            end            if kr == 3 & kc == 2               xlabel('y/Length')               ylabel('x/Width')            end            ttl = [num2str(t(m2)/3600) 'h'];            title(ttl)         end      end     end   end   disp(' ')   redo = input(' Repeat with different initial and boundary conditions (0/1)? ');end