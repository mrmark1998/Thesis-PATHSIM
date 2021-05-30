function plotsim(map, coord1, coord2)
% This function plots on a binary matrix map, 0s being red buildings and 1s
% being open space as is in our project.


P = false(size(map));
P = imoverlay(P, ~map, 'cyan');
imshow(P, 'InitialMagnification', 'fit')


% Also plots up to 2 paths
    if exist('coord1','var') == 1
        hold on
        coord1x = coord1(:,2);
        coord1y = coord1(:,1);
        plot(coord1x, coord1y, 'g', ... 
               'LineStyle', ':', ...
               'LineWidth',3)
    end

    if exist('coord2','var') == 1
        coord2x = coord2(:,2);
        coord2y = coord2(:,1);
        plot(coord2x, coord2y, 'y', ...
               'LineStyle', ':', ...
               'LineWidth', 3)
    end

end
