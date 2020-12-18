% Example3_1.m% Solution to Example 3-1. It interpolates the time-temperature data% given in Table E3-1 by Gregory-Newton forward interpolation % formula and finds the maximum temperature and the time this% maximum happened.(p175)clcclearclf% Input datatime = input(' Vector of time = ');temp = input(' Vector of temperature = ');ti = linspace(min(time),max(time));	% Vector of time for interpolationredo = 1;while redo   disp(' ')   n = input(' Order of interpolation = ');   te = GregoryNewton(time,temp,ti,n);	% Interpolation   [max_temp,k] = max(te);   max_time = ti(k);   % Show the results   fprintf('\n Maximum temperature of %4.1f C reached at %5.2f.\n', ...      max_temp,max_time)   % Show the results graphically   plot(time,temp,'o',ti,te)   xlabel('Time (hr)')   ylabel('Temperature (deg C)')   disp(' ')   redo = input(' Repeat the calculation (1/0) : ');end