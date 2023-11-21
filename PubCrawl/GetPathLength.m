function pathLength = GetPathLength(path,cityLocation)
previousCityLocation= cityLocation(path(1),:);
pathLength=0;

    for edge=path(2:end)
        thisCityLocation=cityLocation(edge,:);
        distance=norm(thisCityLocation-previousCityLocation);
        pathLength=pathLength+distance;
        previousCityLocation= thisCityLocation;


    end 


end