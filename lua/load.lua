--[[
print "enter your expression:"
local l = io.read()
local func = assert(load("return " .. l))
print("the value of your expression is " .. func())

local file, msg
repeat
    print "enter a file name:"
    local name= io.read()
    if not name then return end 
    file, msg = io.open(name, 'r')
    if not file then print(msg) end
until file
]]

function add(...)
    local s = 0
    for i,v in ipairs{...} do
        print("--->" .. v)
        s = s + v
    end
    return s
end

print(add(3, 4, 10, 20))
