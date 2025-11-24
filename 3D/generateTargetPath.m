function [targetTime, targetPosX, targetPosY, targetPosZ] = generateTargetPath()
% TODO: Add documentation here

    targetTime = 0:0.01:10;
    targetPosX = cos(targetTime);
    targetPosY = sin(targetTime);
    targetPosZ = 0*targetPosY;
end