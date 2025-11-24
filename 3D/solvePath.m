function [time, posX, posY, velX, velY, theta, omega] = solvePath(astrobee, thrustProfiles)
% TODO: Add documentation here

    % Init everything
    m = astrobee.mass;
    I = astrobee.inertiaTensor;

    % TODO: initial values for all of these things

    pos = []; % Inertial frame, in m
    vel = []; % Inertial frame, in m/s
    acc = []; % Inertial frame, in m/s^2
    euler_angle = []; % Inertial frame, in radians
    angular_vel = []; % Body frame, in radians/s
    angular_acc = []; % Body frame, in radians/s^2

    thrustProfiles 

    % Do simulation

    for t = 1:dt:t_duration

        % Prep
        F = [0; 0; 0];
        M = [0; 0; 0];
        thrusts = [];
        thruster_pos = []; % Body frame

        for i = length(thrusts_x)
            T = [thrusts]
            F = F + T;
        end


    end

end