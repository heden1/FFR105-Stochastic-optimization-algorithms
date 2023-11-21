function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
numberOfPaths=size(pathCollection,1);
lengthOfPaths=size(pathCollection,2);
deltaPheromoneLevel=zeros(lengthOfPaths);
for k=1:numberOfPaths
    for node=1:lengthOfPaths
        nextNode=mod(node,lengthOfPaths)+1;
        jFrom=pathCollection(k,node);
        iTo=pathCollection(k,nextNode);
        deltaPheromoneLevel(jFrom,iTo)=1/pathLengthCollection(k);
    end
    
end






end
