--[[  generate all permutation of array
--]]
function perm(a, n)
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

function permgen(a)
    perm(a, #a)
end
local ary = {1,2,3,4}
permgen(ary)
