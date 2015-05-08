local socket = require "socket"
 host = "www.w3.org"
-- file = "/TR/REC-html132.html"

function download_single(host, file)
    local count = 0
    c = assert(socket.connect(host, 80))
    c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s , status, partial = c:receive(2^10)
        --io.write(s or partial)
        count = count + ( #s or #partial)
        print(file, "size: " ..  count)
        if(status == "closed") then break end
    end
    print(file, "size: " ..  count)
    c:close()
end
--[[
function recv(host, file)
    c = assert(socket.connect(host, 80))
    c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s , status, partial = c:receive(2^10)
        io.write(s or partial)
        return status
    end
    c:close()
end
function download(host, file)
    statusrecv(host, file)
    if(status == "closed") then break end
end
]]
threads = {}

function get(host, file)
    local co = coroutine.create(function()
        download_single(host, file)
    end)
    table.insert(threads, co)
end

function download2()
    c = assert(socket.connect(host, 80))
    c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s , status, partial = receive(c)
        io.write(s or partial)
        if(status == "closed") then break end
    end
    c:close()
end
function receive(conn)
    conn:settimeout(0)
    local s , status, partial = conn:receive(2^10)
end
function dispatch()
    local i = 1
    while true do
        if threads[i] == nil then
            i = 1
            if threads[i] == nil then break end
        else
            local status, res = coroutine.resume(threads[i])
            if not res then
                table.remove(threads, i)
            else
                i = i + 1
            end
        end
    end
end
get(host, "TR/REC-html32.html")
get(host, "TR/html1401html140.txt")
dispatch()
