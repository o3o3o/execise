--polynomial Anx^n + ..A(n-1)x^(n-1) ..
local t1 = {1,2,3,4,5}
local function polynomial_res(t, x)
    local res = 0
    if(type(t) ~= "table") then
        print("first argument is not table!")
    end
    xv = x 
    for i=1, #t do
        --print(t[i].."*"..x.."^"..i.."="..t[i]*x^i)
        --res = res + t[i]*x^i
        res = res + t[i]*xv
        xv = xv*x
        --xv = xv * xv;
    end
    return res
end
---print(polynomial_res(t2, 2))

function poly(t)
    return function(x)
        local res = 0
        if(type(t) ~= "table") then
            print("!!!!!!!!!!first argument is not table!")
            return
        end
        xv = x 
        for i=1, #t do
            print(t[i].."*"..x.."^"..i.."="..t[i]*x^i)
            --res = res + t[i]*x^i
            res = res + t[i]*xv
            xv = xv*x
            --xv = xv * xv;
        end
        return res
    end
end
