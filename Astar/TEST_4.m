% TEST 4
% 2 Paths, A and B:
%
% Starting coords are same start
% Similar paths, but random point for end
% modified TEST_1 case with function and error

mapload;

TEST4 = cell(1000,2);

for count= 1:1000
    
    startp = randompoint(midmap); 
    endp = randompoint(midmap);
    path1=A_Star4(MAP,startp,endp); %make sure to use MAP which is
                                    %A* modified version of midmap
    
    TEST4{count,1} = [path1(:,1)+400, path1(:,2)+400];
    
    
    % Since A* is a target-backward search, we must change starting point
    startp = randompoint(midmap); 
    path2=A_Star4(MAP,startp,endp);
    TEST4{count,2} = [path2(:,1)+400, path2(:,2)+400];
    
    disp(['Paths ', num2str(count), ' generated.'])

end

save('TEST4.mat','TEST4')
    
    