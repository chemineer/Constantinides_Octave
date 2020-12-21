% Example5_3.m% Solution to Example 5.3. This program calculates and plots% the temperature and conversion profile of a plug-flow reactor% in which the endothermic cracking of acetone takes place.% It can call Euler, MEuler, RK, Adams, or AdamsMoulton solvers% for solution of the pair of energy and material balances.% It is also capable of comparing different solvers.(p306)change = 1;while change   clear   clc   % Input data   T0 = input(' Inlet temperature (K)                      = ');   P0 = input(' Inlet pressure (Pa)                        = ');   v0 = input(' Inlet volumetric flow rate (m3/s)          = ');   X0 = input(' Inlet conversion of acetone                = ');   VR = input(' Volume of the reactor (m3)                 = ');   Ta = input(' External gas temperature (K)               = ');   U  = input(' Overall heat transfer coefficient (W/m2.K) = ');   a  = input(' Heat transfer area (m2/m3)                 = ');      CA0 = P0 * (1-X0) / (8.314 * T0);	% Inpuon (mol/m3)   FA0 = v0 * CA0;							% Input molar flow rate (mol/s)   fprintf('\n')   fname = input(' M-file containing the set of differential equations : ');   h = input(' Step size = ');      met = 1;   while met      clc      fprintf('\n')      disp('  1 ) Euler')      disp('  2 ) Modified Euler')      disp('  3 ) Runge-Kutta')      disp('  4 ) Adams')      disp('  5 ) Adams-Moulton')      disp('  6 ) Comparison of methods')      disp('  0 ) End')      met = input('\n Choose the method of solution : ');      if met == 6         method = input('\n Input the methods to be compared, as a vector : ');      else         method = met;      end      lgnd = 'legend(';      lmethod = length(method);      for k = 1:lmethod         switch method(k)         case 1	% Euler            [V,y] = Euler(fname,0,VR,h,[X0,T0],T0,CA0,FA0,U,a,Ta);            if k > 1               lgnd = [lgnd ','];            end            lgnd = [lgnd '''Euler'''];         case 2	% Modified Euler            [V,y] = MEuler(fname,0,VR,h,[X0,T0],T0,CA0,FA0,U,a,Ta);            if k > 1               lgnd = [lgnd ','];            end            lgnd = [lgnd '''Modified Euler'''];         case 3	% Runge-Kutta            n = input('\n Order of the Runge-Kutta method (2-5) = ');            if n < 2 | n > 5              n = 2;            end            [V,y] = RK(fname,0,VR,h,[X0,T0],n,T0,CA0,FA0,U,a,Ta);            if k > 1               lgnd = [lgnd ','];            end            lgnd = [lgnd '''RK' int2str(n) ''''];         case 4	% Adams            [V,y] = Adams(fname,0,VR,h,[X0,T0],T0,CA0,FA0,U,a,Ta);            if k > 1               lgnd = [lgnd ','];            end            lgnd = [lgnd '''Adams'''];         case 5	% Adams-Moulton            [V,y] = AdamsMoulton(fname,0,VR,h,[X0,T0],T0,CA0,FA0,U,a,Ta);            if k > 1               lgnd = [lgnd ','];            end            lgnd = [lgnd '''Adams-Moulton'''];         end         x(k,:) = y(1,:);	% Conversion         t(k,:) = y(2,:);	% Temperature      end      if met         clf         % Plotting the results         subplot(2,1,1), plot(V/VR,x(1:lmethod,:))         ylabel('Conversion, X(%)')         title('(a) Acetone Conversion Profile')         subplot(2,1,2), plot(V/VR,t(1:lmethod,:))         xlabel('V/V_R')         ylabel('Temperature, T(K)')         title('(b) Temperature Profile')         lgnd = [lgnd ')'];         eval(lgnd)      end   end   change = input('\n\n Do you want to repeat the solution with different input data (0/1)? ');end