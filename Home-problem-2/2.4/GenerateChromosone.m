function chromosone =GenerateChromosone(chromosoneLength,genRange)
chromosone=zeros(1,chromosoneLength);
for i=1:chromosoneLength
    iRange=mod(i-1,4)+1;
    maxRange=genRange(iRange);
    chromosone(i)=randi(maxRange);
end