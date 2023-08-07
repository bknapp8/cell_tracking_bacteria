function frame = frame2frame_0_rememptyfields(frame)
% Remove empty fields from frame structure
for k=1:length(frame)
    rem_ind = [];
    for j=1:frame(k).num_objs
        if isempty(frame(k).object(j).Xcont)
            disp('Got one!');
            disp(k); disp(j);
            rem_ind = [rem_ind j];
        end
    end
    frame(k).object(rem_ind) = [];
end