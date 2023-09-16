function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)

lengthFitnessList=length(fitnessList);
remaningFitnessList=[];
for j=1:tournamentSize  %pick tourmanetSize many samples from fitness list unifomly with replacment
    randomIndex=randi(lengthFitnessList);
    remaningFitnessList(end+1)=fitnessList(randomIndex);

    %remaningFitnessList=randsample(fitnessList,tournamentSize,true);%pick tourmanetSize many samples from fitness list unifomly with replacment
    remaningFitnessListInDecendOrder=sort(remaningFitnessList,'descend');

    while length(remaningFitnessListInDecendOrder)>=1
        r=rand(1);
        if r<tournamentProbability
            selectedFitness=remaningFitnessListInDecendOrder(1);
            break
        elseif length(remaningFitnessListInDecendOrder)==1
            selectedFitness=remaningFitnessListInDecendOrder;
            break
        else  
            remaningFitnessListInDecendOrder=remaningFitnessListInDecendOrder(2:end);
        end
        
    end

    for i=1:length(fitnessList)
        if selectedFitness==fitnessList(i)
            selectedIndividualIndex=i;
            break
        end
    end

end
