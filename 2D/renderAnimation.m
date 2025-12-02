function renderAnimation(time, targetTime, targetPosX, targetPosY, posX, posY, theta, thrustProfiles, astrobee)
    
    %{
    fig = figure(1)
    set(fig, 'Position', [0,0,1200,500])
    fps = 20;
    timescale = 1; % realtime
    simmed_time = time(end)-time(1);
    total_length = simmed_time/timescale;
    total_num_frames = total_length * fps;
    time_samples_per_frame = length(time)/total_num_frames;
    filename = 'Dynamics-Project-3';
    video = VideoWriter(filename, 'MPEG-4');
    open(video);
    for i = 1:total_num_frames
        hold on
        clf

        t = 1 + floor(i*time_samples_per_frame);

        pos_x = posX(t);
        pos_y = posY(t);

        % Plot trajectory
        a = theta(t);
        R = [cos(a), -sin(a); sin(a) cos(a)];
        vec = [-1, -1; -1, 1; 1, 1; 1, -1]'.*astrobee.L/2;
        rotated_vec = R*vec;
        fill(rotated_vec(1,:) + pos_x, rotated_vec(2,:) + pos_y, 'b')

        % Plot ideal trajectory
        plot(targetPosX, targetPosY, 'b')

        xlabel('X distance (m)')
        ylabel('Y distance (m)')
        title('Trajectory')
        axis equal
        pause(0.001)
        frame = getframe(gcf);
        writeVideo(video, frame);
    end
    close(video);
    %}

end