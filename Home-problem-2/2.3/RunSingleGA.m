%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

populationSize = 100;         
maximumVariableValue = 5;         

nHidden=5;%(around 3-10, say) for the number of hidden neurons (nh).
nOut=2;
nIn=3;
numberOfGenes = (nIn+1)*nHidden+nOut*(nHidden+1);   

numberOfVariables = 2;  	  

tournamentSize = 3;               
tournamentProbability = 0.75;   
crossoverProbability = 0.75;      
mutationProbability = 0.02;
maxNumberOfGenerations = 100000;

% Hold out validation parameter
lookingBackLength=1000;
epsilon=1;


[maximumFitness, bestChromosome] = RunFFNNOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, maxNumberOfGenerations,nIn, nHidden, nOut,lookingBackLength,epsilon);

sprintf('Fitness: %f, ', maximumFitness)
bestChromosomeStr = mat2str(bestChromosome);
dlmwrite('BestChromosome.m',bestChromosomeStr,'delimiter','')


fitnessTest=zeros(1,5);
for iSlope=1:5

fitnessTest(iSlope)=RunTest(bestChromosome,nIn,nHidden,nOut,maximumVariableValue,iSlope);
end
sprintf('Fitness test min: %f, ', min(fitnessTest))
sprintf('Fitness test mean: %f, ', mean(fitnessTest))
