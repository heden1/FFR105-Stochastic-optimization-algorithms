function f = TestLGPChromosome(chromosome)
syms x
O=['+','-','*','/'];
A=[x,0,0,0,1,3,-1,2];
cMax=1000000;

for j=1:length(chromosome)
    placeInGene=mod(j-1,4)+1;
    i8=chromosome(j);
    i4=mod(i8-1,4)+1;
    if placeInGene==1
        operator=O(i4);
    elseif placeInGene==2                
        iDestination=i4;
    elseif placeInGene==3
        operand1=string(A(i8));
    elseif placeInGene==4
        operand2=string(A(i8));
        
        stringOfOperand=[operand1, operator,operand2];
        if operator=='/' && operand2=='0'
            A(iDestination)=cMax;
        else
            A(iDestination)=eval(cell2mat(cellstr(stringOfOperand)));
        end
        
    end
    f=A(1);
end