function [time, posX, posY, velX, velY, theta, omega] = solvePath(astrobee, thrustProfiles)
    
    m = astrobee.m;
    I_zz = astrobee.I_zz;
    L = astrobee.L;
    
    if isfield(astrobee, 'x0')
        y0 = [astrobee.x0; astrobee.y0; astrobee.vx0; astrobee.vy0; astrobee.theta0; astrobee.omega0];
    else
        y0 = [0; 0; 0; 0; 0; 0];
    end
    
    timeSpan = thrustProfiles.timeSpan;
    T_TL = thrustProfiles.T_TL;
    T_BL = thrustProfiles.T_BL;
    T_TR = thrustProfiles.T_TR;
    T_BR = thrustProfiles.T_BR;
    
    tStart = timeSpan(1);
    tEnd = timeSpan(end);
    
    odefun = @(t, y) robotDynamics(t, y, m, I_zz, L, timeSpan, T_TL, T_BL, T_TR, T_BR);
    
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [time, state] = ode45(odefun, [tStart tEnd], y0, options);
    
    posX = state(:, 1);
    posY = state(:, 2);
    velX = state(:, 3);
    velY = state(:, 4);
    theta = state(:, 5);
    omega = state(:, 6);
    
end

function dydt = robotDynamics(t, y, m, I_zz, L, timeSpan, T_TL, T_BL, T_TR, T_BR)
    vx   = y(3);
    vy   = y(4);
    theta= y(5);
    omega= y(6);

    TL = interp1(timeSpan, T_TL, t, 'linear', 0);
    BL = interp1(timeSpan, T_BL, t, 'linear', 0);
    TR = interp1(timeSpan, T_TR, t, 'linear', 0);
    BR = interp1(timeSpan, T_BR, t, 'linear', 0);

    Fx_body = (TL + BL) - (TR + BR);
    Fy_body = 0;

    Fx_world = Fx_body * cos(theta) - Fy_body * sin(theta);
    Fy_world = Fx_body * sin(theta) + Fy_body * cos(theta); 
    ax = Fx_world / m;
    ay = Fy_world / m;
    r = L/2; 
    Tz = r * ( -TL + BL + TR - BR );
    alpha = Tz / I_zz;
    dydt = zeros(6,1);
    dydt(1) = vx;   
    dydt(2) = vy;        
    dydt(3) = ax;       
    dydt(4) = ay;         
    dydt(5) = omega;      
    dydt(6) = alpha; 
end