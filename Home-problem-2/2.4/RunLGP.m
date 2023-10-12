%% RunLGP
operatorSet={@add @subtract @multi @division};
constantRegister=[1,3,-1];

M=3;% number of variabel registers 
N=length(constantRegister);% number of constantRegister
numberOfOperand=M+N;
numberOfOperators=length(operatorSet);
variableRegister=zeros(1,M);



A=[variableRegister,constantRegister];
genRange=[numberOfOperators,M,numberOfOperand,numberOfOperand];

minChromosomeLength = 4;
maxChromosomeLength = 100;
populationSize = 200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 10;               

maximumVariableValue = 5;          
numberOfGenes = 5;             
numberOfVariables = 2;		  
numberOfGenerations = 10000;     
tournamentSize = 5;              
tournamentProbability = 0.75;    
crossoverProbability = 0.75;  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalMaximumFitness=0;
mutationProbabilitys=[0.02];
numberOfMutationProbabilitys=length(mutationProbabilitys);
j=0; %index for mutationprobabilitys
maximumFitnessList= zeros(numberOfRuns,numberOfMutationProbabilitys);
for mutationProbability=mutationProbabilitys
    j=j+1;
    sprintf('Mutation rate = %0.5f', mutationProbability)
        for i = 1:numberOfRuns 
         [maximumFitness, bestChromosone] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations,minChromosomeLength,maxChromosomeLength,A,operatorSet,genRange);
         sprintf('Run: %d, Score: %0.10f \n Error: %0.3f', i, maximumFitness,1/maximumFitness)
         if maximumFitness>totalMaximumFitness
             totalMaximumFitness=maximumFitness;
             totalBestChromosone=bestChromosone;
         end
         
         maximumFitnessList(i,j) = maximumFitness;
        end
        
end

bestChromosoneStr = mat2str(totalBestChromosone);
dlmwrite('BestChromosome.m',bestChromosoneStr,'delimiter','')




medianFitnessList=median(maximumFitnessList);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i = 1:length(maximumFitnessList(1,:))
    pMut = mutationProbabilitys(i);
    averageFitness = mean(maximumFitnessList(:,i));
    medianFitness = median(maximumFitnessList(:,i));
    stdFitness = sqrt(var(maximumFitnessList(:,i)));
    sprintf('PMut = %0.4g: Median: %0.10f, Average: %0.10f, STD: %0.10f',pMut, medianFitness, averageFitness, stdFitness)
end

