function [targetTime, targetPosX, targetPosY] = generateTargetPath()
% TODO: Add documentation here

    targetTime = 0:0.01:10;
    targetPosX = cos(targetTime);
    targetPosY = sin(targetTime);
end