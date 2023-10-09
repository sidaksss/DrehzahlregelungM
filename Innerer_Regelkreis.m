function [dydt] = Innerer_Regelkreis(t, y, params, Isoll, Isolldot)
    % Gegebene Parameter
    a0 = params.a0;
    a1 = params.a1;
    K0 = params.K0;
    K1 = params.K1;
    Kp = params.Kp;
    Kv = params.Kv;
    
    % Anfangsdifferentialgleichung (1)
    dydt = [y(2); K1*Isolldot(t) + K0*Isoll(t)-a1*y(2)-a0*y(1)];
end