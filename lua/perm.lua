--[[  generate all permutation of array
--]]
function perm(a, n)
     n = n or #a
    if n <= 1 then
        print_array(a)
    else
        for i=1, n do
            a[i],a[n] = a[n],a[i]
            perm(a, n-1)
            a[i],a[n] = a[n], a[i]
        end
    end
end
function print_array(a)
    for i = 1, #a do
        io.write(a[i] .. " ")
    end
    io.write("\n")
end
--[[eg:
local ary = {1,2,3,4}
perm(ary)
]]

--[[
-- iterator version
--]]
function perm2(a, n)
     n = n or #a
    if n <= 1 then
        coroutine.yield(a)
    else
        for i=1, n do
            a[i],a[n] = a[n],a[i]
            perm(a, n-1)
            a[i],a[n] = a[n], a[i]
        end
    end
end
function permutations (a)
    local co = coroutine.create(function ()
        permgen(a) 
    end)
    return function() --iterator
        local code, res = coroutine.resume(co)
        return res
    end
end

for p in permutations({"a", "b", "c"}) do
    print_array(p)
end
