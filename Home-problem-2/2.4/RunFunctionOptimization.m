function [maximumFitness, bestChromosone] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, ...
tournamentSize, tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations,minChromosomeLength,maxChromosomeLength,A,O);

 format long

 maximumFitness  = 0;

 functionData=LoadFunctionData;


population = InitializePopulation(populationSize,minChromosomeLength,maxChromosomeLength);

 %population = InitializePopulation(populationSize,numberOfGenes);
 for generation = 1:numberOfGenerations
   maximumFitness  = 0.0;
   fitnessList = zeros(1,populationSize);
   for i = 1:populationSize
     chromosome = population(i).Chromosome;%population(i,:);
     %variableValues = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);
     fitnessList(i) = EvaluateIndividual(functionData,chromosome,A,O);%fitnessList(i) = EvaluateIndividual(variableValues);
     if (fitnessList(i) > maximumFitness ) 
        maximumFitness  = fitnessList(i);
        iBestIndividual = i;
        bestChromosone=chromosome;
        %bestVariableValues = variableValues;
    end
   end
 
   temporaryPopulation = population;  
   for i = 1:2:populationSize
    i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
    i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
    r = rand;
    if (r < crossoverProbability) 
     individual1 = population(i1).Chromosome;%population(i1,:);
     individual2 = population(i2).Chromosome;%population(i2,:);
     [newIndividual1,newIndividual2] = Cross(individual1, individual2);
     temporaryPopulation(i).Chromosome=newIndividual1;%temporaryPopulation(i,:) = newIndividualPair(1,:);
     temporaryPopulation(i+1).Chromosome=newIndividual2;%temporaryPopulation(i+1,:) = newIndividualPair(2,:);
    else
     temporaryPopulation(i).Chromosome=population(i).Chromosome;%temporaryPopulation(i,:) = population(i1,:);
     temporaryPopulation(i+1).Chromosome=population(i2).Chromosome;%temporaryPopulation(i+1,:) = population(i2,:);     
    end
   end
  
   temporaryPopulation(1).Chromosome=population(iBestIndividual).Chromosome;%temporaryPopulation(1,:) = population(iBestIndividual,:);
   for i = 2:populationSize
     tempIndividual = Mutate(temporaryPopulation(i).Chromosome,mutationProbability);
     temporaryPopulation(i).Chromosome = tempIndividual;
   end
   population = temporaryPopulation;

 end

end