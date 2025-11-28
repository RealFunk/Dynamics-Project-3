function astrobee = generateAstrobeeStruct()
% TODO: Add documentation here

    % Physical parameters

    m = 1.0; % kg

    l = 1.0; % x-axis
    w = 1.0; % y-axis

    % Moment of inertia
    I = (l^2 + w^2)*m/12;

    % Thruster locations (m)
    r1 = [l/2; w/2];
    r2 = [-l/2; w/2];
    r3 = [-l/2; -w/2];
    r4 = [l/2; -w/2];
    thrusterLocations = [r1 r2 r3 r4];

    % Thruster directionss (dimensionless)
    % These point in the direction of thrust; that is, into the robot
    n1 = [-1; 0];
    n2 = [-1; 0];
    n3 = [1; 0];
    n4 = [1; 0];
    thrusterDirections = [n1 n2 n3 n4];

    % Package everything into the struct
    astrobee = struct('mass', m, 'length', l, 'width', w, 'inertiaTensor', I, 'thrusterLocations', thrusterLocations, 'thrusterDirections', thrusterDirections);
end