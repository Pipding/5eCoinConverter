function isDivisibleBy(x, y)
    if(x % y == 0) then
        return true
    else
        return false
    end
end


function makeDivisibleBy(x, y)
    remainder = 0

    while( (isDivisibleBy(x, y) == false) and (x > 0) ) do
        x = x - 1
        remainder = remainder + 1
    end

    return x, remainder
end