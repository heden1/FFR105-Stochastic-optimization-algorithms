function [newIndividual1,newIndividual2] = Cross(individual1, individual2)
    nGenes1 = size(individual1, 1); 
    nGenes2 = size(individual2, 1); 

    crossoverPoints1=randi([1,ceil(nGenes1/4)],1,2)*4;
    crossoverPoints1=sort(crossoverPoints1);
    crossoverPoints2=randi([1,ceil(nGenes2/4)],1,2)*4;
    crossoverPoints2=sort(crossoverPoints2);

    induvidula1CrossContribution=individual1(crossoverPoints1(1)+1:crossoverPoints1(2));
    individual1(crossoverPoints1(1)+1:crossoverPoints1(2))=[];
    induvidula2CrossContribution=individual2(crossoverPoints2(1)+1:crossoverPoints2(2));
    individual2(crossoverPoints2(1)+1:crossoverPoints2(2))=[];

    newIndividual1=Insert(induvidula2CrossContribution,individual1,crossoverPoints1(1)-1);
    newIndividual2=Insert(induvidula1CrossContribution,individual2,crossoverPoints2(1)-1);

end
