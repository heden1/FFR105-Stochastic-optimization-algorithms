% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(functionData,chromosome,a,O)
K=size(functionData,1);
%chromosome
cMax=1000;
error2=0;
penalty=0;
if length(chromosome)>400
    penalty=2;
   
end
for iPoint=1:K
    
    A=a;
    A(1)=functionData(iPoint,1);
for j=1:length(chromosome)
    placeInGene=mod(j-1,4)+1;
    i=chromosome(j);
    if placeInGene==1
        operator=O(i);
    elseif placeInGene==2                
        iDestination=i;
    elseif placeInGene==3
        operand1=string(A(i));
    elseif placeInGene==4
        operand2=string(A(i));
        
        stringOfOperand=[operand1, operator,operand2];
        if operator=='/' && operand2=='0'
            A(iDestination)=cMax;
        else
            A(iDestination)=eval(cell2mat(cellstr(stringOfOperand)));

        end
    end
   
end
gPrime=A(1);
error2=error2+(gPrime-functionData(iPoint,2))^2;

end
%gPrime=A(:,1);
%error=sqrt(sum((gPrime-functionData(:,2)).^2)/K);
error=sqrt(error2/K);
fitness=1/error +penalty;
end
