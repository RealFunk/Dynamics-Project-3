function [timelist, positionX, positionY] = R_path
% Creates the custom path required for Milestone 4
% Hard coded, I can change this if we want to make it more versatile

% I wanted to make an R shaped path in order to stand for Rufus
initialX = 10;
initialY = 10;

% Size of path area
sizeX = 50; % (m)
sizeY = 50; % (m)

% Initial parameters
dt = 0.1;
dtheta = 0.05;
time = 0;
path_posX = initialX;
path_posY = initialY;

% Vectors
timelist = [0];
positionX = [initialX];
positionY = [initialY];

% R parameters
R_height = 30;
loop_r = 7;
loopC_X = initialX + loop_r/2;
loopC_Y = initialY + R_height - loop_r;

while path_posY < 40
    path_posY = path_posY + dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];

    time = time + dt;
    timelist = [timelist, time];
end

for theta = pi/2:-dtheta:-pi/2
    path_posX = loopC_X + loop_r*cos(theta);
    path_posY = loopC_Y + loop_r*sin(theta);

    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];

    time = time + dt;
    timelist = [timelist, time];
end

while path_posY > 10
    path_posX = path_posX + dt;
    path_posY = path_posY - 1.5*dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];
    
    time = time + dt;
    timelist = [timelist, time];
end

end