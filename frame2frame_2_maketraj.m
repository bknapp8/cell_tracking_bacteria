function traj_totals = frame2frame_maketraj(frame)
clearvars -except frame;
F = length(frame); % Total number of frame

% Initialize structure that will contain trajectories (traj_totals)
traj_totals = struct();
i = 0; % Index for trajectories

% Loop over all frames
for fr=2:F-1
    disp(strcat('Creating trajectories starting in frame:',num2str(fr)));
    % 1. Find related cell in previous frame - if there is none, index = 1
    
    % Loop over all cells in frame
    for c=1:length(frame(fr).object)
        clearvars rel;
        for k=1:length(frame(fr-1).object)
            R = frame(fr-1).object(k).relation;
            if mean(size(R))==1

                rel(k) = R;
            end

        end

        % Proceed only if there is a relation to the previous frame
        if exist('rel')
            % Test relationship
            rel = rel';
            %x = find(rel==c);
        else
            rel = [];
        end

            % 2. Is this the first frame? If so, will run through entire 
            % trajectories from current frame until last

            j = 0;
            if (sum(rel~=c)==length(rel)) || fr==2
                %disp('yay!');
                % Store first frame of this cell's trajectory
                i = i+1;
                j = j+1;

                traj_totals(i).traj(j) = frame(fr).object(c);

                stop = false;
                % Loop over all further frames
                for s=fr:F-2
                    if ~stop
                        % IS THE NEXT FRAME RELATED?
                        R = frame(s).object(c).relation;
                        if mean(size(R))==1
                            j = j+1;
                            %n = find(rel==c);

                            traj_totals(i).traj(j) = frame(s+1).object(R);
                            
                            c = R;

                            stop = false;
                        else 
                            stop = true;
                        end

                    end
                end
            end
    end
end




