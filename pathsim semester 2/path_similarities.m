% load POINTMRO4
% init_script

path1 = csvread('path2.csv');
path2 = csvread('path3.csv');
path1_loop = length(path1);
path2_loop = length(path2);
max_path_length = min([path1_loop, path2_loop]);
sim_score_arr = zeros(max_path_length,1);

for i= 1:max_path_length
    first_mro = POINTMRO{path1(i,1),path1(i,2)}.mro;
    second_mro = POINTMRO{path2(i,1),path2(i,2)}.mro;
    simscore = vecsim_comp_record(first_mro, second_mro, 0, 0, VECSIM_para);
    sim_score_arr(i) = simscore.score;
end
count = 1;

for i= 1:path1_loop
    first_mro = POINTMRO{path1(i,1),path1(i,2)}.mro;
    for j=1:path2_loop
        second_mro = POINTMRO{path2(j,1),path2(j,2)}.mro;
        simscore = vecsim_comp_record(first_mro, second_mro, 0, 0, VECSIM_para);
        sim_score_arr(count) = simscore.score;
        count = count+ 1;
    end
end

sim_score_arr

sum(sim_score_arr(:) <= 4)

