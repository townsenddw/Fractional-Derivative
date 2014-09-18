function [ Unext ] = nextStep( U, m ,fdorder, S_bar )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% Spatial Stencil Stuff
row_left   = U(m,1:end-2);
row_right  = U(m,3:end);
row_center = U(m,2:end-1);

Uspatial = row_center + S_bar.*(row_left - 2*row_center + row_right);
Utemporal = theSumVec(U, m, fdorder);

Unext = Uspatial - Utemporal;
end

