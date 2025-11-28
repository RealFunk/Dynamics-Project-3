function [timelist, positionX, positionY] = obstaclePath
% Creates the first path required for Milestone 3
% Hard coded, I can change this if we want to make it more versatile

initialX = 0
initialY = 10

% Size of path area
sizeX = 50 % (m)
sizeY = 50 % (m)

% Location of obstacle
o_posX = 25 % (m)
o_posY = 10 % (m)
o_radius = 5 % (m)
o_clearance = 10 % (m)

o_X1 = o_posX - o_radius - o_clearance 
o_Y1 = o_posY + o_radius + o_clearance 
o_X2 =  o_posX + o_radius + o_clearance 
o_Y2 = o_posY

% Initial parameters
dt = 0.1
time = 0
path_posX = initialX;
path_posY = initialY;

% Vectors
timelist = [0]
positionX = [initialX];
positionY = [initialY];

while path_posX < o_X1
    path_posX = path_posX + dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];
    
    time = time + dt;
    timelist = [timelist, time];
end

while path_posY < o_Y1
    path_posY = path_posY + dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];

    time = time + dt;
    timelist = [timelist, time];
end

while path_posX < o_X2
    path_posX = path_posX + dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];
    
    time = time + dt;
    timelist = [timelist, time];
end

while path_posY > o_Y2
    path_posY = path_posY - dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];

    time = time + dt;
    timelist = [timelist, time];
end

while path_posX < sizeX
    path_posX = path_posX + dt;
    positionX = [positionX, path_posX];
    positionY = [positionY, path_posY];
    
    time = time + dt;
    timelist = [timelist, time];
end
