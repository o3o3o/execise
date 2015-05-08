-- function 
--[[
function newCounter()
    local i = 0
    return function ()
        i = i+1
        return i
    end

end
function f()
    local i = 5
    return  i
end
function integral(f)
    return f();
end
]]--
function con(...)
    local s
    for i, v in ipairs{...} do
        if s then
            s = s .. v
        else
            s = v
        end
    end
    return s
end
function all(t)
    return table.unpack(t)
end
function cdr(...)
    local t
    for i,v in ipairs{...} do
        if i ~= 0 then
            table.insert(t, v)
        end
    end
    return table.unpack(t)
end
--print(con("1.",2,3,4))


