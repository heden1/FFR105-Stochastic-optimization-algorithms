% This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.
function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)
    if fDoublePrime~=0
        xNext=x-fPrime/fDoublePrime;
    else
        fprintf('f''''(x) = 0 when x = %g. \nWhich makes the next step in the Newton-Raphson method unaccessible. \n',x)
        xNext=NaN;
    end
end 
