
% Load our team map into logical array:
% ------------------------------------------------

v  = readmatrix('map2d.csv');
v(isnan(v)) = 0;  
bigmap = logical(v);


% ------------------------------------------------
% Create Two very similar paths:


A = [215, 713];
B = [390, 655];
path1 = shortestpathdilated(bigmap, A, B, 1);

coord1 = findCoords(path1);  


C = [215, 710];
D = [390, 660];
path2 = shortestpathdilated(bigmap, C, D, 1);
coord2 = findCoords(path2);

% ---------------------------------------------------
% Created plotpaths, which will plot 2 paths onto any map (logical array) with various line styles (you can do dashed and dotted lines, which I chose to do dashed yellow and dotted cyan here)


plotpaths(bigmap, coord1,coord2);


% ----------------------------------------------------
% Using Beata's script, I created a function out of it, called
% path_simarities_M(path1, path2, adj)
% which takes 2 path arrays as variables and the # of adjacent points to
% compare as a variable, then outputs it to the array
% which shows 1-8, 1=0-25m, 8=200m+


% I finally also added the code that compares the points and used
% lookup_pair to check if they are in the DPD if their simscore > 4.

path_similarities_M(coord1, coord2, 3);


