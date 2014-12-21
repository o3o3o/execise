function ipairs(...)
    local t= {...}
    local tmp = {...}
    -- if nothing to iterate over just return a dummy iterator
    if #tmp == 0 then
        return function() end, nil, nil
    end
    local function mult_ipairs_it(t, i)
        i=i+1
        for j=1,#t do
            local val = t[j][i]
            if val == nil then  return val;end
            tmp[j] = val
        end
        return i, unpack(tmp)
    end
    return mult_ipairs_it, t, 0
end

--local t1 = {'a','b','c','d','e'}
--local t2 = {'A','B','C','D','E','F'}
---for k,v1,v2 in ipairs(t1,t2) do
---    print(k,v1,v2)
---end

function values (t)
    local i = 0
    return   function () i = i+1; return t[i]
    end
end

function vm ()
    local t1 = {'a','b','c','d','e'}
    local t = {10,20,30}
    iter = values(t1)
    while true do
        local element = iter()
        if element == nil then break; end
        print(element)
    end

    for element in values(t) do
        print(element);
    end
end

function allwords ()
    local line = io.read()
    local pos = 1
    return function ()
        while line do
            local s, e = string.find(line, "%w+", pos)
            if s then
                pos = e + 1
                return string.sub(line, s, e)
            else line = io.read()
                pos = 1
            end
        end
    end
end
for i in allwords() do
    print(i)
end

