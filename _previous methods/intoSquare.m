function squared = intoSquare(MyMatrix)

maxEdgeLength = size(MyMatrix, 1);

if size(MyMatrix, 2) > size(MyMatrix, 1)
    maxEdgeLength = size(MyMatrix, 2);
end

squared = zeros(maxEdgeLength);
squared(1:size(MyMatrix, 1), 1:size(MyMatrix, 2)) = MyMatrix;

end
