% Example2_2.m% Solution to Example 2.2. This program solves the material% and energy balances equations of a steam distribution% system using the function JORDAN.M.(p110)clcclear% Matrix of coefficientsA = [1, 1, 1, 0*[4:14]1.17, 0, 0, -1, 0*[5:14]0*[1:4], 1, 0*[6:14]0, 0, 1, 0, 1, -1, -1, -1, 0*[9:12], 1, 00*[1:5], 1, 1, 1, 1, -1, -1, 0*[12:14]0*[1:3], 1, 0*[5:12], -1, 01, 0*[2:3], -1, 0*[5:9], 1, 0*[11:13], 10*[1:9], 4.594, 0*[11:13], .110*[1:8], 1, 0*[10:14]0, 1, 0*[3:14]0*[1:5], 1, 0*[7:13], -.01470, 0, 1, 0*[4:11], -.07, 0, 00*[1:6], 1, 0*[8:14]0*[1:9], 1, 0, -1, 0, 1];% Vector of constantsc = [43.93, 0, 95.798, 99.1, -8.4, 24.2, 189.14, 146.55, 10.56, ...     2.9056, 0, 0, 14.6188, -97.9];% SolutionX = Jordan (A , c)