% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).
function PlotIterations(polynomialCoefficients, iterationValues)
    minIterationValue=min(iterationValues);
    maxIterationValue=max(iterationValues);
    plotMargin=(maxIterationValue-minIterationValue)/5;
    
    linearlySpacedVector=linspace(minIterationValue-plotMargin,maxIterationValue+plotMargin,100);
    plot(linearlySpacedVector,GetPolynomialValue(linearlySpacedVector,polynomialCoefficients))
    hold on
   
    plot(iterationValues,GetPolynomialValue(iterationValues,polynomialCoefficients),"o")
    hold off
    end