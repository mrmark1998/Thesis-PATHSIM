bw = logical([ ...
    0 0 0 0 0 0 1
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 0 0 0 0 0
    0 0 1 0 0 0 0 
    0 0 0 0 0 0 0  ]);
L = bwlabel(bw);
bw1 = (L == 1);
bw2 = (L == 2);

D1 = bwdist(bw1, 'chessboard');
D2 = bwdist(bw2, 'chessboard');
D = D1 + D2;
D = round(D * 32) / 32;


paths = imregionalmin(D);

paths_thinned_many = bwmorph(paths, 'thin', inf);
P = false(size(bw));
P = imoverlay(P, paths, [0 0 0]);
P = imoverlay(P, paths_thinned_many, [1 1 0]);
P = imoverlay(P, bw, [1 1 1]);
imshow(P, 'InitialMagnification', 'fit')

