% TEST 1
% 2 Paths, A and B:
%
% Starting coords are same startp
% Similar paths, but random point for end

TEST1 = cell(100,2);

for i= 1:10
    
    startp = randompoint(bigmap, [401, 401], [652, 652]); 
    TEST1{i,1} = createpath(bigmap, startp);
    B = createpath(bigmap, TEST1{i,1});
    
    if B(1,1) == TEST1{i,1}(1,1)
        TEST1{i,2} = B;
    else
        TEST1{i,2} = flip(B); %since findCoords is non-oriented, flips if necessary
    end
    
end

save('TEST1.mat','TEST1')
    
    