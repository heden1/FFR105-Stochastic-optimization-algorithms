function population = InitializePopulation(populationSize,minChromosomeLength,maxChromosomeLength)

population = [];
for i = 1:populationSize
 chromosomeLength = randi([ceil(minChromosomeLength/4),floor(maxChromosomeLength/4)])*4; %minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
 tmpChromosome = randi (4,[chromosomeLength,1]);%fix(2*rand(chromosomeLength,1));
 tmpIndividual = struct('Chromosome',tmpChromosome);
 population = [population tmpIndividual];
end
