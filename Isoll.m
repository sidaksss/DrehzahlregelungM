function [value] = Isoll(t)
    if (0 < t) && (t <= 2)
        value = 4;
    elseif (2 < t) && (t <= 4)
        value = 4 - (4/3)*(t-2);
    else
        value = 0.0;
    end
end

