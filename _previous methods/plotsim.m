function plotpaths(map, coord1, coord2)

P = false(size(map));
P = imoverlay(P, ~map, 'red');
imshow(P, 'InitialMagnification', 'fit')

%plots up to 2 paths
    if exist('coord1','var') == 1
        hold on
        coord1x = coord1(:,2);
        coord1y = coord1(:,1);
        plot(coord1x, coord1y, 'green', ... 
               'LineStyle', '--', ...
               'LineWidth',2)
    end

    if exist('coord2','var') == 1
        coord2x = coord2(:,2);
        coord2y = coord2(:,1);
        plot(coord2x, coord2y, 'cyan', ...
               'LineStyle', ':', ...
               'LineWidth', 2)
    end

end
