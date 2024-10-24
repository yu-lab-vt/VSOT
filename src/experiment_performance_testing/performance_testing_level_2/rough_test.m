offFolder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/gt_300/surface_off_300';
annotationFolder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/gt_300/annotation_json_300';
annotationFolder_gt_curves = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/gt_300/cut_cycle_ID_300';
listx = dir([offFolder, '/*.off']);

our_method_cut_result_folder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/dendrite_segmentation_peer_methods/our_method/result_1007';
our_method_error_all = zeros(length(listx), 1) + nan;
our_method_error_all_dist = our_method_error_all;

for j = 1:length(listx)
    % j = 8 for testing
    namex = listx(j).name;
    namex = namex(1:end-4);
    % disp(namex)


    [Pts,Tri] = read_off(fullfile(offFolder, [namex , '.off']));
    Tri = Tri';
    Pts = Pts';

    gt_cut = readtable(fullfile(annotationFolder_gt_curves, [namex,'_cut.txt']));
    gt_cut = table2array(gt_cut);
    edge_graph = [Tri(:,1), Tri(:,2), [1:size(Tri,1)]';Tri(:,1), Tri(:,3),[1:size(Tri,1)]';Tri(:,2), Tri(:,3),[1:size(Tri,1)]'];
    edge_graph(:,1:2) = sort(edge_graph(:,1:2), 2);
    edge_graph = sortrows(edge_graph, [1,2]);
    % find the two furthest point on the surface
    g_edge = graph(edge_graph(1:2:end,1), edge_graph(1:2:end, 2), vecnorm(Pts(edge_graph(1:2:end,1),:) - Pts(edge_graph(1:2:end,2),:), 2,2));
    d = distances(g_edge);
    [ss, tt] = find(d == max(d(:)));
    p1 = ss(1);
    p2 = tt(1);
    face1 = find(Tri(:,1) == p1|Tri(:,2) == p1|Tri(:,3) == p1, 1);
    face2 = find(Tri(:,1) == p2|Tri(:,2) == p2|Tri(:,3) == p2, 1); 

    cut_curve_edges = [gt_cut(1:end),[gt_cut(2:end);gt_cut(1)]];
    cut_curve_edges = sort(cut_curve_edges, 2);
    edge_graph_2 = edge_graph;
    edge_graph_2(ismember(edge_graph_2(:,1:2), cut_curve_edges, 'rows'),:) = [];
    face_G = graph(edge_graph_2(1:2:end,3), edge_graph_2(2:2:end,3));
    [bins, binsizes] = conncomp(face_G);
    [~, sortedID] = sort(binsizes, 'descend');
    if(length(binsizes) == 1)
        % warning('incomplete separation %s',namex);
    else
        part1_can = find(bins == sortedID(1));
        if(any(part1_can == face1))
            part1 = find(bins == sortedID(1));
            part2 = find(bins == sortedID(2));
        else
            part1 = find(bins == sortedID(2));
            part2 = find(bins == sortedID(1));
        end
    end


    if(exist(fullfile(our_method_cut_result_folder,[namex,'_cut_v2.txt']), 'file'))

        our_method_cut = readtable(fullfile(our_method_cut_result_folder,[namex,'_cut_v2.txt']));
        our_method_cut = table2array(our_method_cut);
        [error_our_tmp,error_our_tmp_dist]  = checkSegDiff(Tri, Pts, face1, part1, part2, edge_graph, gt_cut, our_method_cut);
        our_method_error_all(j) = error_our_tmp;
        our_method_error_all_dist(j) = error_our_tmp_dist;
    end
end
disp('finished');