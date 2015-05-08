local socket = require "socket"
host = "www.w3.org"
file = "/TR/REC-html132.html"

function download()
    c = assert(socket.connect(host, 80))
    c:send("GET" .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s , status, partial = c:receive(2^10)
        io.write(s or partial)
        if(status == "closed") then break end
    end
    c:close()
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
