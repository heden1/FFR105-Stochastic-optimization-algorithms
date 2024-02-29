%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pubLocation = LoadPubLocations();
numberOfPubs = length(pubLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 50;  %% Changes allowed
alpha = 2.0;        %% Changes allowed
beta = 3.0;         %% Changes allowed
rho = 0.5;          %% Changes allowed
tau0 = 0.3;         %% Changes allowed

targetPathLength = 99.9999999; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 850 0 450];
InitializeTspPlot(pubLocation,range)
tspFigure = InitializeTspPlot(pubLocation, range);
connection = InitializeConnections(pubLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfPubs, tau0); % To do: Write the InitializePheromoneLevels
visibility = GetVisibility(pubLocation);                         % To do: write the GetVisibility function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfPubs);
pathLengthCollection = zeros(numberOfAnts,1);

while iIteration<100%(minimumPathLength > targetPathLength)
 iIteration = iIteration + 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Generate paths:
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function
  pathLength = GetPathLength(path,pubLocation);                  % To do: Write the GetPathLength function
  if (pathLength < minimumPathLength)
    minimumPathLength = pathLength;
    disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
    PlotPath(connection,pubLocation,path);
  end
 pathCollection(k,:)=path;
 pathLengthCollection(k) = pathLength; 
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update pheromone levels
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  % To do: write the ComputeDeltaPheromoneLevels function
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          % To do: write the UpdatePheromoneLevels function

end

[foundMinimumPathLength,index] = min(pathLengthCollection);
bestPath=pathCollection(index,:);
disp(sprintf('Best path that was found was of length %.5f',foundMinimumPathLength));
%save ('bestPath.m', 'bestPath')

bestPathStr = mat2str(bestPath);
dlmwrite('BestResultFound.m',bestPathStr,'delimiter','')







