--[[
local count = 0
function Entry()
    count = count + 1
end
]]
local authors = {}
--local book = { }
function Entry(b)
    if b[1] then authors[b[1]]=true end
end

dofile("data")

for name in ipairs(authors)
    do
        print(name)
    end
