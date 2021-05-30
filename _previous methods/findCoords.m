function coords = findCoords(map)

%reshape into squared matrix
if size(map, 1) > size(map, 2)
    map = intoSquare(map);
end


%create digraph
B = digraph(map);

coords = B.Edges.EndNodes;