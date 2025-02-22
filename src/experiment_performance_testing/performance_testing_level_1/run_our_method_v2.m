% experiment 1
% The data is from the dendrite #5 which was used in Kasthuri 2015 paper.
% The workflow:
% 1. since there is no soma in this test data, extract the apical dendrite
% and its branches. Basde on the names of the structures in the annotation
% file, as well as the hierachical relationshiop between different objects,
% obtain each individual branches.
% 2. Run our level-1 segmentation method
% 3. Generate surface reconstruction for the volume which might be used in
% other methods

addpath('../resources/curvatures/')
addpath('../resources/ImprovedSurfaceSmooth/')
addpath('../resources/CurvatureEstimation')
addpath('/home/boyu/Documents/edt_mex/edt_mex/edt_mex')
addpath('../resources/TAUBIN/TAUBIN/')
addpath('/home/boyu/Documents/iso2mesh/')
addpath('../resources/data_to_off/')
addpath('/home/boyu/Documents/src_mex/mex_EM_analysis/mex_EM_analysis')

%% step 1 preprocessing the ground truth dataset
% obtain the segmentation volume as well as the skeleton
%
% Run kimimaro for the skeleton generation 
%% step 2 run our method
lambda_all = [0.01:0.04:0.25];
parfor lambda_i = 1:length(lambda_all)
    lambda = lambda_all(lambda_i);
    list_of_folders = ["D5_Apical_Spines","D5_Branch_1","D5_Branch_2","D5_Branch_3","D5_Branch_4","D5_Branch_5"];


    resx = 24;
    resy = 24;
    resz = 30;

    rootfolder = '/work/boyu/EM_astrocyte/materials_for_paper_VSOT/test_segmentation_samples/dendrite_spine_segmentation';
    
    for i = 1:length(list_of_folders)
        cur_folder = convertStringsToChars(list_of_folders(i));
        mask_dendrite = tiffreadVolume(fullfile(rootfolder, cur_folder, [cur_folder,'_dendrite_volume.tif.tif'])) > 0;
        mask_skel = tiffreadVolume(fullfile(rootfolder, cur_folder, 'ds_skeleton.tif')) > 0;
        dist_dendrite = cal_edt_dendrite(mask_dendrite, resx, resy, resz);
        [lenx, leny ,lenz] = size(mask_dendrite);
        % when the size of the dendrite shaft is too large, like the length
        % is larger than 500, then split the volume into several chunks and
        % do the segmentation in each separate chunk
        % running directly on a very large volume will likely cost many
        % memory and at the same time it will make the surface biased to the
        % global constraint. In stead of local smooth surface.
        if(lenx > 600 || leny > 600 || lenz > 600)
            maskRemoveAll = false(lenx, leny ,lenz);
            lmx = min(lenx, 400);
            lmy = min(leny, 400);
            lmz = min(lenz, 400);
            num_x = floor(lenx/ lmx);
            num_y = floor(leny/ lmy);
            num_z = floor(lenz/ lmz);
            for ix = 0:num_x
                for iy = 0:num_y
                    for iz = 0:num_z
                        disp([ix, iy, iz])
                        winx = [max((1 + ix*lmx - round(lmx/2)), 1), min((ix + 1)*lmx + round(lmx/2), lenx);max((1 + iy*lmy - round(lmy/2)), 1), min((iy + 1)*lmy + round(lmy/2), leny);max((1 + iz*lmz - round(lmz/2)), 1), min((iz + 1)*lmz + round(lmz/2), lenz)];
                        tmp_den = mask_dendrite(winx(1,1):winx(1,2), winx(2,1):winx(2,2), winx(3,1):winx(3,2));
                        tmp_skel = mask_skel(winx(1,1):winx(1,2), winx(2,1):winx(2,2), winx(3,1):winx(3,2));
                        if(sum(tmp_skel(:)) > 100) 
                            tmp_dist = dist_dendrite(winx(1,1):winx(1,2), winx(2,1):winx(2,2), winx(3,1):winx(3,2));
                            % run segmentation based on the surface_volume optimization
                            maskRemove_tmp = level_1_segmentation_function_fin_2(tmp_den, tmp_skel, tmp_dist,resx, resy, resz, lambda);
                            maskRemoveAll(winx(1,1):winx(1,2), winx(2,1):winx(2,2), winx(3,1):winx(3,2)) = maskRemove_tmp | maskRemoveAll(winx(1,1):winx(1,2), winx(2,1):winx(2,2), winx(3,1):winx(3,2));
                        end
                    end
                end
            end
        else
            maskRemoveAll = level_1_segmentation_function_fin_2(mask_dendrite,mask_skel,dist_dendrite, resx, resy, resz,lambda);
        end
    %     
        mask_spine = xor(mask_dendrite,maskRemoveAll);
        mask_spine_roi = bwlabeln(mask_spine);
        mask_spine_roi_idx = label2idx(mask_spine_roi);
        mask_spine_roi_idx = mask_spine_roi_idx(:);
        % check the index of the spine region that touches the border
        % check the six border of the volume
        border_idx = [];
        tmp = mask_spine_roi(1,:,:);
        border_idx = [border_idx; unique(tmp(:))];
        tmp = mask_spine_roi(end,:,:);
        border_idx = [border_idx; unique(tmp(:))];
        tmp = mask_spine_roi(:,1,:);
        border_idx = [border_idx; unique(tmp(:))];
        tmp = mask_spine_roi(:,end,:);
        border_idx = [border_idx; unique(tmp(:))];
        tmp = mask_spine_roi(:,:,1);
        border_idx = [border_idx; unique(tmp(:))];
        tmp = mask_spine_roi(:,:,end);
        border_idx = [border_idx; unique(tmp(:))];
        border_idx = unique(border_idx);
        border_idx(border_idx == 0) = [];
        maskRemoveAll(cell2mat(mask_spine_roi_idx(border_idx))) = 1;
        mask_spine = xor(mask_dendrite,maskRemoveAll);
        save_path = fullfile(rootfolder,  'our_method_result', cur_folder,['lambda_index_test_2', num2str(lambda_i)]);
        if(~exist(save_path, 'dir'))
            mkdir(save_path);
        end
        tifwrite(uint8(255*mask_spine), fullfile(save_path, 'spine_segmentation'));
        tifwrite(uint8(255*maskRemoveAll), fullfile(save_path, 'shaft_segmentation'));    

    end


    % for i = 1:length(list_of_folders)
    %     cur_folder = convertStringsToChars(list_of_folders(i));
    %     mask_spine = tiffreadVolume(fullfile(rootfolder, cur_folder, 'spine_segmentation.tif')) > 0;
    %     mask_shaft = tiffreadVolume(fullfile(rootfolder, cur_folder, 'shaft_segmentation.tif')) > 0;
    %     outx = mask_spine*2 + mask_shaft;
    % end


end