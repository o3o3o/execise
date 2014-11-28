--slow
--local s = '' for i=1,1000 do s = s .. math.random() .. ',' end
--io.stdout:write(s)

for i=1,1000 do io.stdout:write(tostring(math.random()), ',') end

local t = {}
for i=1,1000 do t[i]=tostring(math.random()) end
io.stdout:write(table.concat(t, ','), ',')
