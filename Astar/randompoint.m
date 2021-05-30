function p = randompoint(map, startp, endp)
%keeps trying to find a random point in the map until it's not in a building (0)

testpoint = 0;

    %If no start/end points, will use full map
    if exist('startp','var') == 0 && exist('endp','var') == 0
        while(testpoint==0)  

        p(1) = randi([1,size(map,1)]);
        p(2) = randi([1,size(map,2)]);

        testpoint = map( p(1), p(2) );
        end
    else
    %Uses start/end points and keeps checking for building
        while(testpoint==0)

        p(1) = randi([startp(1),endp(1)]);
        p(2) = randi([startp(2),endp(2)]);

        testpoint = map( p(1), p(2) );
        end
    end
    
    
end