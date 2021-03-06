function X = tri(n, A, D, C, B)
% This function is used in the script diff_implicit.m
% AUTHOR: Dwight Townsend 7/11/2011
%
% INPUTS: n - 
%         A -
%         B - 
%         C - 
%         D - 
%
% OUTPUT: X 

for i = 2:n
    D(i) = D(i) - (A(i-1)/D(i-1))*C(i-1);
    B(i) = B(i) - (A(i-1)/D(i-1))*B(i-1);
end

X(n) = B(n)/D(n);

for i = n - 1:-1:1
    X(i) = (B(i) - C(i)*X(i+1))/D(i);
end
    