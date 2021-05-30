bw = logical([ ...
    1 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 1 1 0 0 0
    0 0 0 1 1 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 1]);

L = bwlabel(bw);
bw1 = (L == 1); %this is the starting point
bw2 = (L == 3); %this is the end point

bw3 = logical([ ...
    1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1
    1 1 1 0 0 1 1 1
    1 1 1 0 0 1 1 1
    1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1
    1 1 1 1 1 1 1 1]); %routes that they can take = 1, like actual map

D1 = bwdistgeodesic(bw3,bw1, 'chessboard');
D2 = bwdistgeodesic(bw3,bw2, 'chessboard');
D = D1 + D2;
D = round(D * 32) / 32;
D(isnan(D)) = inf;


paths = imregionalmin(D);

mask = bw3;

paths_thinned_many = bwmorph(paths, 'thin', 1);
P = false(size(bw));
P = imoverlay(P, ~bw3, [1 0 0]);
P = imoverlay(P, paths, [.5 .5 .5]);
P = imoverlay(P, paths_thinned_many, [1 1 0]);
P = imoverlay(P, bw, [1 1 1]);
imshow(P, 'InitialMagnification', 'fit')