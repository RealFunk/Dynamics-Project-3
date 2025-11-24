function thrustProfiles = solveThrustProfiles(targetTime, targetPosX, targetPosY, targetPosZ, astrobee)
% Returns an array of "thrust profiles", which give the thrust in N of a
% thruster. Each row corresponds to a thruster, and each column is a
% timestep.

    thrusterLocations = astrobee.thrusterLocations;
    thrustProfiles = [];

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

end