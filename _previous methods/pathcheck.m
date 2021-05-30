function boolAnswer = pathcheck(path)

    x = path(1,1);
    y = path(1,2);
    boolAnswer = false;
    
        if size(path) > 1 %size of path must > 1
            for i = 2:size(path,1)
                check1= abs(path(i,1) - x);
                check2= abs(path(i,2) - y);
                if (check1+check2 <= 2)
                    x = path(i,1);
                    y = path(i,2);
                    boolAnswer = true;
                else
                    boolAnswer = false;
                    break;
                end
            end
        end
        
                
end



