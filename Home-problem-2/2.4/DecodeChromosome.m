% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
    m=length(chromosome);
    n=numberOfVariables;
    k=m/n;
    a=maximumVariableValue;
    exponent=1:k;
    scalarComponentsForGene=(2*ones(1,k)).^(-exponent);
    
    x=[];
    genes= reshape(chromosome,k,[]);
    for gen=genes
        sumOfGen=dot(scalarComponentsForGene,gen);
        rangeCorrectionTerm=-a+(2*a/(1-2^(-k)));
        x(end+1)=rangeCorrectionTerm*sumOfGen;
    end
end