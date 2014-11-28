local function f()
    local v = 0
    local function get()
        return v
    end
    local function set(new_v)
        v = new_v
    end
    return {get = get, set = set}
end

