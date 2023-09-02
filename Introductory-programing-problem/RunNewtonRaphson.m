% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.
function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
x=startingPoint;
iterationValues=[];
diffrenceToConvergens=inf; %sets to infinity to be bigger then tolerance 
    if length(polynomialCoefficients)>2 && nnz(polynomialCoefficients(3:end))>0 %Checks if polynomial is of degree 3 or higher  ([1,1,0] not okay) by checking lentgh if array and if it exsist NonZero (nnz) values in the 3 order place or later  
        while diffrenceToConvergens >tolerance
            fPrimeCoefficients=DifferentiatePolynomial(polynomialCoefficients,1);
            fPrime=GetPolynomialValue(x,fPrimeCoefficients);
            fDoublePrimeCoefficients=DifferentiatePolynomial(polynomialCoefficients,2);
            fDoublePrime=GetPolynomialValue(x,fDoublePrimeCoefficients);
            xNext=StepNewtonRaphson(x,fPrime,fDoublePrime);
            
            diffrenceToConvergens=abs(xNext-x);
            iterationValues(end+1)=x;
            x=xNext;
        end 
        iterationValues(end+1)=x;
    else
        disp("The degree of the polynomial must be 2 or larger")
   
    end