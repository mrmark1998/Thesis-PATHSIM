% TEST 2
% 2 Paths, A and B:
%
% Starting coords are different
% Ending points are same
% Similar paths, but random point for end

TEST2 = cell(100,2);

for i= 1:5
    
    endp = randompoint(bigmap, [401, 401], [652, 652]); 
    TEST2{i,2} = createpath(bigmap, endp);
    A = createpath(bigmap, endp);
    
    if B(size(B),1) == TEST1{i,1}(size(TEST1{i,1}),1)
        TEST2{i,1} = B;
    else
        TEST2{i,1} = flip(B); %since findCoords is non-oriented, flips if necessary
    end
    
end

save('TEST2.mat','TEST2')
    
    