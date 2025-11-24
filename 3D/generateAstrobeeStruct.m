function astrobee = generateAstrobeeStruct()
% TODO: Add documentation here

    % Physical parameters

    m = 1.0; % kg

    l = 1.0; % x-axis
    w = 1.0; % y-axis
    h = 1.0; % z-axis

    % Inertia tensor of rectangular prism
    I = eye(3);
    I(1,1) = (1/12)*m*(w^2 + h^2);
    I(2,2) = (1/12)*m*(l^2 + h^2);
    I(3,3) = (1/12)*m*(l^2 + w^2);

    % Thruster locations (m)
    % In the x-axis points normal to Face 1, and anti-normal to Face 2
    % The vectors are given in order: Face 1, counterclockwise around the
    % positive x-axis, and face 2, counterclockwise about the positive
    % x-axis
    r1 = [ l/2; w/2; h/2 ];
    r2 = [ l/2; -w/2; h/2 ];
    r3 = [ l/2; -w/2; -h/2 ];
    r4 = [ l/2; w/2; -h/2 ];
    r5 = [ -l/2; w/2; h/2 ];
    r6 = [ -l/2; -w/2; h/2 ];
    r7 = [ -l/2; -w/2; -h/2 ];
    r8 = [ -l/2; w/2; -h/2 ];
    thrusterLocations = [r1 r2 r3 r4 r5 r6 r7 r8];

    % Thruster directionss (dimensionless)
    % These point in the direction of thrust; that is, into the robot
    n1 = [-1; 0; 0];
    n2 = [-1; 0; 0];
    n3 = [-1; 0; 0];
    n4 = [-1; 0; 0];
    n5 = [1; 0; 0];
    n6 = [1; 0; 0];
    n7 = [1; 0; 0];
    n8 = [1; 0; 0];
    thrusterDirections = [n1 n2 n3 n4 n5 n6 n7 n8];

    % Package everything into the struct
    astrobee = struct('mass', m, 'length', l, 'width', w, 'height', h, 'inertiaTensor', I, 'thrusterLocations', thrusterLocations, 'thrusterDirections', thrusterDirections);
end