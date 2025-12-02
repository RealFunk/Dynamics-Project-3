function makePlots(time, targetTime, targetPosX, targetPosY, posX, posY, velX, velY, theta, omega, errorTime, posError, errorX, errorY, thrustProfiles, dt, astrobee)
    
    figure
    subplot(2,3,1)
    hold on
    plot(targetPosX, targetPosY, 'b', 'LineWidth', 1)
    plot(posX, posY, 'r', 'LineWidth', 1);
    legend('Ideal', 'Actual')
    xlabel('X distance (m)')
    ylabel('Y distance (m)')
    title('Trajectory')
    grid on
    axis equal
    hold off

    subplot(2,3,2)
    hold on
    plot(time, velX, 'r')
    plot(time, velY, 'b')
    legend('x-direction', 'y-direction')
    ylabel('velocity (m/s)')
    xlabel('time (s)')
    title('Velocity over time')
    grid on
    hold off

    subplot(2,3,3)
    hold on
    plot(time, omega, 'r')
    legend('angular velocity')
    ylabel('angular velocity (rad/s)')
    xlabel('time (s)')
    title('Angular velocity over time')
    grid on
    hold off

    subplot(2,3,4)
    hold on
    plot(time, astrobee.I_zz*omega, 'r')
    legend('angular momentum')
    ylabel('angular momentum (kg*m^2/s)')
    xlabel('time (s)')
    title('Angular momentum over time')
    grid on
    hold off

    subplot(2,3,5)
    hold on
    plot(errorTime, posError, 'g', 'LineWidth', 2)
    plot(errorTime, errorX, 'r');
    plot(errorTime, errorY, 'b');
    legend('Total error', 'X error', 'Y error')
    xlabel('time (s)')
    ylabel('positional error (m)')
    title('Error')
    grid on
    hold off

    subplot(2,3,6)
    hold on
    thrustTime = linspace(time(1),time(end),length(thrustProfiles.T_TL));
    plot(thrustTime, thrustProfiles.T_TL, 'r');
    plot(thrustTime, thrustProfiles.T_BL, 'Color', [1, 0.5, 0]);
    plot(thrustTime, thrustProfiles.T_TR, 'g');
    plot(thrustTime, thrustProfiles.T_BR, 'b');
    legend('Top Left', 'Bottom Left', 'Top Right', 'Bottom Right')
    xlabel('time (s)')
    ylabel('thrust (N)')
    title('Thrust Profiles')
    grid on
    hold off

end