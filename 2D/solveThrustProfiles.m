function thrustProfiles = solveThrustProfiles(targetTime, targetPosX, targetPosY, astrobee, dt)
% Returns an array of "thrust profiles", which give the thrust in N of a
% thruster. Each row corresponds to a thruster, and each column is a
% timestep.

    thrusterLocations = astrobee.thrusterLocations;
    thrustProfiles = [];
    m = astrobee.mass;

    %{
    [numThrusters, ~] = size(thrusterLocations);
    for i = 1:numThrusters

        % do something here, eventually
        % r = thrusterLocations(:,i);

        % for now, just do this
        thrustProfile = 0*targetTime;
        if i == 1
            thrustProfile = thrustProfile + 1;
        end

        thrustProfiles = [thrustProfiles; thrustProfiles];

    end
    %}

    thrustProfiles = [thrustProfiles moveForward(5, m, dt)];

end

% Hard-coded 2D analytical solution for our particular astrobee
function thrustProfiles = moveForward(distance, m, dt)
    totalTime = 1; % s
    time = 0:dt:totalTime;
    thrustProfiles = [0*time; 0*time; 0*time; 0*time]; % Each row is a thruster
    halfTime = totalTime/2;
    n = 2; % Two thrusters are activated at one time
    T = n*halfTime^2/(m*distance); % from formula d = 1/2 * a * t^2 for constant acceleration, and F = ma = nT

    thrustProfiles(3,1:end/2) = T;
    thrustProfiles(4,1:end/2) = T;
    thrustProfiles(1,1+end/2:end) = T;
    thrustProfiles(2,1+end/2:end) = T;
end

% Hard-coded 2D analytical solution for our particular astrobee
function thrustProfiles = rotateCW(degrees, I, dt)
    angle = degrees*pi/180;

    totalTime = 1; % s
    time = 0:dt:totalTime;
    thrustProfiles = [0*totalTime; 0*totalTime; 0*totalTime; 0*totalTime]; % Each row is a thruster
    halfTime = totalTime/2;
    n = 2; % Two thrusters are activated at one time
    T = 1; % Replace with a formula

    thrustProfiles(2,1:end/2) = T;
    thrustProfiles(4,1:end/2) = T;
    thrustProfiles(1,1+end/2:end) = T;
    thrustProfiles(3,1+end/2:end) = T;

end

