% TEST 4
% 2 Paths, A and B:
%
% Starting coords are same start
% Similar paths, but random point for end (start in this case)
% modified TEST_1 case with function and error

mapload;

TEST1 = cell(1000,2);

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
            TEST1{count,1} = [path1(:,1)+400, path1(:,2)+400];
        end
    end
    
    validpath = 0;
    while validpath == 0   
        % Since A* is a target-backward search, 
        % we must change starting point
        startp2 = randompoint(midmap); 
        path2=A_Star4(MAP,startp2,endp);
        validpath = pathcheck(path2, midmap);
        if validpath == 0
            disp('Retrying path 2...')
        else
            TEST1{count,2} = [path2(:,1)+400, path2(:,2)+400];
        end
    end
    
    if validpath == 1
        disp(['Paths ', num2str(count), ' generated.'])
    else
        disp(['Paths unable to be generated!'])
    end
    
    
end

save('TEST1.mat','TEST1')