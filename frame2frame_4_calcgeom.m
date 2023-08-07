function traj_totals = frame2frame_4_calcgeom(traj_totals)
% Function for adding geometrics quantities after trajectories have been
% created
% Will act on traj_totals structure

for k=1:length(traj_totals)
    disp('Calculating geometries for trajectory:');
    disp(strcat(num2str(k), '/', num2str(length(traj_totals))));
    for j=1:length(traj_totals(k).traj)
        x = traj_totals(k).traj(j).Xcont;
        y = traj_totals(k).traj(j).Ycont;
        
        [W,L,A,S,V] = calc_geom_contour(x,y);
        traj_totals(k).traj(j).length = L;
        traj_totals(k).traj(j).width = W;
        traj_totals(k).traj(j).volume = V;
        traj_totals(k).traj(j).surfacearea = S;
        
    end
end
        