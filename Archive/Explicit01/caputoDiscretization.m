%% explicit01 - Script for Fraction diffusion discretiaztion of the Caputo form
% This is a to solve the fractional derivative for a fdorder (gamma) of 0
% to 1. Thanks to John Jasbinsek(J^3) for the inspiration.
%
%
% AUTHOR       : Dwight Townsend
% VERSION      : 1.0
% DEPENDENCIES : isStable.m, bcoeff.m, mlf.m, nextStep.m

clearvars -except hotStuff;
close all;

%% Constant Definitions

K = 1;           % The diffusion constant
fdorder = .5;     % The fractional order of the derivative
dx = pi()/10;    % Spatial step size
dt = 0.001;       % Time step size
n = 2.5;          % Stop time
xStart = 0;
xEnd = pi();


x = 0:dx:xEnd;                   % Spatial Array
t = 0:dt:n;                      % Time array
S = K * ((dt^fdorder)/(dx^2));   % Stability Factor
S_bar = gamma(2 - fdorder) * S;  % Modified Stability Factor

%% Check for Stability
if ~isStable(S, fdorder)
    error('The system is not stable. Please, for the love of god, choose a different dx or dt');
end
    

%% Set up the Solution Matrix
U = zeros(n/dt + 1, (xEnd - xStart)/dx + 1);

%% Boundary Conditions and Initial Conditions

% u(x=0, t) = u(x=pi, t) = 0
U(:,1) = 0;
U(:,end) = 0;

% u(x,0) = f(x) = sin(x)
U(1,:) = sin(x);

%% Exact Solution
[X, T] = meshgrid(0:dx:xEnd, 0:dt:n);
exact = mlf(fdorder,1,-T.^fdorder,3) .* sin(X);

%% Numerical Solution

% Set up the b^fdorder_k array and difference matrix
k = 1:length(t)-2;
bOfK = bcoeff(k,fdorder);
diff = [];

% Compute values for each time step
tic;
for m = 1:length(t) - 1
    % It is from 2 to end - 1 because of the B.C.
    [U(m+1,2:end-1) diff] = nextStep(U, m, S_bar, diff, bOfK);
end
toc



figure(1); surf(x,t,exact,'LineStyle','none'); title('exact');
xlabel('displacement (x)'); ylabel('time (sec) (t)'); zlabel('u(x,t)');
figure(2); surf(x,t,U,'LineStyle','none'); title('approx');
xlabel('displacement (x)'); ylabel('time (sec) (t)'); zlabel('U(x,t)');

figure(3); surf(x,t,U - exact,'LineStyle','none'); title('diff');
hotStuff = U(15,:);