function [t,x] = PerformEulerExplicitIntegration(fun_handle,tspan,x0,h)
%stable for hmin = 1e-4
t0 = tspan(1); tend = tspan(2);
x=[x0]; t = t0; 
while t<=tend
    x = [x (x(:,end) + h*fun_handle(t,x(:,end)))];
    t = t+h
end    
t = linspace(t0,tend,size(x,2));
% x = transpose(x);
end