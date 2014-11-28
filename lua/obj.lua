local MyClass = {}
MyClass.__index = MyClass
function MyClass.new(init)
    local self = setmetatable({}, MyClass)
    self.value = init
    return self
end
function MyClass.set_value(self, newval)
    self.value = newval
end

function MyClass.get_value(self)
    return self.value
end

local i = MyClass.new(5)
print(i:get_value())
