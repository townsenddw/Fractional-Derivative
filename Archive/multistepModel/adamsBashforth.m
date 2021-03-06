%% Adams-Bashforth script 
% This is a script that is going to numerically solve a differential
% equation. 
%
% USES: f.m
%

clear all; close all;
e = 2.71828;


% First things first, let's pick an ODE to solve.
% 
% y'(t) = 1 - t + 4y,   y(0) = 1
% 
% ANALYTICAL SOLN:   y(t) = 1/16(4t + 19e^4t - 3) from WolframAlpha
%
% 

%% Now lets do the real stuff

% First we need use a different numeric method to get the first three
% points. I will use RK 4th order.

h = 0.0001;         % Time step
y0 = 0;          % Initial y
t0 = 0;          % Initial t
tn = 1.5;         % Final t
n = (tn-t0)/h;   % # of iterations

% Define initial array
t = zeros(n,1); t(1) = t0;
y = zeros(n,1); y(1) = y0;

for i = 1:3
    k1 = f(t(i), y(i));
    k2 = f(t(i) + (h/2), y(i) + (h/2)*k1);
    k3 = f(t(i) + (h/2), y(i) + (h/2)*k2);
    k4 = f(t(i) + h, y(i) + h*k3);
    y(i+1) = y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    t(i+1) = t(i) + h;
end

% Now we will integrate the rest of it using Adams-Bashforth 
% TO DO: Clean up so that it doesn't reevalute every single thing.

for i = 4:n
	y(i+1) = y(i) + (h/24)*(55*f(t(i),y(i)) - 59*f(t(i-1), y(i-1)) + 37*f(t(i-2),y(i-2)) - 9*f(t(i-3),y(i-3)));
	t(i+1) = t(i) + h;
end




%% Calculate real solution
tr = 0:0.01:1;
yr = (1/16)*(4*tr + 19*e.^(4*tr) - 3);

figure()
% plot(t,y,'*');
plot(t,y)









