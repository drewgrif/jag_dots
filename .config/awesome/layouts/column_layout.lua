local awful = require("awful")
local beautiful = require("beautiful")

local column_layout = {}

function column_layout.arrange(p)
    local area = p.workarea
    local clients = p.clients
    local n = #clients

    if n == 0 then return end

    local column_width = area.width / n

    for i, c in ipairs(clients) do
        local g = {}
        g.x = area.x + (i - 1) * column_width
        g.y = area.y
        g.width = column_width
        g.height = area.height
        p.geometries[c] = g
    end
end

-- Set the name of the layout
column_layout.name = "columns"

return column_layout
