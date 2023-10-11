function mutatedIndividual = Mutate(individual, mutationProbability,genRange)
    nGenes = size(individual, 2);
    mutatedIndividual = individual;

    for j = 1:nGenes
        r = rand;
        if (r < mutationProbability)
            iRange=mod(j-1,4)+1;
            maxRange=genRange(iRange);
            mutatedIndividual(j) = randi(maxRange);
        end
    end
end
