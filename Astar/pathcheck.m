function boolAnswer = pathcheck(path, map)

    x = path(1,1);
    boolAnswer = false;
    
        if size(path) > 1 %size of path must > 1
   
            y = path(1,2); %sets 2nd node as y
                           %and keeps checking |x+y| to ensure it moves
                           %by >1 pixel <2 every time
            
            if map(x,y) == 0
                disp(['Path error: (', num2str(x), ' ', num2str(y), ') in building.'])
                return
            end
            
            
            for i = 2:size(path,1)
                check1= abs(path(i,1) - x);
                check2= abs(path(i,2) - y);
                if (check1+check2 <= 2)
                    x = path(i,1);
                    y = path(i,2);
                    boolAnswer = true;
                elseif map(x,y) == 0
                    disp(['Path error: (', num2str(x), ' ', num2str(y), ') in building.'])
                    boolAnswer = false;
                    break;
                else
                    boolAnswer = false;
                    break;
                end
            end
        end
        
                
end



