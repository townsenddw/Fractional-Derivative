%% Srcipt for Fractional discretization of the Caputo form
% This is a script that will solve the fradctional differential diffusion
% equation. We will be using an implicit method.
%
%
% AUTHOR       : Dwight Townsend
% VERSION      : 1.0
% DEPENDENCIES : mlf.m
% CAVEATS      : This script only works when 0<fdorder<1!

clear all;
close all;

%% Constant Definitions

K = 1;           % The diffusion constant
fdorder = 0.75;     % The fractional order of the derivative
dx = pi()/20;    % Spatial step size
dt = 0.005;       % Time step size
n = 2.5;          % Stop time
xStart = 0;
xEnd = pi();


x = xStart:dx:xEnd;              % Spatial Array
t = 0:dt:n;                      % Time array

%% Set up the Solution Matrix
U = zeros(n/dt + 1, (xEnd - xStart)/dx + 1);

%% Boundary Conditions and Initial Conditions

% u(x=0, t) = u(x=pi, t) = 0
U(:,1) = 0;
U(:,end) = 0;

% u(x,0) = f(x) = sin(x)
U(1,:) = sin(x);

%% Exact Solution
% This is to test the error our numerical method. This should be commented
% if this script is being used for real.

%[X, T] = meshgrid(0:dx:xEnd, 0:dt:n);
%exact = mlf(fdorder,1,-T.^fdorder,3) .* sin(X);


%% Numerical Solution

% Build the A []
mu = (dt^fdorder)/(dx^2);
r = mu * gamma(2-fdorder);
A1 = diag((1+2*r)*ones(length(x)-2,1));  % Center diagonal
A2 = diag(-r*ones(length(x)-3,1),1);   % Upper diagonal
A3 = diag(-r*ones(length(x)-3,1),-1);  % Lower diagonal

A = A1 + A2 + A3; % This is the final Matrix A

% Take the first step
U(2,2:end-1) = A \ U(1,2:end-1)'; % Done Son!!!

% Create the b_j
j = 0:length(t);
b_j = (j+1).^(1-fdorder) - j.^(1-fdorder); 

% Neccesary for fdorder = 1
%b_j(1) = 1;

c_j = b_j(1:end-1) - b_j(2:end);

%% Rest of the APPROX
% Now take the rest of the steps. Inorder to do this easily, we will create
% take a subset of U and redefine so that it makes the row numbers
% corespond to there k-values
V = U(2:end,2:end-1);

for k = 1:length(V)-1
   V(k+1,:) = A \ nextStep(V,U(1,2:end-1),k,b_j,c_j)';
end


% Put it all together

U(2:end,2:end-1) = V;


%% Display the Solution

figure(1); surf(x,t,U,'LineStyle','none'); title('approx');
xlabel('displacement (x)'); ylabel('time (sec) (t)'); zlabel('U(x,t)');

% figure(2); surf(x,t,exact,'LineStyle','none'); title('exact');
%xlabel('displacement (x)'); ylabel('time (sec) (t)'); zlabel('u(x,t)');
%figure(3); surf(x,t,U - exact,'LineStyle','none'); title('diff');














