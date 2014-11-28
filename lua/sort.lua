list = {{3}, {5}, {2}, {-1}}
network = {
    {name = "grauna", IP = "210.26.30.24"},
    {name = "arraial", IP = "210.26.30.23"},
    {name = "lua", IP = "210.26.23.12"},
    {name = "derain", IP = "210.26.23.20"},
}
table.sort(network, function(a,b)
    return (a.name > b.name) end)
