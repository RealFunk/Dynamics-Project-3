function thrustProfileStruct = solveThrustProfiles(targetTime, targetPosX, targetPosY, astrobee, dt)
% Returns an array of "thrust profiles", which give the thrust in N of a
% thruster. Each row corresponds to a thruster, and each column is a
% timestep.

%{
        TL --> [   ] <-- TR
        BL --> [   ] <-- BR
%}

    m = astrobee.m;
    I = astrobee.I_zz;
    L = astrobee.L;
    thrustProfiles = [];

    % Hard-coded path
    thrustProfiles = [thrustProfiles moveRight(10, 3, m, dt)];
    thrustProfiles = [thrustProfiles rotateCCW(90, 1, I, L, dt)];
    thrustProfiles = [thrustProfiles moveRight(15, 3, m, dt)];
    thrustProfiles = [thrustProfiles rotateCW(90, 1, I, L, dt)];
    thrustProfiles = [thrustProfiles moveRight(30, 3, m, dt)];
    thrustProfiles = [thrustProfiles rotateCW(90, 1, I, L, dt)];
    thrustProfiles = [thrustProfiles moveRight(15, 3, m, dt)];
    thrustProfiles = [thrustProfiles rotateCCW(90, 1, I, L, dt)];
    thrustProfiles = [thrustProfiles moveRight(10, 3, m, dt)];

    timeSpan = dt:dt:dt*length(thrustProfiles(1,:));

    TL = thrustProfiles(1,:);
    BL = thrustProfiles(2,:);
    BR = thrustProfiles(3,:);
    TR = thrustProfiles(4,:);
    thrustProfileStruct = struct('T_TL', TL, 'T_BL', BL, 'T_BR', BR, 'T_TR', TR, 'timeSpan', timeSpan);

end



function thrustProfiles = moveRight(totalDistance, totalTime, m, dt)

    %{
        F = m * a = n * T
        T = m * a / n
        d = 1/2 * a * t_half^2
        total_distance = 2 * 1/2 * a * t_half^2
        total_distance = 1/4 * a * t_total^2
        a = 4 * total_distance / t_total^2
        T = 4 * m * total_distance / ( n * t_total^2 )
    %}

    numTimesteps = floor(totalTime/dt);
    thrustProfiles = zeros(4, numTimesteps); % TL; BL; BR; TR
    n = 2; % Two thrusters are activated at one time
    T =  4 * m * totalDistance / ( n * totalTime^2 );

    thrustProfiles(1,1:floor(end/2)) = T;
    thrustProfiles(2,1:floor(end/2)) = T;
    thrustProfiles(3,1+floor(end/2):end) = T;
    thrustProfiles(4,1+floor(end/2):end) = T;
end



function thrustProfiles = moveLeft(totalDistance, totalTime, m, dt)

    %{
        F = m * a = n * T
        T = m * a / n
        d = 1/2 * a * t_half^2
        total_distance = 2 * 1/2 * a * t_half^2
        total_distance = 1/4 * a * t_total^2
        a = 4 * total_distance / t_total^2
        T = 4 * m * total_distance / ( n * t_total^2 )
    %}

    numTimesteps = floor(totalTime/dt);
    thrustProfiles = zeros(4, numTimesteps); % TL; BL; BR; TR
    n = 2; % Two thrusters are activated at one time
    T =  4 * m * totalDistance / ( n * totalTime^2 );

    thrustProfiles(1,1:floor(end/2)) = T;
    thrustProfiles(2,1:floor(end/2)) = T;
    thrustProfiles(3,1+floor(end/2):end) = T;
    thrustProfiles(4,1+floor(end/2):end) = T;
end



function thrustProfiles = rotateCCW(degrees, totalTime, I, L, dt)
    
    %{
        M = I * alpha + ( omega x I*omega )
          = I * alpha 
          = r x 2*T_vec
        theta_change_half = 1/2 * alpha * t_half^2
        theta = 2 * 1/2 * alpha * t_half^2
              = 1/4 * alpha * t_total^2
        alpha = 4 * theta / t_total^2
              = r x 2*T_vec / I
              = T * 2 * ( r x normal_vec ) / I
        T = 4 * theta * I / ( 2 * r x normal_vec * t_total^2 )
          = 2 * theta * I / ( r x normal_vec * t_total^2 )

        r x normal_vec = rx*ny - ry*nx
                       = - ry*nx

        T = 2 * theta * I / ( - ry * nx * t_total^2 )
    %}

    theta = degrees*pi/180;
    numTimesteps = floor(totalTime/dt);
    thrustProfiles = zeros(4, numTimesteps); % TL; BL; BR; TR
    r_times_normal_vec = - L/2 * (-1); % Turning CCW, top right thruster is activated, so thrust is  in -x direction
    T =  2 * theta * I / ( r_times_normal_vec * totalTime^2 );

    thrustProfiles(2,1:floor(end/2)) = T;
    thrustProfiles(4,1:floor(end/2)) = T;
    thrustProfiles(1,1+floor(end/2):end) = T;
    thrustProfiles(3,1+floor(end/2):end) = T;

end



function thrustProfiles = rotateCW(degrees, totalTime, I, L, dt)
    
    %{
        M = I * alpha + ( omega x I*omega )
          = I * alpha 
          = r x 2*T_vec
        theta_change_half = 1/2 * alpha * t_half^2
        theta = 2 * 1/2 * alpha * t_half^2
              = 1/4 * alpha * t_total^2
        alpha = 4 * theta / t_total^2
              = r x 2*T_vec / I
              = T * 2 * ( r x normal_vec ) / I
        T = 4 * theta * I / ( 2 * r x normal_vec * t_total^2 )
          = 2 * theta * I / ( r x normal_vec * t_total^2 )

        r x normal_vec = rx*ny - ry*nx
                       = - ry*nx

        T = 2 * theta * I / ( - ry * nx * t_total^2 )
    %}

    theta = degrees*pi/180;
    numTimesteps = floor(totalTime/dt);
    thrustProfiles = zeros(4, numTimesteps); % TL; BL; BR; TR
    r_times_normal_vec = - L/2 * (-1); % Turning CW, top left thruster is activated, so thrust is  in +x direction
    T =  2 * I * theta / ( r_times_normal_vec * totalTime^2 );

    thrustProfiles(1,1:floor(end/2)) = T;
    thrustProfiles(3,1:floor(end/2)) = T;
    thrustProfiles(2,1+floor(end/2):end) = T;
    thrustProfiles(4,1+floor(end/2):end) = T;

end

