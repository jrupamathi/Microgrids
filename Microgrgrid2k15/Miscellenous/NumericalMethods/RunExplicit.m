function RunExplicit
%needs h = 1e-4 
A = [1 2 3; 2 3 4; 3 2 1];
tspan = [0,10]; x0 = ones(3,1);
[t1,x1] = ode45(@RunDynamics,tspan,x0);

%Explicit method starts
t0 = tspan(1);tend = tspan(2);
x=[x0];t = t0; h=1e-2;
while t<=tend
    x = [x (x(:,end) + h*RunDynamics(t,x(:,end)))];
    t = t+h
end
    
function dx = RunDynamics(t,x)
    dx = A*x;%exp(sin(x^2));
end
t = linspace(t0,tend,size(x,2));
plot(t,x(1,:),'b--','linewidth',2);hold on;
plot(t1,x1(:,1),'g-.')
end