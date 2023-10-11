%% runPSO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%foundMin=[];
format long
for iRun=1:40 %to find all local minima
N=20;%20-40
n=2;
xMin=-5;
xMax=5;
dt=1;
c1=2;
c2=2;
previousParticleValue=zeros(N,1);
xPB=zeros(N,2);
xSB=zeros(1,2);
alpha=1;
vMax=(xMax-xMin)/dt;


inertiaWheight=1.4;
beta=0.9999;
inertiaWheightLowerBound=0.3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot contour
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=linspace(xMin,xMax,100);
x2=linspace(xMin,xMax,100);
[X1,X2] = meshgrid(x1,x2);
a=0.01;
Z=log(a+computeParticleValue(X1,X2));

contour(X1,X2,Z)
hold on


r=rand([N,n]);

xPosition=xMin+r*(xMax-xMin);

r=rand([N,n]);
vVelocity=(alpha/dt)*( -((xMax-xMin)/2)+r*(xMax-xMin)  );



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% updateVelocities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i =1:10000 
    
        xPB=bestParticle(xPosition,xPB);
        xSB=bestSwarm(xPosition,xSB);
        q=rand([N,n]);
        r=rand([N,n]);
     
        vVelocity=inertiaWheight*vVelocity+c1*q.*((xPB-xPosition)/dt)+c2*r.*((xSB-xPosition)/dt);
        vVelocity(vVelocity>vMax)=vMax;
        vVelocity(vVelocity<-vMax)=-vMax;
    
        xPosition=xPosition+vVelocity;
        if inertiaWheight>inertiaWheightLowerBound
            inertiaWheight=inertiaWheight*beta;
        end
    end 
    

    scatter(xSB(1),xSB(2),900,'x','LineWidth',4,'MarkerEdgeColor','red')
    fprintf('Cordinates (%f , %f) with value %e',xSB(1),xSB(2),computeParticleValue(xSB(1),xSB(2)))
    disp(computeParticleValue(xSB(1),xSB(2)))
    disp(" ")
    %foundMin=[foundMin;xSB];    
end 

%uniqFoundMin=[uniquetol(foundMin(:,1)),uniquetol(foundMin(:,2))]

