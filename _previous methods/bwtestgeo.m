bw3 = logical(readmatrix('mapsect.xlsx')) %routes that they can take = 1, like actual map

bw1=logical(zeros(size(bw3)));
bw2=logical(zeros(size(bw3)));

bw1(1,1) = 1; %starting point;
%find size of matrix
A = size(bw3);
bw2(A(1),A(2)) = 1; %ending point

D1 = bwdistgeodesic(bw3,bw1, 'chessboard');
D2 = bwdistgeodesic(bw3,bw2, 'chessboard');
D = D1 + D2;
D = round(D * 32) / 32;
D(isnan(D)) = inf;


paths = imregionalmin(D);how 

mask = bw3;

paths_thinned_many = bwmorph(paths, 'thin', inf);
P = false(size(bw3));
P = imoverlay(P, ~mask, [1 0 0]);
P = imoverlay(P, paths, [.5 .5 .5]);
P = imoverlay(P, paths_thinned_many, [1 1 0]);
imshow(P, 'InitialMagnification', 'fit')