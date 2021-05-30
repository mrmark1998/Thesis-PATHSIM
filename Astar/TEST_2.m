% TEST 2
% 2 Paths, A and B:
%
% Start&end coords are very similar  (within 5 pixel radius)
% 
% Therefore creating very similar paths

mapload;

TEST2 = cell(1000,2);

for count= 1:1000
    
    validpath = 0;
    
    while validpath == 0
        startp = randompoint(midmap);
        endp = randompoint(midmap);
        path1=A_Star4(MAP,startp,endp); %make sure to use MAP which is
                                        %A* modified version of midmap
        validpath = pathcheck(path1, midmap);
        if validpath == 0
            disp('Retrying path 1...')        
        else
            TEST2{count,1} = [path1(:,1)+400, path1(:,2)+400];
        end
    end
    
    validpath = 0;
    while validpath == 0   
        startp2 = randompointrad(midmap, startp, 5); %using radius of 5
        endp2 = randompointrad(midmap, endp, 5);
        path2=A_Star4(MAP,startp2,endp2);
        validpath = pathcheck(path2, midmap);
        if validpath == 0
            disp('Retrying path 2...')
        else
            TEST2{count,2} = [path2(:,1)+400, path2(:,2)+400];
        end
    end
    
    if validpath == 1
        disp(['Paths ', num2str(count), ' generated.'])
    else
        disp(['Paths unable to be generated!'])
    end
    
    
end

save('TEST2.mat','TEST2')
    
    