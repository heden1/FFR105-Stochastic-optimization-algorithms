function [maximumFitness, bestchromosome] = RunFFNNOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, ...
tournamentSize, tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations,nIn, nHidden, nOut,lookingBackLength,epsilon)



 format long
 population = InitializePopulation(populationSize,numberOfGenes);
 fitnessListValidation = zeros(1,numberOfGenerations);
 bestFitnessListTraning = zeros(1,numberOfGenerations);
 for generation = 1:numberOfGenerations
   maximumFitness  = 0.0;
   fitnessListTraining = zeros(1,populationSize);
   
   for i = 1:populationSize
     chromosome = population(i,:);
     [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, maximumVariableValue);
     fitnessListTraining(i) = EvaluateIndividual(wIH, wHO,1);
     
     if (fitnessListTraining(i) > maximumFitness ) 
        maximumFitness  = fitnessListTraining(i);
        iBestIndividual = i;
        bestchromosome = chromosome;
     end

     
     
   end
  
   bestFitnessListTraning(generation)=maximumFitness;
   [wIH, wHO] = DecodeChromosome(bestchromosome, nIn, nHidden, nOut, maximumVariableValue);
   fitnessListValidation(generation) = EvaluateIndividual(wIH, wHO,2);
     if generation>lookingBackLength
        if abs(max(fitnessListValidation(generation-lookingBackLength:generation))-min(fitnessListValidation(generation-lookingBackLength:generation)))<epsilon %&& fitnessListValidation(generation)>5000
            numberOfGenerations=generation;
            disp(generation)
            break
        end
     end

 
   temporaryPopulation = population;  
   for i = 1:2:populationSize
    i1 = TournamentSelect(fitnessListTraining,tournamentProbability,tournamentSize);
    i2 = TournamentSelect(fitnessListTraining,tournamentProbability,tournamentSize);
    r = rand;
    if (r < crossoverProbability) 
     individual1 = population(i1,:);
     individual2 = population(i2,:);
     newIndividualPair = Cross(individual1, individual2);
     temporaryPopulation(i,:) = newIndividualPair(1,:);
     temporaryPopulation(i+1,:) = newIndividualPair(2,:);
    else
     temporaryPopulation(i,:) = population(i1,:);
     temporaryPopulation(i+1,:) = population(i2,:);     
    end
   end
  
   temporaryPopulation(1,:) = population(iBestIndividual,:);
   for i = 2:populationSize
     tempIndividual = Mutate(temporaryPopulation(i,:),mutationProbability);
     temporaryPopulation(i,:) = tempIndividual;
   end
   population = temporaryPopulation;

 end
 figure;
 plot(1:numberOfGenerations,fitnessListValidation(1:numberOfGenerations),'DisplayName','Validation-set');
 hold on 
 plot(1:numberOfGenerations,bestFitnessListTraning(1:numberOfGenerations),'DisplayName','Traning-set');
 hold off
 legend


end