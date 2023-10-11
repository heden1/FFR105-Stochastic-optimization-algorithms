function pathLength = GetPathLength(path,cityLocation)
previousCityLocation= cityLocation(path(end),:);
pathLength=0;

    for edge=path
        thisCityLocation=cityLocation(edge,:);
        distance=norm(thisCityLocation-previousCityLocation);
        pathLength=pathLength+distance;
        previousCityLocation= thisCityLocation;


    end 


end