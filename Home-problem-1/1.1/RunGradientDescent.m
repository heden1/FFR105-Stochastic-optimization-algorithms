% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    gradF = ComputeGradient(xStart,mu);
    x=xStart;
    while norm(gradF)> gradientTolerance
        for i=1:length(x)
            x(i)=x(i)-gradF(i)*etfa;
        end
        gradF = ComputeGradient(x,mu);
    
    end
end
