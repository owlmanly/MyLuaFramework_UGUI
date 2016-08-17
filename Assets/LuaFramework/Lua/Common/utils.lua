function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function table.containKey( t, key )
    for k, v in pairs(t) do
        if key == k then
            return true;
        end
    end
    return false;
end

function table.containValue( t, value )
    for k, v in pairs(t) do
        if value == v then
            return true;
        end
    end
    return false;
end