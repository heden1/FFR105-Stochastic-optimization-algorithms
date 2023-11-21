cityLocation = LoadCityLocations;
nCities = size(cityLocation,1);
path = randperm(nCities);                
tspFigure = InitializeTspPlot(cityLocation,[0 200 0 200]); 
connection = InitializeConnections(cityLocation); 
PlotPath(connection,cityLocation,path);     