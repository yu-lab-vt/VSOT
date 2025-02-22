function [head_volume_img,cutVex] = genCutVolume_speedup(cutVexcell, pointID,Vnieuw, test_region2, allTetrax, allVertex, resx, resy, resz)
% output the voxels that belong to either head or sink part

xxshift0 = zeros(3,3,3);
yyshift0 = zeros(3,3,3);
zzshift0 = zeros(3,3,3);
for i = -1:1
    for j = -1:1
        for k = -1:1
            xxshift0(i+2, j+2, k+2) = i;
            yyshift0(i+2, j+2, k+2) = j;
            zzshift0(i+2, j+2, k+2) = k;
        end
    end
end
    
    [lenx, leny, lenz] = size(test_region2);
    cutVex = cutVexcell{pointID};
    facesx = [allTetrax(:, [1,2,3]), [1:size(allTetrax,1)]'; allTetrax(:,[1,3,4]), [1:size(allTetrax,1)]';allTetrax(:, [1,2,4]), [1:size(allTetrax,1)]';allTetrax(:, [2,3,4]), [1:size(allTetrax,1)]'];
    facesx(:,1:3) = sort(facesx(:,1:3), 2);
    facesx = sortrows(facesx, [1:3]);
    [~, ia_face,ic_face] = unique(facesx(:, 1:3), 'rows');
    countsx = accumarray(ic_face, 1);
    id_single_tri = ia_face(countsx == 1);
    face_graph0 = facesx(id_single_tri, 1:3);

    face_node_id = unique(face_graph0(:)); % this node id is actually the id of the vertex
    uniqueXYZ = allVertex;
    bbccIDxyz = uniqueXYZ(face_node_id,:);
    bbNode = Vnieuw(cutVex,:);
    head_volume_img = zeros(lenx, leny,lenz);
    newEdgeSequenceMAT = zeros(size(bbNode,1),1); % the boundary nodes
    for i = 1:size(bbNode,1)
        
        newEdgeSequenceMAT(i) = face_node_id(bbccIDxyz(:,1) == bbNode(i,1) & bbccIDxyz(:,2) == bbNode(i,2) & bbccIDxyz(:,3) == bbNode(i,3));
        
    end
    % remove the repetitve 
    % remove this sequence of edge to separate the surface into two part
    % attention: some triangles might be formed by on the boundary points
    newEdgeSequence = [newEdgeSequenceMAT(1:end-1), newEdgeSequenceMAT(2:end); [newEdgeSequenceMAT(end), newEdgeSequenceMAT(1)]];
    newEdgeSequence = sort(newEdgeSequence, 2);
    edge_graph0_x = [[face_graph0(:,1), face_graph0(:,2), [1:size(face_graph0,1)]' ]; [face_graph0(:,2), face_graph0(:,3),[1:size(face_graph0,1)]' ];...
        [face_graph0(:,1), face_graph0(:,3),[1:size(face_graph0,1)]' ]];
    edge_graph0_x(:,1:2) = sort(edge_graph0_x(:,1:2) , 2);
    edge_graph0_x(ismember(edge_graph0_x(:,1:2),newEdgeSequence, 'rows'),:) = [];%remove the boundary edges 
    edge_graph0_x = sortrows(edge_graph0_x, [1,2]);
    face_graph0_no_bd = [edge_graph0_x(1:2:end-1, 3), edge_graph0_x(2:2:end, 3)];
    face_graph0_no_bd_G = graph(face_graph0_no_bd(:,1), face_graph0_no_bd(:,2));
    bins = conncomp(face_graph0_no_bd_G);
    bins_count = accumarray(bins(:), 1);
    [~, sortedID] = sort(bins_count,'descend');
    vertexSourceSurface = facesx(id_single_tri(bins == sortedID(1)),1:3);
    vertexSourceSurface_node = setdiff(unique(vertexSourceSurface(:)), newEdgeSequence(:));% when the edge (cut boundary) lies exactly at the edge of the tetrahedron remove it
    source_tetra_label = facesx(ismember(facesx(:,1), vertexSourceSurface_node)|ismember(facesx(:,2), vertexSourceSurface_node)|ismember(facesx(:,3), vertexSourceSurface_node), 4);
    source_tetra_label = unique(source_tetra_label(:));
    vertexSinkSurface = facesx(id_single_tri(bins == sortedID(2)),1:3);
    vertexSinkSurface_node = setdiff(unique(vertexSinkSurface(:)), newEdgeSequence(:));
    sink_tetra_label = facesx(ismember(facesx(:,1), vertexSinkSurface_node)|ismember(facesx(:,2), vertexSinkSurface_node)|ismember(facesx(:,3), vertexSinkSurface_node), 4);
    sink_tetra_label = unique(sink_tetra_label(:));


    if(~isempty(source_tetra_label)&& ~isempty(sink_tetra_label))
        source_tetra_label = setdiff(source_tetra_label, sink_tetra_label);   
        face_graphx = zeros(sum(countsx == 2),2); % tetrahedron- tetrahedron pair
        unique_face = zeros(sum(countsx == 2), 3);
        idx = ia_face(countsx == 2);
        for i = 1:size(idx, 1)

            face_graphx(i,:) = [facesx(idx(i), 4), facesx(idx(i)+1, 4)];
            unique_face(i,:) = [facesx(idx(i),1) , facesx(idx(i),2), facesx(idx(i),3)]; % the shared face triangle between the two tetrahedron
        end
        vectorMF3_1 = uniqueXYZ(unique_face(:,3),:) - uniqueXYZ(unique_face(:,1),:);
        vectorMF3_1 = vectorMF3_1.*[resx, resy, resz];
        vectorMF3_2 = uniqueXYZ(unique_face(:,3),:) - uniqueXYZ(unique_face(:,2),:);
        vectorMF3_2 = vectorMF3_2.*[resx, resy, resz];
        ss_tmp = cross(vectorMF3_1, vectorMF3_2,2);
        face_area = 1/2*(sqrt(ss_tmp(:,1).^2 + ss_tmp(:,2).^2 + ss_tmp(:,3).^2));
        maxWeight = sum(face_area(:));
        unaryMex = zeros(max(facesx(:,4)), 2);
        unaryMex(source_tetra_label,1) = maxWeight;
        unaryMex(sink_tetra_label, 2) = maxWeight;
        pairwiseMex = [face_graphx, face_area,face_area];
        [label_cut] = solve_min_cut(unaryMex,pairwiseMex); % mex function solve max-flow using ibfs library faster than MATLAB built-in function
        cs = find(label_cut == 0);
        ct = find(label_cut == 1);
        head_tetra_faces = facesx(ismember(facesx(:,4), cs), 1:3);
        head_volume = allVertex(unique(head_tetra_faces(:)),:);
        head_volume_x = head_volume(:,1) + xxshift0(:)';
        head_volume_x(head_volume_x > lenx | head_volume_x < 1 ) =nan;
        head_volume_y = head_volume(:,2) + yyshift0(:)';
        head_volume_y(head_volume_y > leny | head_volume_y < 1 ) =nan;
        head_volume_z = head_volume(:,3) + zzshift0(:)';
        head_volume_z(head_volume_z > lenz | head_volume_z < 1 ) =nan;
        head_volume_output = head_volume_x(:) + (head_volume_z(:) - 1).*(lenx*leny) + (head_volume_y(:)-1).*lenx;
        % head_volume_output = sub2ind([lenx, leny, lenz],head_volume_x(:), head_volume_y(:), head_volume_z(:));
        head_volume_output = unique(head_volume_output);
        head_volume_output(isnan(head_volume_output)) = [];
        head_volume_img(head_volume_output) = 1;
        head_volume_img = head_volume_img.*double(test_region2);
    end






end