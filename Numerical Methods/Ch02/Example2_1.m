% Example 2_1.m% Solution to Example 2.1. This program calculates the% interface temperatures in an insulated pipe system. % It calls the function GAUSS.M to solve the heat transfer% equations for temperature simultaneously.(p98)clcclear% Input dataTs = input(' Temperature of steam (deg C) = ');Ta = input(' Temperature of air (deg C)   = ');D1 = 1e-3*input(' Pipe ID (mm) = ');D2 = 1e-3*input(' Pipe OD (mm) = ');Ith = 1e-3*input(' Insulation thickness (mm) = ');D3 = (D2 + 2*Ith);		% Diameter of pipe with insulationhi = input(' Inside heat transfer coefficient (W/m2.K)  = ');ho = input(' Outside heat transfer coefficient (W/m2.K) = ');ks = input(' Heat conductivity of steel (W/m.K)      = ');ki = input(' Heat conductivity of insulation (W/m.K) = ');% Matrix of coefficientsA = ...[2*ks/log(D2/D1)+hi*D1 , -2*ks/log(D2/D1) , 0ks/log(D2/D1) , -(ks/log(D2/D1)+ki/log(D3/D2)) , ki/log(D3/D2)0 , 2*ki/log(D3/D2) , -(2*ki/log(D3/D2)+ho*D3)];% Matrix of constantsc = [hi*D1*Ts ; 0 ; -ho*D3*Ta];% Solving the set of equations by Gauss elimination methodT = Gauss (A , c);% Show the resultsdisp(' '), disp(' Results :')fprintf(' T1 = %4.2f\n T2 = %4.2f\n T3 = %4.2f\n',T)