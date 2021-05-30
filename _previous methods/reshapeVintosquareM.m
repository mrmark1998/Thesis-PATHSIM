function squared = intoSquare(MyMatrix)
N = numel(MyMatrix); 
N2 = ceil(sqrt(N));
if N2^2 > N
  MyMatrix(N2^2) = 0; % pads with zeros if needed
end
squared = reshape(MyMatrix,N2,N2); % square!
end
