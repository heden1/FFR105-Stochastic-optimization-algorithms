%% RunLGP
 


operatorSet=['+','-','*','/'];
A=[0,0,0,0,1,3,-1,2];

minChromosomeLength = 3;
maxChromosomeLength = 17;
populationSize = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 1;                % Do NOT change
%populationSize = 10;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 5;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 5;%300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here 


mutationProbabilitys=[0.02];% 0.005 0.01 0.02 0.03 0.05  0.1 0.2 0.4 0.6 0.8];
numberOfMutationProbabilitys=length(mutationProbabilitys);
j=0; %index for mutationprobabilitys
maximumFitnessList= zeros(numberOfRuns,numberOfMutationProbabilitys);
for mutationProbability=mutationProbabilitys
    j=j+1;
    sprintf('Mutation rate = %0.5f', mutationProbability)
        for i = 1:numberOfRuns 
         [maximumFitness, bestChromosone] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations,minChromosomeLength,maxChromosomeLength,A,operatorSet);
         sprintf('Run: %d, Score: %0.10f \n Error: %0.3f', i, maximumFitness,1/maximumFitness)
         
         maximumFitnessList(i,j) = maximumFitness;
        end
        
end

medianFitnessList=median(maximumFitnessList);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here  ...
for i = 1:length(maximumFitnessList(1,:))
    pMut = mutationProbabilitys(i);
    averageFitness = mean(maximumFitnessList(:,i));
    medianFitness = median(maximumFitnessList(:,i));
    stdFitness = sqrt(var(maximumFitnessList(:,i)));
    sprintf('PMut = %0.4g: Median: %0.10f, Average: %0.10f, STD: %0.10f',pMut, medianFitness, averageFitness, stdFitness)
end
%bestChromosoneStr = mat2str(bestChromosone);
%dlmwrite('BestChromosome.m',bestChromosoneStr,'delimiter','')
