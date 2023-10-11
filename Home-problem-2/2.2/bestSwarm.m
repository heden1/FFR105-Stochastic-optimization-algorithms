function xSB = bestSwarm(xPosition,xSB)
functionValue=computeParticleValue(xPosition(:,1),xPosition(:,2));
functionValueSB=computeParticleValue(xSB(:,1),xSB(:,2));

for i =1:length(functionValue)
    if functionValue(i)<functionValueSB
        xSB=xPosition(i,:);
    end 
end 
end