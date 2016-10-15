function [t,x] = PerformEuler3(fun_handle,tspan,x0,h,varargin)
%stable for hmin = 1e-4
t0 = tspan(1); tend = tspan(2);
x=[x0]; t = t0; 

hi = h; yi = x0; odefun = fun_handle;ti = t0;
while t<=tend
        a1 = feval(odefun,ti,yi,varargin{:});
        a2 = feval(odefun,ti+0.5*hi,yi+0.5*hi*a1,varargin{:});
        a3 = feval(odefun,ti+0.75*hi,yi+0.75*hi*a2,varargin{:});  
        Fin = yi + (hi/9)*(2*a1 + 3*a2 + 4*a3);
    x = [x Fin];
    t = t+h
    yi = Fin;
    ti = t;
end    
t = (linspace(t0,tend,size(x,2)));
end

