local monitor = peripheral.wrap("right")

-- Initialize monitor
monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

-- Function to draw the progress bar
local function drawProgressBar(usedSlots, totalSlots)
    local barLength = monitor.getSize()  -- Get the width of the monitor
    local filledLength = math.floor((usedSlots / totalSlots) * barLength)
    local emptyLength = barLength - filledLength

    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.setBackgroundColor(colors.green)
    monitor.write(string.rep(" ", filledLength))
    monitor.setBackgroundColor(colors.red)
    monitor.write(string.rep(" ", emptyLength))
    monitor.setBackgroundColor(colors.black)
end

-- Main loop
while true do
    -- Get the chest inventory
    local items = chest.list()

    -- Count used slots
    local usedSlots = 0
    for slot, item in pairs(items) do
        usedSlots = usedSlots + 1
    end

    -- Get total slots
    local totalSlots = chest.size()

    -- Draw the progress bar
    drawProgressBar(usedSlots, totalSlots)

    -- Wait a bit before updating
    sleep(1)
end