
%% Image Graph Cheating Maze Solver
% _Updated 04-Jan-2016 to fix a problem with the maze image that was causing 
% an incorrect result for the cheating maze solver._
%
% My <https://blogs.mathworks.com/steve/2015/11/18/graphs-in-matlab-r2015b/
% 18-Nov-2015 post> showed some of the basics of the new graph theory
% functionality in MATLAB R2015b. I followed that up
% <https://blogs.mathworks.com/steve/2015/12/14/image-based-graphs/ last week
% with a post> about my image-based graphs
% <https://www.mathworks.com/matlabcentral/fileexchange/53-shift
% submission to the File Exchange.>
%
% Today I want to show you a Cheating Maze Solver based on image graphs with
% weighted edges.

%% Solving a Maze Using Shortest Path
% Let's start with a maze solver that doesn't cheat. Here's the maze we'll
% be tackling:

url = 'https://blogs.mathworks.com/steve/files/maze-51x51.png';
maze = imread(url);
maze = maze >= 128;
imshow(maze)

%%
% The first step is to construct a graph from the binary image. The nodes of
% the graph will be the foreground pixels, which are the paths of the maze.
% (The background pixels form the maze walls.)

maze_graph = binaryImageGraph(maze)

%%
% Notice that |binaryImageGraph| automatically added weights to the graph
% edges:

maze_graph.Edges(1:5,:)

%%
% These weights are the Euclidean distances between the centers of the
% neighboring foreground pixels.

%% 
% The start and finish coordinates for the maze are (1,496) and (533,518), 
% which we can use to find the corresponding graph nodes.

start_node = find((maze_graph.Nodes.x == 1) & (maze_graph.Nodes.y == 496));
finish_node = find((maze_graph.Nodes.x == 533) & (maze_graph.Nodes.y == 518));

%% 
% Now we just call |shortestpath| to find our way from the start node to the
% finish node. The function |shortestpath| returns a list of graph node
% indices.

p = shortestpath(maze_graph,start_node,finish_node);
p(1:5)

%%
% These values can be used to index into the Nodes table of the graph.

maze_graph.Nodes(p(1:5),:)

%%
% Notice that the graph's node table contains the x- and y- coordinates of
% the corresponding image pixels. The |binaryImageGraph| function
% automatically put that auxiliary information into the graph. We can use it
% now to plot the shortest path.

%%
imshow(maze)
hold on
plot(maze_graph.Nodes.x(p),maze_graph.Nodes.y(p),'r','LineWidth',5)
hold off

