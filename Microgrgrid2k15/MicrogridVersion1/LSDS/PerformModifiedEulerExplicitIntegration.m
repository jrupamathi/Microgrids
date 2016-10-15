function [t,x] = PerformModifiedEulerExplicitIntegration(fun_handle,tspan,x0,h,y)
%stable for hmin = 1e-4
t0 = tspan(1); tend = tspan(2);
x=[x0]; t = t0; 

while t<=tend
    if(nargin>4)
        a = fun_handle(t,x(:,end),y);
        xnew = x(:,end) + h*a;
        Fin = x(:,end) + (h/2)*(a + fun_handle(t,xnew,y));
    else
        a = fun_handle(t,x(:,end));
        xnew = x(:,end) + h*a;
        a1 =  fun_handle(t,xnew);
        Fin = x(:,end) + (h/2)*(a + a1);
    end
    x = [x Fin];
    t = t+h
end    
t = (linspace(t0,tend,size(x,2)));
end

