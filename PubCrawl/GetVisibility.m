function visibility = GetVisibility(cityLocation)
%get all lengths from every point ot another   50 cyties 50X50 cities
%Hoewer set the lent to > = 
numberOfCities=size(cityLocation,1);
visibility=zeros(numberOfCities);
for i=1:numberOfCities
    for j=1:numberOfCities

        cityLocation1=cityLocation(i,:);
        cityLocation2=cityLocation(j,:);
        distance=norm(cityLocation1-cityLocation2);
        if distance~=0
            visibility(i,j)=1/distance;
        end
    end
end
end