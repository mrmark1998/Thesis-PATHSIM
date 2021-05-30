function p = randompointrad(map, startp, rad)
% Finds a random point in the map around a radius of a given point
% 
% For the purposes of creating similar paths (TEST_2)
  
    testpoint = 0;
    loop_counter = 0;

    while(testpoint==0 && loop_counter <= 20 )

        t = 2*pi*rand(1,1);
        r = rad*sqrt(rand(1,1));
        p(1) = startp(1) + floor(r.*cos(t));
        p(2) = startp(2) + floor(r.*sin(t));

        if (p(1) > 1 && p(1) <= size(map,1)) && (p(2) > 1 && p(2) <= size(map,2))
            testpoint = map(p(1),p(2));
        end
        
        loop_counter = loop_counter + 1; %tries to a find a point max 30 times
        
    end
    
    if loop_counter > 20
        disp('Cannot find valid close point with specified radius! Setting to starting point');
        p = startp;
    end
    
    
    
end