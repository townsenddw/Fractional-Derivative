% diff_explicitb.m
% AUTHOR: Dwight Townsend, 7/6/2011
%
% This is a script to solve a partial differential equation using the
% explicit method.
%
% INPUTS: n - the number of meshpoints to compute
%         k - the step size of the t variable
%         M - the number of steps in t to be computed is M

clear all;
close all;

n = 9;
k = 0.005125;
M = 200;

%% Initialize
h = 1/(n+1);
s = k/h^2;
t = 0;

g = @(x) sin(pi*x);
a = @(t) 0;
b = @(t) 0;

% We still need to get our first w vector
i = 0:n+1;
for j=1:n+2             % Obtain the initial distribution
    w(j) = g(h*i(j));
end

soln = [w];




%% Solution


for j = 1:M
    v(1) = a(j*k);      % First get the end points.
    v(n+2) = b(j*k);
    for i = 1:n         % Then the rest of the stuff.
        v(i+1) = s*w(i) + (1-2*s)*w(i+1) + s*w(i+2);
    end
    t = [t j*k];
    soln = [soln; v];
    w = v;
end


subplot(1,2,1);
[X,T] = meshgrid(linspace(0,1,n+2),t);
surf(X,T,soln);
title('Numeric Solution');
xlabel('x'); ylabel('t'); zlabel('u(x,t)');




%% Exact Solution
x = 0:0.05:1;
t_e = 0:0.05:1;

subplot(1,2,2);
[X,T] = meshgrid(linspace(0,1,n+2),t);
u = exp(-pi^2 .* T) .* sin(pi.*X);
surf(X,T,u);
title('Exact Solution');
xlabel('x'); ylabel('t'); zlabel('u(x,t)');

    
