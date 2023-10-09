function [t, y] = Vorwaerts_Euler(dgl_fun, teval, y0)
    N = length(teval);

    % Reserviere Speicher
    y = zeros(N, length(y0));
    y(1, :) = y0;
    
    % Euler-Verfahren
    for i=1:N-1
       dt = teval(i+1)-teval(i);
       y(i+1, :) = y(i, :) + dt * dgl_fun(teval(i), y(i, :))';
    end
    t = teval;
end