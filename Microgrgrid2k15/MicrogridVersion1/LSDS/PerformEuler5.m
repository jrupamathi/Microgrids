function [t,x] = PerformEuler3(fun_handle,tspan,x0,h,varargin)
%stable for hmin = 1e-4
t0 = tspan(1); tend = tspan(2);
x=[x0]; t = t0; 

C = [1/5; 3/10; 4/5; 8/9; 1];

A = [ 1/5,          0,           0,            0,         0
      3/40,         9/40,        0,            0,         0
      44/45        -56/15,       32/9,         0,         0
      19372/6561,  -25360/2187,  64448/6561,  -212/729,   0
      9017/3168,   -355/33,      46732/5247,   49/176,   -5103/18656];

B = [35/384, 0, 500/1113, 125/192, -2187/6784, 11/84];

% More convenient storage
A = A.'; 
B = B(:);      
neq = length(x0);

nstages = length(B);
F = zeros(neq,nstages);

hi = h; yi = x0; odefun = fun_handle;ti = t0;
while t<=tend
       
      F(:,1) = feval(odefun,ti,yi,varargin{:});  
      for stage = 2:nstages
        tstage = ti + C(stage-1)*hi;
        ystage = yi + F(:,1:stage-1)*(hi*A(1:stage-1,stage-1));
        F(:,stage) = feval(odefun,tstage,ystage,varargin{:});
      end  
      Fin = yi + F*(hi*B);
  
    x = [x Fin];
    t = t+h
    yi = Fin;
    ti = t;
end    
t = (linspace(t0,tend,size(x,2)));
end

