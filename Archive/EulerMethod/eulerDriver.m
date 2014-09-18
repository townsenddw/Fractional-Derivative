%% Euler Method Driver
% Dwight Townsend
% 6/25/11
%
% We are going to solve the DE dy/dt = K(y-s), where K and s are constants.
% with y(0) = y0
% 
% ANALYTICAL SOLUTION:
% This is a separable equation   , so 
% 1/(y-s) dy = K dt              , then integrate both sides
% int 1/(y-s) dy = int K dt + C  , use a u-sub on the LHS, u = y-s
% ln(y-s) = Kt + C
% y-s = e^(Kt + C) = e^Kt * e^C = Ce^Kt
% y(t) = Ce^Kt + s
% y(0) = C + s = y0              , apply initial condition y(0) = y0
% C = y0 - s
% 
% y(t) = (y0-s)e^Kt + s          , and here is your final solution.
%
%

%% Now lets do this shit numerically!!!!!!
clear all; close all;

% Set up time vector
t = 0:0.01:5;

% This plots the exact analytical solution
plot(t,yexact(t,100,1,20));

%% Time to get our hands dirty

% Euler's Method for solving dy/dt = K * (y - s)
K = 1;
s = 20;
y0 = 100;


numpts = 50;
dt = 0.1;

% set up the arrays first and then we'll manipulate them.
y = zeros(numpts,1);
t = zeros(numpts,1);

% initial conditions
y(1) = y0;
t(1) = 0.0;

% now the magic i.e. loop it up
for i = 1:numpts-1
    y(i+1) = y(i) + dt*K*(y(i) - s);
    t(i+1) = t(i) + dt;
end

% Plotting the numerical approximation
figure()
plot(t,yexact(t,100,1,20),t,y);

    
    
    
    
    
    



