
local function get_table(t)
    local res = nil
    for i=1, #t do
        --print("t["..k.."] ="..v)
        if(res) then
            res = res..t[i]
        else
            res = t[i]
        end
    end
    return res,
end


local function main()
    for i=1,3 do
        local t = { [1] = "0", [2] = "0", [3] = "0",}
        --get randomly  BONUS
        i = math.random(1,3)
        t[i] = '1'
        print(get_table(t))
        --print("---------")

        -- choose the one randomly
        i = math.random(1,3)
        t[i]='^'
        
        --the moderator  select one empty BONUS
        print(get_table(t))
        i = math.random(1,3)
        while(t[i] == '^' or t[i] == '1') do
            i = math.random(1,3)
        end
        t[i] = "-"
        print(get_table(t))
        print("===========")
    end
end

main()
