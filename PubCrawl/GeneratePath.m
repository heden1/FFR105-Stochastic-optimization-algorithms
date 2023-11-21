function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
[rows,columns]=size(pheromoneLevel);

tabuList=[];
jFrom=randi(rows,1);
path=[jFrom];
tabuList(end+1)=jFrom;
posibleMoves=1:columns;
posibleMoves(ismember(posibleMoves,tabuList))=[];


while length(posibleMoves)>0
     nodeProbabilitys=[];
     
     sumOfPossiblePaths=sum((pheromoneLevel(jFrom,posibleMoves).^alpha).*(visibility(jFrom,posibleMoves).^beta));%Should the sum include the from point or not 

    for iTo=posibleMoves
        nodeProbabilitys(end+1)=(pheromoneLevel(jFrom,iTo)^alpha)*(visibility(jFrom,iTo)^beta)/sumOfPossiblePaths;

    end 
    %nodeProbabilitysSorted=sort(nodeProbabilitys)

    %RWS
    cp = [0,cumsum(nodeProbabilitys)];
    r = rand;
    ind = find(r>cp, 1, 'last');

    
    choosenMove=posibleMoves(ind);
    jFrom=choosenMove;
    path(end+1)=jFrom;
    tabuList(end+1)=jFrom;
    
    posibleMoves(ismember(posibleMoves,tabuList)) = [];%flytta ner till efter bestmd i 
    

end



end