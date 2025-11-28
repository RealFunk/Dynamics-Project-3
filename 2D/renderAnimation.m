function renderAnimation(time, targetTime, targetPosX, targetPosY, posX, posY, theta, thrustProfiles, astrobee)

    %{
    plot(time, 180*theta/pi, 'b')
    xlabel('time (s)')
    ylabel('angle (deg)')
    title('Angle over time')
    grid on
    %}

    hold on
    plot(posX, posY, 'r');
    plot(targetPosX, targetPosY, 'b')
    xlabel('X distance (m)')
    ylabel('Y distance (m)')
    title('Trajectory')
    grid on
    axis equal
    hold off

end