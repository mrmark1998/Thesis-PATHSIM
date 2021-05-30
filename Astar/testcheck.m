function testarray = testcheck(test,map) 

    
    testarray = [];
    counter = 0;
    
    for i = 1:size(test, 1)
        if pathcheck(test{i,1},map) == 0
            disp(['Invalid path at ', num2str(i), ', 1']);           
            testarray = [testarray; [i, 1]];      
            counter=counter+1;
        end
        if pathcheck(test{i,2},map) == 0
            disp(['Invalid path at ', num2str(i), ', 2']);           
            testarray = [testarray; [i, 2]];      
            counter=counter+1;
        end
    end    
    
    disp([num2str(counter), ' failed paths found']);
    
        
end

