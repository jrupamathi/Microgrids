function [t,x] = PerformEuler4(fun_handle,tspan,x0,h,varargin)
%stable for hmin = 1e-4
t0 = tspan(1); tend = tspan(2);
x=[x0]; t = t0; 

hi = h; yi = x0; odefun = fun_handle;ti = t0;
while t<=tend
    a1 = feval(odefun,ti,yi,varargin{:});
  a2 = feval(odefun,ti+0.5*hi,yi+0.5*hi*a1,varargin{:});
  a3 = feval(odefun,ti+0.5*hi,yi+0.5*hi*a2,varargin{:});  
  a4 = feval(odefun,ti,yi+hi*a3,varargin{:});
  Fin = x(:,end) + (hi/6)*(a1 + 2*a2 + 2*a3 + a4);
        
    x = [x Fin];
    t = t+h
    yi = Fin;
    ti = t;
end    
t = (linspace(t0,tend,size(x,2)));
end

