function segmentation_our_own_method_from_volume(offFolder,tifResultFolder, our_method_cut_result_folder,tifFolder)
%     addpath('../resources/curvatures/')
%     addpath('../resources/ImprovedSurfaceSmooth/')
%     addpath('../resources/CurvatureEstimation')
%     addpath('/home/boyu/Documents/edt_mex/edt_mex/edt_mex')
%     addpath('../resources/TAUBIN/TAUBIN/')
%     addpath('/home/boyu/Documents/iso2mesh/')
%     addpath('../resources/data_to_off/')
%     addpath('/home/boyu/Documents/src_mex/mex_EM_analysis/mex_EM_analysis')
    
    % offFolder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/large_dataset_3_annotator_L2345_w_stubby/gt_final_800/off_file';
    % annotationFolder = '/work/boyu/EM_astrocyte/test_segmentation_samples/gt_300/annotation_json_300';
    % annotationFolder_gt_curves = '/work/boyu/EM_astrocyte/test_segmentation_samples/gt_300/cut_cycle_ID_300';
    listx = dir([offFolder, '/*.off']);
    % our_method_coordinate_folder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/large_dataset_3_annotator_L2345_w_stubby/dendrite_segmentation_peer_methods_large_dataset/our_result/head_neck_coor_result';
    % our_method_cut_result_folder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/VSOT_data_paired_with_codes/data/performance_testing_level_2_segmentation/large_dataset_3_annotator_L2345_w_stubby/dendrite_segmentation_peer_methods_large_dataset/our_result/cut_result';
    for j = 102
        
        namex = listx(j).name;
        namex = namex(1:end-4);
        disp(namex)
    
    
        [Pts,Tri] = read_off(fullfile(offFolder, [namex , '.off']));
        Tri = Tri';
        Pts = Pts';
    
    % 
    % figure;trisurf(Tri,Pts(:,1),Pts(:,2),Pts(:,3),'Facecolor','red','FaceAlpha',0.1);
    % 
    % figure;trisurf(mF2,Vnieuwx(:,1),Vnieuwx(:,2),Vnieuwx(:,3),'FaceVertexCData',ccScore_fin,'Facecolor','interp');
    % hold on;trisurf(mF2,Vnieuwx(:,1),Vnieuwx(:,2),Vnieuwx(:,3), 'Facecolor','blue','FaceAlpha',0.1)
    
    %% classify the face based on the volume segmentation of our method
        if(exist(fullfile(tifResultFolder,[namex,'.tif_head_neck.tif']), 'file'))
            % the coodinates have already been scaled with respect to the surface coordinates (2x, 2x, 5x)
            % the distance can be directly calculated from this mat file to the surface file
            % aa = load(fullfile(our_method_coordinate_folder,[namex,'_head.mat']));
            % coor_head_tmp = aa.coor_head;
            % bb = load(fullfile(our_method_coordinate_folder,[namex,'_neck.mat']));
            % coor_neck_tmp = bb.coor_neck;
            labelx = tiffreadVolume(fullfile(tifResultFolder, [namex,'.tif_head_neck.tif']));
            labelxidx = label2idx(labelx);
            [lenx, leny, lenz] = size(labelx);
            [HeadCoorx,HeadCoory, HeadCoorz]  = ind2sub([lenx, leny, lenz], labelxidx{3});
            [NeckCoorx,NeckCoory, NeckCoorz]  = ind2sub([lenx, leny, lenz], labelxidx{2});
            coor_head_tmp = [HeadCoorx,HeadCoory, HeadCoorz];
            coor_neck_tmp = [NeckCoorx,NeckCoory, NeckCoorz];
            if(isempty(coor_neck_tmp))
                %the cut will be directly at the interface between the spine and shaft
                [face_label,~] = gen_cut_surface_volume_spine_shaft(tifFolder,offFolder, namex);
            else
                face_center_idxyz = (Pts(Tri(:,1),:)+ Pts(Tri(:,2),:)+ Pts(Tri(:,3),:))/3;
                % check which face center should belong to the head part which should
                % belong to the neck part
                face_label = zeros(size(face_center_idxyz,1),1);
                for m = 1:size(face_center_idxyz,1)
                    dist2head = vecnorm(face_center_idxyz(m,:) - mean(coor_head_tmp,1), 2,2);
                    dist2neck = vecnorm(face_center_idxyz(m,:) - mean(coor_neck_tmp,1), 2,2);
                    if(dist2head < dist2neck)
                        face_label(m) = 2;
                    else
                        face_label(m) = 1;
                    end
                end
            end
                node_colorMap = zeros(length(Pts),4);
                node_colorMap2 = zeros(length(Pts),1);
                colormapx = [255, 0, 0, 255;0, 255, 0, 255;0, 0, 255, 255];
                edge_all = [[Tri(:,1), Tri(:,2), [1:size(Tri,1)]']; [Tri(:,1), Tri(:,3), [1:size(Tri,1)]'];[Tri(:,3), Tri(:,2), [1:size(Tri,1)]']];
                edge_all(:,1:2) = sort(edge_all(:,1:2), 2);
                edge_all = sortrows(edge_all,[1,2]);
                edge_all(:,3) = face_label(edge_all(:,3));
                a1 = [1:2:size(edge_all,1)];
                a2 = [2:2:size(edge_all,1)];
                id0 = find(edge_all(a1,3) ~= edge_all(a2,3));
                node_list = edge_all(a1(id0),1:2);
                node_list = unique(node_list(:));
                writematrix(node_list(:), fullfile(our_method_cut_result_folder,[namex,'.cut.txt']));
                head_neck_label = face_label;
                save(fullfile(our_method_cut_result_folder,[namex,'.face_label.mat']), 'head_neck_label');
            
        end
        
        % 
    %     node_colorMap2 = zeros(size(Pts,1),1);
    %     node_colorMap2(node_list(:)) = 1;
    % figure; trisurf(Tri, Pts(:,1), Pts(:,2), Pts(:,3), 'FaceVertexCData',node_colorMap2,'Facecolor','interp') 
    
    end
    