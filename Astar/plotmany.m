function plotmany(map, DATA, startnum, endnum)
    % This function plots multiple paths given a cell data DATA
    % Will plot the first num paths in tandem and keep them on the map
    %
    % 
    
    
    P = false(size(map));
    P = imoverlay(P, ~map, 'cyan');
    imshow(P, 'InitialMagnification', 'fit')

    % Plots up to num paths
    hold on
    
    for i = startnum:endnum

            coord1x = DATA{i,1}(:,2);
            coord1y = DATA{i,1}(:,1);
            plot(coord1x, coord1y, 'magenta', ... 
                   'LineStyle', ':', ...
                   'LineWidth',3)
               
            coord2x = DATA{i,2}(:,2);
            coord2y = DATA{i,2}(:,1);
            plot(coord2x, coord2y, 'y', ...
                   'LineStyle', '-.', ...
                   'LineWidth', 3)

    end
    
    hold off
    
end
