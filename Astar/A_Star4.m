function Optimal_path = A_Star4(map, startp, endp)

    MAP=map;

    MAX_X=size(MAP,1);
    MAX_Y=size(MAP,2);
    MAX_VAL=max(MAX_X,MAX_Y);
    
    xStart=startp(1); %X Coordinate of the Starting Point
    yStart=startp(2); %X Coordinate of the Starting Point
    
    xTarget=endp(1); %X Coordinate of the End Point
    yTarget=endp(2); %Y Coordinate of the End Point
    
    if map(startp(1), startp(2)) == -1 || map(endp(1), endp(2)) == -1
        %if the starting or ending points are in a building (-1), exit function
        disp('Starting/ending point in a building');
        Optimal_path = [1, 1];
        return
    else
        %else, set them to start =1, target=0
        MAP(xStart,yStart)=1;
        MAP(xTarget,yTarget)=0;
    end
    

    %set the starting node as the first node
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LISTS USED FOR ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %OPEN LIST STRUCTURE
    %--------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
    %--------------------------------------------------------------------------
    OPEN=[];
    %CLOSED LIST STRUCTURE
    %--------------
    %X val | Y val |
    %--------------
    CLOSED=zeros(MAX_VAL,2);
    % CLOSED=[];

    %Put all obstacles on the Closed list
    k=1;%Dummy counter
    for i=1:MAX_X
        for j=1:MAX_Y
            if(MAP(i,j) == -1)
                CLOSED(k,1)=i; 
                CLOSED(k,2)=j; 
                k=k+1;
            end
        end
    end
    CLOSED_COUNT=size(CLOSED,1);
    %set the starting node as the first node
    xNode=xStart;
    yNode=yStart;
    OPEN_COUNT=1;
    path_cost=0;
    goal_distance=distance(xNode,yNode,xTarget,yTarget);
    OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
    OPEN(OPEN_COUNT,1)=0;
    CLOSED_COUNT=CLOSED_COUNT+1;
    CLOSED(CLOSED_COUNT,1)=xNode;
    CLOSED(CLOSED_COUNT,2)=yNode;
    NoPath=1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % START ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
    %  plot(xNode+.5,yNode+.5,'go');
     exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y);
     exp_count=size(exp_array,1);
     %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
     %OPEN LIST FORMAT
     %--------------------------------------------------------------------------
     %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
     %--------------------------------------------------------------------------
     %EXPANDED ARRAY FORMAT
     %--------------------------------
     %|X val |Y val ||h(n) |g(n)|f(n)|
     %--------------------------------
     for i=1:exp_count
        flag=0;
        for j=1:OPEN_COUNT
            if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
                OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
                if OPEN(j,8)== exp_array(i,5)
                    %UPDATE PARENTS,gn,hn
                    OPEN(j,4)=xNode;
                    OPEN(j,5)=yNode;
                    OPEN(j,6)=exp_array(i,3);
                    OPEN(j,7)=exp_array(i,4);
                end%End of minimum fn check
                flag=1;
            end%End of node check
    %         if flag == 1
    %             break;
        end %End of j for
        if flag == 0
            OPEN_COUNT = OPEN_COUNT+1;
            OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
        end %End of insert new element into the OPEN list
     end %End of i for
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %END OF WHILE LOOP
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %Find out the node with the smallest fn 
      index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
      if (index_min_node ~= -1)    
       %Set xNode and yNode to the node with minimum fn
       xNode=OPEN(index_min_node,2);
       yNode=OPEN(index_min_node,3);
       path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
      %Move the Node to list CLOSED
      CLOSED_COUNT=CLOSED_COUNT+1;
      CLOSED(CLOSED_COUNT,1)=xNode;
      CLOSED(CLOSED_COUNT,2)=yNode;
      OPEN(index_min_node,1)=0;
      else
          %No path exists to the Target!!
          NoPath=0;%Exits the loop!
      end%End of index_min_node check
    end%End of While Loop
    %Once algorithm has run The optimal path is generated by starting of at the
    %last node(if it is the target node) and then identifying its parent node
    %until it reaches the start node.This is the optimal path

    i=size(CLOSED,1);
    Optimal_path=[];
    xval=CLOSED(i,1);
    yval=CLOSED(i,2);
    i=1;
    Optimal_path(i,1)=xval;
    Optimal_path(i,2)=yval;
    i=i+1;

    if ( (xval == xTarget) && (yval == yTarget))
        inode=0;
       %Traverse OPEN and determine the parent nodes
       parent_x=OPEN(node_index(OPEN,xval,yval),4);%node_index returns the index of the node
       parent_y=OPEN(node_index(OPEN,xval,yval),5);

       while( parent_x ~= xStart || parent_y ~= yStart)
               Optimal_path(i,1) = parent_x;
               Optimal_path(i,2) = parent_y;
               %Get the grandparents:-)
               inode=node_index(OPEN,parent_x,parent_y);
               parent_x=OPEN(inode,4);%node_index returns the index of the node
               parent_y=OPEN(inode,5);
               i=i+1;
       end

    else
     disp('Sorry, No path exists to the Target!');
    end

end








