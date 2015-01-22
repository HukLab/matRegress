function [L,dL,ddL] = posterior(wts,mstruct)
% [L,dL,ddL] = posterior(wts,hprs,mstruct)
%
% Compute negative log-posterior of data under GLM regression model,
% plus gradient and Hessian
%
% INPUTS:
%   wts [m x 1] - regression weights
%  hprs [p x 1] - hyper-parameters for prior
%       mstruct - model structure with fields
%        .neglogli - func handle for negative log-likelihood
%        .logprior - func handle for log-prior 
%        .liargs   - cell array with args to neg log-likelihood
%        .priargs  - cell array with args to log-prior function
%
% OUTPUTS:
%    L [1 x 1] - negative log-posterior
%   dL [m x 1] - Gradient
%  ddL [m x m] - Hessian


if nargout <= 1
    L = mstruct.neglogli(wts,mstruct.liargs{:});
    L = L + mstruct.neglogpr(wts,mstruct.priargs{:});

elseif nargout == 2
    [L,dL] = mstruct.neglogli(wts,mstruct.liargs{:});
    [p,dp] = mstruct.neglogpr(wts,mstruct.priargs{:});
    L = L + p;
    dL = dL + dp;

elseif nargout == 3
    [L,dL,ddL] = mstruct.neglogli(wts,mstruct.liargs{:});
    [p,dp,ddp] = mstruct.neglogpr(wts,mstruct.priargs{:});
    L = L + p;
    dL = dL + dp;
    ddL = ddL + ddp;    
end
