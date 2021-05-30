% "constants"
NUM_ADJACENT_TO_COMPARE = 15; %has to be an odd number to work

load POINTMRO4
init_script


path1 = coord1;
path2 = coord2;

path1_loop = length(path1);
path2_loop = length(path2);
max_path_length = min([path1_loop, path2_loop]);
lowerBound = (NUM_ADJACENT_TO_COMPARE-1)/2 * -1;
upperBound = (NUM_ADJACENT_TO_COMPARE-1)/2;
sim_score_arr = zeros(max_path_length*NUM_ADJACENT_TO_COMPARE,1);

sim_score_counter = 1;
for i= 1:path1_loop
    first_mro = POINTMRO{path1(i,1),path1(i,2)}.mro;
    
    n = 1;
    scoresForThisRow = [];
    for j=lowerBound:upperBound
        if i + j < 1 %skip if out of bounds
            continue 
        end
        if i + j > length(path2) %skip if out of bounds
            continue 
        end
        comparisonPoint = i + j;
        second_mro = POINTMRO{path2(comparisonPoint,1),path2(comparisonPoint,2)}.mro;
        simscore = vecsim_comp_record(first_mro, second_mro, 0, 0, VECSIM_para);
        if simscore.score == -1
            continue
        end
        scoresForThisRow = [[simscore.score];scoresForThisRow];
        n = n + 1;
    end
    if n-1 > 0
        sim_score_counter = sim_score_counter + 1;
        average = sum(scoresForThisRow,1) / (n - 1);
        sim_score_arr(sim_score_counter, 1) = average;
    end
end
sim_score_arr(sim_score_arr==0) = NaN;
scoresBreakdown = zeros(8,1); % for example 1 is <25 meters, 8 is >200 meters

for i=1:length(sim_score_arr)
    value = sim_score_arr(i,1);
    if value >= 7.5
        scoresBreakdown(8,1) = 1 + scoresBreakdown(8,1);
    elseif value >= 6.5
        scoresBreakdown(7,1) = 1 + scoresBreakdown(7,1);
    elseif value >= 5.5
        scoresBreakdown(6,1) = 1 + scoresBreakdown(6,1);
    elseif value >= 4.5
        scoresBreakdown(5,1) = 1 + scoresBreakdown(5,1); 
    elseif value >= 3.5
        scoresBreakdown(4,1) = 1 + scoresBreakdown(4,1);
    elseif value >= 2.5
        scoresBreakdown(3,1) = 1 + scoresBreakdown(3,1);
    elseif value >= 1.5
        scoresBreakdown(2,1) = 1 + scoresBreakdown(2,1);
    elseif value >= 0.5
        scoresBreakdown(1,1) = 1 + scoresBreakdown(1,1);
    end
end

sim_score_arr(:, 1)
scoresBreakdown(:,1)