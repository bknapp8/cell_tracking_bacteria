% Run frame2frame scripts on a single morphometrics output file (must be
% appended with _CONTOURS.mat)

clear;
close all;

% file = './test_data/20220505_BK001_LB_37to27_feature_0-cropped_07-May-2022_CONTOURS.mat';
% load(file);
frame = frame2frame_0_rememptyfields(frame);
newframe = frame2frame_1_makestruct(frame);
traj_totals = frame2frame_2_maketraj(newframe);
traj_totals_cut = frame2frame_3_trajtotals_minfr(traj_totals);
traj_totals_final = frame2frame_4_calcgeom(traj_totals_cut);

%% Save traj_totals structure
savingfile = false;

if savingfile
    save(strcat(file(end-4:end),'_TOTALS'),'traj_totals_final');
end
    