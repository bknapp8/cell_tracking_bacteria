function newframe = frame2frame_makestruct(frame, cell_cut)
% Script for analyzing Morphometrics-processed bacterial images. The
% procedure identifies cell-cell relationships between frames, where a cell
% is identified in the next frame if it meets the following 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Cutoff for same-cell distance (default = 7 pixels)
if nargin < 2
    cell_cut = 7; % Number of pixels (5-10 is generally ok)
end

% Number of frames
nframes = length(frame);

% Create intermediate tree for analyzing phylogeny more easily
for k=1:nframes
    for j=1:length(frame(k).object)
        frame(k).object(j).frame_num = k;
    end
end

% Loop through each frame and find relation to next frame
for k=1:nframes-1
    disp(strcat('Finding cell-cell relations in frame:',num2str(k)));
    for i=1:numel(frame(k).object)
        % Initialize vectors for relational information
        diffcent = [];
        index = [];

        % Calculate difference between centers (N^2 operation)
        try
            for j=1:numel(frame(k+1).object)
                try
                    cent1 = [frame(k).object(i).Xcent_cont frame(k).object(i).Ycent_cont];
                    cent2 = [frame(k+1).object(j).Xcent_cont frame(k+1).object(j).Ycent_cont];

                    diffcent(j) = norm(cent1 - cent2);
                    index(j) = j;
                end
            end
        end
        % Sort differences (with indices) to speed up process
        difference = [diffcent' index'];
        [D, I] = sort(difference(:,1));

        % This is the analysis vector
        sortdiff = difference(I,:);

        % Is it the same cell?
        if sortdiff(1,1)<cell_cut
            frame(k).object(i).relation = sortdiff(1,2);
        else
            % If no relations, field is empty
            frame(k).object(i).relation = [];
        end
        
    end
end        
newframe = frame;