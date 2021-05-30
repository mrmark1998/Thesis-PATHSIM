function path_similarities_M2(path1, path2)

    % Must load these databases/scripts for this to work
    load POINTMRO4
    load DISCON_MAT4
    init_script

    %constants
    path1_loop = length(path1);
    path2_loop = length(path2);
    max_path_length = min([path1_loop, path2_loop]);
    sim_score_arr = zeros(max_path_length,1);
    dpd_pairs = 0;

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

            % Disregards if simscore=-1 (invalid MRO comparison)
            if simscore.score == -1
                continue      
            end

            % If simscore > 4 (more than 200 meters), checks if points are in
            % the Discontinuity Pair Database

            if simscore.score > 4
                dpd_check = lookup_pair(first_mro, second_mro, VECSIM_para, PCI_ID, DISCON_MAT);
                if dpd_check == 1
                    dpd_pairs = dpd_pairs + 1;
                    continue
                end
            end

            sim_score_arr(count) = simscore.score;
            count = count+ 1;
        end
    end

    %Create Simscore Breakdown
    scoresBreakdown = zeros(8,1); % for example 1 is <25 meters, 8 is >200 meters
    for count = 1:8
        scoresBreakdown(count,1) = histc(sim_score_arr, count);
    end

    scoresBreakdown %displays scoresBreakdown in terms of array 1-8 * 25m 

    dpd_pairs %displays # of DPD pairs
    
end

