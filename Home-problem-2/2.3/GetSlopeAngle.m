%% This file provides the FORMAT you should use for the
%% slopes in HP2.3. x denotes the horizontal distance
%% travelled (by the truck) on a given slope, and
%% alpha measures the slope angle at distance x
%%
%% iSlope denotes the slope index (i.e. 1,2,..10 for the
%% training set etc.)
%% iDataSet determines whether the slope under consideration
%% belongs to the training set (iDataSet = 1), validation
%% set (iDataSet = 2) or the test set (iDataSet = 3).
%%
%% Note that the slopes given below are just EXAMPLES.
%% Please feel free to implement your own slopes below,
%% as long as they fulfil the criteria given in HP2.3.
%%
%% You may remove the comments above and below, as they
%% (or at least some of them) violate the coding standard 
%%  a bit. :)
%% The comments have been added as a clarification of the 
%% problem that should be solved!).


function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1)                                % Training
 if (iSlope == 1) 
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);   

 elseif (iSlope == 2)
     alpha=5+sin(x/300);
 elseif (iSlope == 3)
     alpha=6+2*sin(x/115)+cos(x/136+50);
  elseif (iSlope == 4)
     alpha=5 + sin(x/150) + cos(x/225);
 elseif (iSlope==5)
     alpha=1+abs(8-x/300);
 elseif (iSlope==6)
     alpha=4 + sin(x/200) + cos(2*x/125) + 0.3*sin(x/75);
 elseif (iSlope==7)
     alpha=7 - sin(x/300) - cos(x/150);
 elseif (iSlope==8)
     alpha= 4 + 2*sin(x/300) + cos(x/175) ;
 elseif(iSlope==9)
     alpha=8 + sin(sqrt(5)*x/300) + cos(x/150);
 elseif (iSlope== 10)
   alpha = 3 + sin(x/50) + cos(sqrt(2)*x/100); 
 end 
elseif (iDataSet == 2)                            % Validation
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50); 
 elseif (iSlope == 2) 
   alpha =6 + sin(x/200) - cos(x/100);
   elseif (iSlope == 3) 
   alpha =3 + sin(x/250) + cos(x/125);
 elseif (iSlope == 4) 
   alpha = 7 - sin(x/300) + cos(sqrt(4)*x/150);
 elseif (iSlope == 5) 
   alpha = 5 + sin(x/50) + cos(x/50);   
 end 
elseif (iDataSet == 3)                           % Test
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);  
elseif (iSlope == 2)
    alpha =5+ sin(x/250) + cos(x/150);
elseif (iSlope == 3)
    alpha =   5 - sin(sqrt(3)*x/150) + cos(x/75);
  elseif (iSlope == 4)
   alpha = 5 + sin(x/225) + cos(sqrt(3)*x/75);
 elseif (iSlope == 5)
   alpha = 4 + cos(x/100) + sin(x/70);
 end
end
