% Example4_3.m% Solution to Example 4-3. It calculates carbon dioxide evolved and% oxygen uptaken in a fermentation process using TRAPZ (trapezoidal% rule) and SIMPSON (Simpson's 1/3 rule) functions.(p241)clearclc% Input datat = input(' Vector of time = ');r_CO2 = input(' Carbon dioxide evolution rate (g/h) = ');r_O2 = input(' Oxygen uptake rate (g/h) = ');% Integrationm1CO2 = trapz(t,r_CO2);m2CO2 = Simpson(t,r_CO2);m1O2 = trapz(t,r_O2);m2O2 = Simpson(t,r_O2);% Outputfprintf('\n Total carbon dioxide evolution  = %9.4f (evaluated by the trapezoidal rule)',m1CO2)fprintf('\n Total carbon dioxide evolution  = %9.4f (evaluated by the Simpson 1/3 rule)',m2CO2)fprintf('\n Total oxygen uptake             = %9.4f (evaluated by the trapezoidal rule)',m1O2)fprintf('\n Total oxygen uptake             = %9.4f (evaluated by the Simpson 1/3 rule)\n',m2O2)