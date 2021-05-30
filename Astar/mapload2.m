% MAP LOAD 2
% This function loads the map correctly for the A Star function
%
% Buildings will be converted to -1 in the function
% Open space (roads) will be converted to 2

v  = readmatrix('midmap.csv');
v(isnan(v)) = 0;  
midmap = logical(v);

v  = readmatrix('map2d.csv');
v(isnan(v)) = 0;  
bigmap = logical(v);

MAP = readmatrix('map2d.csv'); 

MAX_X=size(MAP,1);
MAX_Y=size(MAP,2);
MAX_VAL=max(MAX_X,MAX_Y);

%This array stores the coordinates of the map and the 
%Objects in each coordinate
   
% Convert buildings 0 to -1
MAP(MAP==0) = -1;

% Convert open space/road 1 to 2
MAP(MAP==1) = 2;

MAX_X=size(MAP,1);
MAX_Y=size(MAP,2);
MAX_VAL=max(MAX_X,MAX_Y);

%This array stores the coordinates of the map and the 
%Objects in each coordinate
   
% Convert buildings 0 to -1
MAP(MAP==0) = -1;

% Convert open space/road 1 to 2
MAP(MAP==1) = 2;