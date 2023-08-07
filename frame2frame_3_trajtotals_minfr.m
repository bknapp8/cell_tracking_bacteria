function traj_totals_minfr = frame2frame_trajtotals_minfr(traj_totals)
% Remove trajectories of length less than 'minfr'
minfr = 10;
rem_fr = [];

j = 0;
for s = 1:length(traj_totals)
    if length(traj_totals(s).traj)<minfr
        j = j+1;
        rem_fr(j) = s;
    end
end

if exist('rem_fr')
    traj_totals(rem_fr') = [];
end
traj_totals_minfr = traj_totals;