function tryit
v  = readmatrix('map2d.csv');
v(isnan(v)) = 0;  
bigmap = logical(v);
A = randompoint(bigmap) 
B = randompoint(bigmap)

pathlength = 0;
dilation = 3;
while (pathlength == 0 | pathlength == inf)
    shortestpathdilated(bigmap, A, B, dilation)
    dilation = dilation - 1;
end

    