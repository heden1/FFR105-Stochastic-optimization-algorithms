function [xPB] = bestParticle(xPosition,xPB)
    
functionValue=computeParticleValue(xPosition(:,1),xPosition(:,2));
functionValuePB=computeParticleValue(xPB(:,1),xPB(:,2));


    for row=1:size(xPosition,1)
        particle=xPosition(row,:);
        particleValue=functionValue(row);
        if particleValue<functionValuePB(row)
            functionValuePB(row)=particleValue;
            xPB(row,:)=particle;
        end
    end
        

    
end