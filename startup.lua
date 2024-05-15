local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
end

-- button.lua
local monitor = peripheral.wrap("right") -- Adjust based on monitor position
monitor.setTextScale(1)
monitor.clear()

local button = {
    x = 5,
    y = 5,
    width = 10,
    height = 3,
    label = "Click me",
    onClick = function()
        monitor.setCursorPos(1, 10)
        monitor.write("Button clicked!")
    end
}

local function drawButton(btn)
    monitor.setCursorPos(btn.x, btn.y)
    for i = 1, btn.height do
        monitor.write(string.rep(" ", btn.width))
        monitor.setCursorPos(btn.x, btn.y + i)
    end
    local labelX = btn.x + math.floor((btn.width - #btn.label) / 2)
    local labelY = btn.y + math.floor(btn.height / 2)
    monitor.setCursorPos(labelX, labelY)
    monitor.write(btn.label)
end

local function isWithinButton(x, y, btn)
    return x >= btn.x and x < btn.x + btn.width and y >= btn.y and y < btn.y + btn.height
end

drawButton(button)

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if isWithinButton(x, y, button) then
        button.onClick()
    end
end
