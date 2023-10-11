function population = InitializePopulation(populationSize,minChromosomeLength,maxChromosomeLength,geneRange)

population = [];
for i = 1:populationSize
 chromosomeLength = randi([ceil(minChromosomeLength/4),floor(maxChromosomeLength/4)])*4; %minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
 tmpChromosome = GenerateChromosone(chromosomeLength,geneRange);%randi (8,[1,chromosomeLength]);%fix(2*rand(chromosomeLength,1));
 tmpIndividual = struct('Chromosome',tmpChromosome);
 population = [population; tmpIndividual];
end
