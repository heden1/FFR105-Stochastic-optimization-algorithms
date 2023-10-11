function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    lengthFitnessList=length(fitnessList);
    
    choosenInduviduals=zeros(2,tournamentSize);
    for j=1:tournamentSize
        randomIndex=randi(lengthFitnessList);
        choosenInduviduals(1,j)=fitnessList(randomIndex);
        choosenInduviduals(2,j)=randomIndex;
    end
    
    remaningIndividualsInDecendOrder= transpose(sortrows(transpose(choosenInduviduals),'descend'));%sort colums in matrix by fitness highest to lowest
    while length(remaningIndividualsInDecendOrder(:,1))>=1
            r=rand(1);
            if r<tournamentProbability
                selectedIndividualIndex = remaningIndividualsInDecendOrder(2,1);
                break
            elseif length(remaningIndividualsInDecendOrder(1,:))==1
                selectedIndividualIndex = remaningIndividualsInDecendOrder(2,1);
                break
            else  
                remaningIndividualsInDecendOrder(:,1) = [];%delet the largest fitness value and its coresponding index
            end   
    end
end
