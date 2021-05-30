% TEST 3
% 2 Paths, A and B:
%
% Meet in the middle
% *Using data from TEST1 cell-array 1 as endpoint
% Constructs new paths based on 2 optimal paths


mapload;


% Constructs first half TEST3 by copying TEST1's initial paths
TEST3 = TEST1(1:1000, 1);


for count= 1:1000

     validpath = 0;
    
    while validpath == 0
        startp = randompoint(midmap);
        endp = TEST1{count,1}(1,:)-400; 
        path1=A_Star4(MAP,startp,endp);
        validpath = pathcheck(path1, midmap);
        if validpath == 0
            disp('Retrying path 1...')        
        else
            TEST3{count,1} = [flip(TEST3{count,1}); [path1(:,1)+400, path1(:,2)+400]];
        end
    end
    
    validpath = 0;
    while validpath == 0   
        startp2 = randompoint(midmap); 
        path2=A_Star4(MAP,startp2,endp);
        validpath = pathcheck(path2, midmap);
        if validpath == 0
            disp('Retrying path 2...')
        else
            TEST3{count,2} = [path2(:,1)+400, path2(:,2)+400];
        end
    end
    
    validpath = 0;
    while validpath == 0   
        startp3 = randompoint(midmap);
        path3=A_Star4(MAP,startp3,endp);
        validpath = pathcheck(path3, midmap);
        if validpath == 0
            disp('Retrying path 2...')
        else
            TEST3{count,2} = [flip(TEST3{count,2}); [path3(:,1)+400, path3(:,2)+400]];
        end
    end
    
    if validpath == 1
        disp(['Paths ', num2str(count), ' generated.'])
    else
        disp(['Paths unable to be generated!'])
    end
   
end

save('TEST3.mat','TEST3')
    
    