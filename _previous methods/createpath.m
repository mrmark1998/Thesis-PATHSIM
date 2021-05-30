function coords = createpath(map, start)
%create a validated path with a starting point (or random point if none) 
%and utilizing a random point using randompoint.  Then verifies all this 
%with pathcheck to see if a good path has been created

    if exist('start','var') == 0
        start = randompoint(map, [401, 401], [652, 652]);
        %We are only using part of the map based on DPD analysis
    end

    pathcreated = 0;
    %attempts = 0;
    while pathcreated == 0
        B = randompoint(map, [401, 401], [652, 652]);
        path = shortestpathdilated(map, start, B, 1);
        coords = findCoords(path);
        pathcreated = pathcheck(coords);
        %if pathcreated == 0 && attempts < 5
        %    disp('failed to create')
        %    start = randompoint(map, [401, 401], [652, 652]);
        %elseif pathcreated == 0 && attempts >= 5
        %    disp('ABORTING')
        %    break;
        %end
        %attempts = attempts + 1;
    end
    if pathcreated == 1
        disp('path created')
    end
end

