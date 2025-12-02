function [time, error, errorX, errorY] = getError(time, posX, posY, targetTime, targetPosX, targetPosY)
    %{
    % Error at each timestep (timesteps do not line up)
    t = linspace(max(time(1), targetTime(1)), min(time(end), targetTime(end)), 1000);
    newPosX = interp1(time, posX, t, 'linear');
    newPosY = interp1(time, posY, t, 'linear');
    newTargetPosX = interp1(targetTime, targetPosX, t, 'linear');
    newTargetPosY = interp1(targetTime, targetPosY, t, 'linear');
    errorX = newPosX - newTargetPosX;
    errorY = newPosY - newTargetPosY;
    error = sqrt( errorX.^2 + errorY.^2 );
    time = t;
    %}
    
    % Error as minimum distance
    time = time;
    error = [];
    errorX = [];
    errorY = [];
    for i = 1:length(posX)
        x1 = posX(i);
        y1 = posY(i);
        distance_squared = [];
        for j = 1:length(targetPosX)
            x2 = targetPosX(j);
            y2 = targetPosY(j);

            r_squared = (x1-x2)^2 + (y1-y2)^2;
            distance_squared = [distance_squared r_squared];
        end

        [min_distance_squared, index] = min(distance_squared);

        error = [error sqrt(min_distance_squared)];
        dx = x1-targetPosX(index);
        dy = y1-targetPosY(index);
        errorX = [errorX dx];
        errorY = [errorY dy];
    end
        

end

