local mymodule = {}
--[[
function mymodule.foo()
    print("hello world!")
end
return mymodule
]]--
local function private()
    print("in private function")
end
function mymodule.foo()
    print("hello world!")
end
function mymodule.bar()
    private()
    mymodule.foo()
end
return mymodule
