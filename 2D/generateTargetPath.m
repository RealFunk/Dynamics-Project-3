function [targetTime, targetPosX, targetPosY, targetPosZ] = generateTargetPath()
% TODO: Add documentation here

    targetTime = 0:0.1:10;
    targetPosX = cos(targetTime);
    targetPosY = sin(targetTime);
    targetPosZ = 0*targetPosY;
end