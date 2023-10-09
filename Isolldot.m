function [value] = Isolldot(t)
    if (0 < t) && (t <= 2)
        value = 0;
    elseif (2 < t) && (t <= 4)
        value = -4/3;
    else
        value = 0.0;
    end
end

