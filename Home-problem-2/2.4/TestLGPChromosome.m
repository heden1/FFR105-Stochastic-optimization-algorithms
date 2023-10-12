function f = TestLGPChromosome(chromosome)
syms x
functionData=LoadFunctionData;
K=size(functionData,2);
operatorSet={@add @subtract @multi @division};
constantRegister=[1,3,-1];
A=[x,0,0,constantRegister];
cMax=1000000;

for j=1:length(chromosome)
    placeInGene=mod(j-1,4)+1;
    i=chromosome(j);
    if placeInGene==1
        operator=operatorSet{i};
        if i==4
            isDivision=true;
        else
            isDivision=false;
        end
    elseif placeInGene==2                
        iDestination=i;
    elseif placeInGene==3
        operand1=(A(i));
    elseif placeInGene==4
        operand2=(A(i));
        
        if isDivision && operand2==0
            A(iDestination)=cMax;
        else
            A(iDestination)=operator(operand1,operand2);
        end
        
    end

end
    f=A(1);
    gPrime=subs(f, {x}, {functionData(:,1)});
    error=sqrt(sum((gPrime-functionData(:,2)).^2)/K);
    fprintf("Error: %f",error)
    xmin=functionData(1,1);
    xmax=functionData(end,1);
    f=simplify(f)

    scatter(functionData(:,1),functionData(:,2),'filled','DisplayName','Given function data')
    hold on
    fplot(f,[xmin,xmax],'Linewidth',2,'DisplayName','Found function')
    legend
    hold off



end