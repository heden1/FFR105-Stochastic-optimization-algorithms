% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);

m=length(chromosome);
n=numberOfVariables;
k=m/n;
a=maximumVariableValue;
x=-a+(2*a/(1-2^(-k)))*