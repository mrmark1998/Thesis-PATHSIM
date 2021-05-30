function pmatrix = shortestpath(map, start_id,finish_id)

if(map(start_id(1),start_id(2))==0 | map(finish_id(1),finish_id(2))==0)
    disp('Starting or Ending point cannot be in a building, try again')
else
    


bw1=logical(zeros(size(map)));
bw1(start_id(1),start_id(2)) = 1; %starting point

bw2=logical(zeros(size(map)));
bw2(finish_id(1),finish_id(2)) = 1; %ending point


D1 = bwdistgeodesic(map,bw1, 'quasi-euclidean');
D2 = bwdistgeodesic(map,bw2, 'quasi-euclidean');
D = D1 + D2; %add up the 2 geodesic distances from both matrices
D = round(D * 32) / 32;
D(isnan(D)) = inf;


paths = imregionalmin(D);

paths_thinned_many = bwmorph(paths, 'thin', inf);
P = false(size(map));
P = imoverlay(P, ~map, [1 0 0]);
P = imoverlay(P, paths, [.5 .5 .5]);
P = imoverlay(P, paths_thinned_many, [1 1 0]);
imshow(P, 'InitialMagnification', 'fit')
pmatrix = paths_thinned_many;

path_length = D(paths);
path_length = path_length(1)

end