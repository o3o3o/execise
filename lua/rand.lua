--[[
    There are only one box that store the gift in 3 black boxes. The moderator know which is the box that have gift.
    [X] [X] [X]
    1. You choose one box randly.
    2. The moderator select the one that is empty in the rest of two boxes.
    And then, Should you select the other one box to get the gift.
]]--

--[[
--the helper function
]]
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
    return res
end


function statistic(total)
    local fail = 0
    local total = total or 300
    for i=1,total  do
        local t = { [1] = "0", [2] = "0", [3] = "0",}
        ---get randomly  BONUS
        i = math.random(1,3)
        t[i] = '1'
        --print(get_table(t))

        ---choose the one randomly
        i = math.random(1,3)
        t[i]='^'
        
        ---the moderator  select one empty BONUS
        --print(get_table(t))
        i = math.random(1,3)
        while(t[i] == '^' or t[i] == '1') do
            i = math.random(1,3)
        end
        t[i] = "-"
        --print(get_table(t))

        for j=1,#t do
            if t[j] == '1' then
                fail = fail + 1
            end
        end
        --print("===========")
    end
    print("total: "..total..",Success: " .. total-fail.." Fail:"..fail)
    print("Win Ratio: "..(total-fail)/total)
end
--[[ You Have 1/3 probablity to win,  if you didnot to choose another box  when the moderator show an empty box]]
statistic()
