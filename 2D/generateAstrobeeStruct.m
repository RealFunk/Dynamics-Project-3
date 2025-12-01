function astrobee = generateAstrobeeStruct()
    m = 1.0;
    L = 1.0;
    A = L^2;
    astrobee = struct('m', m, ...
                      'L', L, ...
                      'I_zz', 1/12*m*A, ...
                      't_end', 4, ...
                      'damping', 0.0004, ...
                      'vx0', 0, ...
                      'vy0', 0, ...
                      'omega0', 0, ...
                      'x0', 10, ...
                      'y0', 10, ...
                      'theta0', 0, ...
                      'ThrustMagnitude', 1, ...
                      'ThrustAngle', 0, ...
                      'r_CP0', 0);
end

%{
% Old code; do not use
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
%}