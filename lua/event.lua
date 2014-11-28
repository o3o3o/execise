--index
--[[
print("__index example:")
code="
x = {v=5}
mt = {
    __add = function(lhs,rhs)
        return { v = lhs.v*2 + rhs.v*2}
    end
}
setmetatable(x,mt)

y = x+x
print(y.v)
--local z = y + y"
eval code
]]--
t = {}
m = setmetatable({}, {__newindex = function(table, key, value)
    t[key] = value
    print("New key " .. key .. ": ,value: " .. value)
end})

