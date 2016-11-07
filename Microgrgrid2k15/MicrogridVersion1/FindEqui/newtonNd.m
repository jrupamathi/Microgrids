function [x0,nf,iter] = newtonNd(fhand,x0,plot,varargin)
% function newtonNd(fhand,x0,itpause)
% 
% INPUTS:
%   fhand - function handle
%   x0    - initial guess
%   plot - plot convergence or not
% 
% Use Newton's method to solve the nonlinear function
% defined by function handle fhand with initial guess x0.  
%

if nargin<3
    error('Must provide three input arguments.  Type ''help newton1d'' for details');
end

tol=1e-10;          % convergence tolerance
maxIters=500;       % max # of iterations
x00=x0;             % initial guess
if ~isempty(varargin)
    maxIters = varargin{1};
end
% Newton loop
for iter=1:maxIters
    [f J]=fhand(x0);            % evaluate function
    dx=-J\f;                    % solve linear system
    nf(iter)=norm(f);            % norm of f at step k+1
    ndx(iter)=norm(dx);          % norm of dx at step k+1
    eps = 1;
    x(:,iter)=(x0+ dx);              % solution x at step k+1
    x0=x(:,iter);                 % set value for next guess
    %Another convergence criteria for very flat functions
    if(nf(iter)<1e-3)
        if iter>1
            crit1 = norm(x(:,iter) - x(:,iter-1));%/(min(abs(x(iter-1)),abs(x(iter))));
        else
            crit1 = norm(x(:,iter) - x00);%/(min(abs(x00),abs(x(iter))));
        end
    else
        crit1 = 0;
    end
    if (nf(iter) < tol)&&(crit1<1e-8)    % check for convergence
        % check for convergence
        fprintf('Converged in %d iterations\n',iter);
        break; 
    end
    iter 
    nf
end

if iter==maxIters, % check for non-convergence
    fprintf('Non-Convergence after %d iterations!!!\n',iter); 
end

% stuff for plotting
k = 1:iter;
xdiff = x(:,k) - x(:,iter)*ones(1,iter);
xnorm= [];
for j = 1:numel(k)
    xnorm(j) = norm(xdiff(:,j));
end
% plot signal on new figure
if(plot==1)
    figure()
    semilogy(k,xnorm)
    grid on
    xlabel('k'),ylabel('||x_k - x^*||')
    title('Rate of convergence analysis');
    % create a new pair of axes inside current figure
    axes('position',[.2 .175 .4 .5])
    box on % put box around new pair of axes
    indexOfInterest = (k > 2) & (k < 10); % range of t near perturbation
    semilogy(k(indexOfInterest),xnorm(indexOfInterest),'LineWidth',2) % plot on new axes
    axis tight
    grid on
end
