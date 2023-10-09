function [dydt] = Komplettes_System(t, y, params, Vsoll, Vsolldot)
    % Gegebene Parameter
    a0 = params.a0;
    a1 = params.a1;
    K0 = params.K0;
    K1 = params.K1;
    Kp = params.Kp;
    Kv = params.Kv;
    
    % Drehzallsollwert
    Fr = K1*Kp*Vsolldot(t) + K0*Kp*Vsoll(t);
    
    % Differentialgleichung des kompletten Systems
    dydt = [y(2); y(3); Kv*Fr - a1*y(3) - (a0 + Kv*K1*Kp) * y(2) - Kv*K0*Kp*y(1)];
end