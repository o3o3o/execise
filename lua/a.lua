a = "aeiou"
b = 13 -- a number
c = function()
    print("\n\nAin't it grand")
end

d = {a,b,c} -- put them in a table
function printit(tata)
    table.unpack(tata)
    for key,value in ipairs(tata)
        do print(key, type(value))
        end
    end
printit(d)

