% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the
% polynomialCoefficients (see also GetPolynomialValue)
function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    derivativeCoefficients=polynomialCoefficients;
    for i=1:derivativeOrder
        polynomialExponets=0:(length(derivativeCoefficients)-1);
        derivativeCoefficients=derivativeCoefficients.*polynomialExponets; 
        derivativeCoefficients=derivativeCoefficients(2:end);
    end
end 
