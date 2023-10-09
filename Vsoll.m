function [value] = Vsoll(t)
    value = 1500*(1-exp(-2.5*t));
end

