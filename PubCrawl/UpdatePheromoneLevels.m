function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
pheromoneLevel=pheromoneLevel*(1-rho)+deltaPheromoneLevel;
pheromoneLevel(pheromoneLevel < 10^(-15)) = 10^(-15);
end