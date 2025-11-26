function [time, posX, posY, velX, velY, theta, omega] = solvePath(astrobee, thrustProfiles, dt)
% TODO: Add documentation here

    % Init everything
    numTimesteps = length(thrustProfiles(1,:));

    m = astrobee.mass;
    I = astrobee.inertiaTensor;

    pos = [0; 0];           % Inertial frame, in m
    vel = [0; 0];           % Inertial frame, in m/s
    acc = [0; 0];           % Inertial frame, in m/s^2
    angle = 0;              % Inertial frame, in radians
    angular_vel = 0;        % Body frame, in radians/s
    angular_acc = 0;        % Body frame, in radians/s^2
    time = 0;

    body_moments = [];         % Body frame, in m (multiply by N to get moment, N*m)
    thrusterLocations = astrobee.thrusterLocations;
    thrusterDirections = astrobee.thrusterDirections;
    [~, numThrusters] = size(thrusterLocations);
    for i = 1:numThrusters
        % for 3D case, this should be a cross product
        r = thrusterLocations(:,i);
        F = thrusterDirections(:,i);
        M = r(1)*F(2) - r(2)*F(1);
        body_moments = [body_moments M];
    end


    disp(body_moments)



    % Simulation
    for t = 1:numTimesteps

        % Prep
        s = pos(:,end);
        v = vel(:,end);
        a = acc(:,end);
        theta = angle(:,end);
        omega = angular_vel(:,end);
        alpha = angular_acc(:,end);
        time_now = time(end);

        F_body = [0; 0];
        M = 0;
        R = [cos(theta), -sin(theta); sin(theta), cos(theta)];

        for i = 1:numThrusters
            T = thrustProfiles(i,t);
            F_body = F_body + T*thrusterDirections(:,i);
            M = M + T*body_moments(i);
        end
        F_inertial = R*F_body;


        % Iteration
        s_next = s + v*dt;
        v_next = v + a*dt;
        a_next = F_inertial/m;
        theta_next = theta + omega*dt; % omega is the same in the inertial and the body frame
        omega_next = omega + alpha*dt;
        alpha_next = M/I - omega^2;
        t_next = time_now + dt;

        % Storage
        pos(:,end+1) = s_next;
        vel(:,end+1) = v_next;
        acc(:,end+1) = a_next;
        angle(end+1) = theta_next;
        angular_vel(end+1) = omega_next;
        angular_acc(end+1) = alpha_next;
        time(end+1) = t_next;

    end

    % Output
    posX = pos(1,:);
    posY = pos(2,:);
    velX = vel(1,:);
    velY = vel(2,:);
    theta = angle;
    omega = angular_vel;


end