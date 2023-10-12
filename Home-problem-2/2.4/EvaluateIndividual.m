function fitness = EvaluateIndividual(functionData,chromosome,a,O)
K=size(functionData,1);

cMax=10000;
penalty=0;
if length(chromosome)>400 %m_max =400
    penalty=2;
   
end
    
    A=repmat(a,K,1);
    A(:,1)=functionData(:,1);
for j=1:length(chromosome)
    placeInGene=mod(j-1,4)+1;
    i=chromosome(j);
    if placeInGene==1
        operator=O{i};
        if i==4
            isDivision=true;
        else
            isDivision=false;
        end
        
    elseif placeInGene==2                
        iDestination=i;
    elseif placeInGene==3
        operand1=(A(:,i));
    elseif placeInGene==4
        operand2=(A(:,i));

        if isDivision && ismember(0,operand2)
            A(:,iDestination)=cMax;
        else

            A(:,iDestination)=operator(operand1,operand2);
        end
    end
   
end

gPrime=A(:,1);
error=sqrt(sum((gPrime-functionData(:,2)).^2)/K);
fitness=1/error +penalty;
end
