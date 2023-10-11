function fitnessValue=RunTest(chromosome,nIn,nHidden,nOut,wMax,iSlope)
[wIH,wHO]=DecodeChromosome(chromosome,nIn,nHidden,nOut,wMax);


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



 % Assume 
x = 0;%Position
speed=20;% m/s 
gear=7;%
Tb = 500;% K.

L=1000;

tempBreakOverAmbient=0;
listTempBreak=[];

changeGearLimit=2;
timeSinceLastGearChange=2;
% 



iDataSet=3;
%breakPressure=0.1;
timeTruckDrives=0;
slopeAngleList=[];
breakPreasureList=[];
gearList=[];
speedList=[];
breakTempList=[];
distanceTravledList=[];




while x<L
    %disp(timeTruckDrives)
slopeAngleDegrees=GetSlopeAngle(x,iSlope,iDataSet);
slopeAngleList(end+1)=slopeAngleDegrees;

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

breakPreasureList(end+1)=breakPressure;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Break temprature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if breakPressure <0.01
    tempBreakOverAmbientPrime=-tempBreakOverAmbient/tau;
else
    tempBreakOverAmbientPrime=Ch*breakPressure;
end
Tb=Tb+tempBreakOverAmbientPrime*dt;
breakTempList(end+1)=Tb;

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
gearList(end+1)=gear;

acceleration= (Fgravitation -Fbreak -FengineBreak)/mass ;

speed=speed+acceleration*dt;
speedList(end+1)=speed;

x=x+speed*dt;
distanceTravledList(end+1)=x;


timeTruckDrives=timeTruckDrives+dt;
timeSinceLastGearChange=timeSinceLastGearChange+dt;

%end algorithm 
 if speed>vmax
     fprintf("Speeding! Speed= %.1f (km/h)\n",speed)
     break
 elseif speed<vmin
     fprintf("To slow! Speed= %.1f (m/s)\n",speed)
     break
 elseif Tb>Tmax
     fprintf("Breaks to hot! Break temp= %.1f (kelvin)\n",Tb)
     break
 end

end



%plot(1:length(listTempBreak),listTempBreak)
fitnessValue=x^2/(timeTruckDrives);

%%%%%%%%%%%%%%%%%%%%%%%%
%plot 
%%%%%%%%%%%%%%%%%%%%%%%
% Create a figure and define subplot positions
figure;

% Subplot 1
subplot(2, 3, 1);
plot(distanceTravledList, slopeAngleList);
title('Slope angle');
xlabel('Distance');
ylabel('Angle');

% Subplot 2
subplot(2, 3, 2);
plot(distanceTravledList, breakPreasureList);
title('Break pressure');
xlabel('Distance');
ylabel('Preassure');

% Subplot 3
subplot(2, 3, 3);
plot(distanceTravledList, gearList);
title('Choosen gear');
xlabel('Distance');
ylabel('Gear');

% Subplot 4
subplot(2, 3, 4);
plot(distanceTravledList, speedList);
title('Speed');
xlabel('Distance');
ylabel('Speed');

% Subplot 5
subplot(2, 3, 5);
plot(distanceTravledList, breakTempList);
title('Break temprature');
xlabel('Distance');
ylabel('Temprature');

end