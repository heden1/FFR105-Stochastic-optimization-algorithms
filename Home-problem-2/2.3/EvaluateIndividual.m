function fitnessValue = EvaluateIndividual(wIH,wHO,iDataSet)
%input;%[v/vmax, α/αmax  Tb/Tmax]

%output;%[Pp, deltaGear]

%[wIH,wHO]=DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);




% network stuff
c=2; %in range [1,3]
sigmoid=@(s) 1./(1+exp(-c*s));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tmax = 750;%(K)
mass =20000;%(kg)
tau=30;%(s)
Ch =40;%(K/s)
tempAmb =283;%(K)
Cb =3000;%(N)
vmax =25;% (m/s)
vmin = 1;%(m/s)
angelMax = 10;%(degrees)
g = 9.81;  % Acceleration due to gravity in m/s^2
dt=0.15;





F_eb=[7,5,4,3,2.5,2,1.6,1.4,1.2,1]*Cb;
numberOfGears=length(F_eb);
gearChangeBounadry=0.3;

fitnessValueList=[];
if iDataSet==1
    numberOfSlopes=10;
else
    numberOfSlopes=5;
end
for iSlope=1:numberOfSlopes
 % Assume 
x = 0;%Position
speed=20;% m/s 
gear=7;%
Tb = 500;% K.

tempBreakOverAmbient=0;
listTempBreak=[];

changeGearLimit=2;
timeSinceLastGearChange=2;


%breakPressure=0.1;
timeTruckDrives=0;
while x<1000
    %disp(timeTruckDrives)
slopeAngleDegrees=GetSlopeAngle(x,iSlope,iDataSet);


input=[speed/vmax, slopeAngleDegrees/angelMax  Tb/Tmax];


hiddenLayer=sigmoid((input*wIH(:,1:end-1)')-wIH(:,end)');
output=sigmoid((hiddenLayer*wHO(:,1:end-1)')-wHO(:,end)');

breakPressure=output(1);
deltaGear=output(2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gravitational force
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fgravitation=mass * g * sind(slopeAngleDegrees); 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Break force 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Tb<Tmax-100
    Fbreak=(mass*g/20)*breakPressure;
else
    Fbreak=(mass*g/20)*breakPressure*exp(-(Tb-(Tmax))/100);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Break temprature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if breakPressure <0.01
    tempBreakOverAmbientPrime=-tempBreakOverAmbient/tau;
else
    tempBreakOverAmbientPrime=Ch*breakPressure;
end
Tb=Tb+tempBreakOverAmbientPrime*dt;
if Tb<tempAmb
    Tb=tempAmb;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gear change 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if timeSinceLastGearChange>changeGearLimit
    
    if deltaGear<gearChangeBounadry
       
        gear=gear-1;
        timeSinceLastGearChange=0;
        if gear<1
            gear=1;
        end
    elseif deltaGear>1-gearChangeBounadry
        gear=gear+1;
        timeSinceLastGearChange=0;
        if gear>numberOfGears
            gear=numberOfGears;
        end
    end
end

FengineBreak=F_eb(gear);

acceleration= (Fgravitation -Fbreak -FengineBreak)/mass ;

speed=speed+acceleration*dt;

x=x+speed*dt;
timeTruckDrives=timeTruckDrives+dt;
timeSinceLastGearChange=timeSinceLastGearChange+dt;

%end algorithm 
 if speed>vmax
     %fprintf("Speeding! Speed= %.1f (km/h)\n",speed)
     break
 elseif speed<vmin
     %fprintf("To slow! Speed= %.1f (m/s)\n",speed)
     break
 elseif Tb>Tmax
     %fprintf("Breaks to hot! Break temp= %.1f (kelvin)\n",Tb)
     break
 end

end


%fprintf("Distance %.1f (km)\n",x/1000)
%disp(" ")
%disp(" ")

%plot(1:length(listTempBreak),listTempBreak)
fitnessValueList(end+1)=x^2/(timeTruckDrives);
end 
fitnessValue=mean(fitnessValueList);
end