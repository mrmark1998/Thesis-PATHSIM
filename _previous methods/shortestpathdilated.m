function pmatrix = shortestpathdilated(map, start_id,finish_id, pixels)

    
bw1=logical(zeros(size(map)));
bw1(start_id(1),start_id(2)) = 1; %starting point

bw2=logical(zeros(size(map)));
bw2(finish_id(1),finish_id(2)) = 1; %ending point

%Dilate map for creating a buffer around buildings, by x pixels 
SE2 = strel('diamond', pixels); 
BW = imdilate(~map, SE2); 

D1 = bwdistgeodesic(~BW,bw1, 'quasi-euclidean');
D2 = bwdistgeodesic(~BW,bw2, 'quasi-euclidean');
D = D1 + D2; %add up the 2 geodesic distances from both matrices
D = round(D * 32) / 32;
D(isnan(D)) = inf;


paths = imregionalmin(D);
paths_thinned_many = bwmorph(paths, 'thin', inf);
pmatrix = paths_thinned_many;

end