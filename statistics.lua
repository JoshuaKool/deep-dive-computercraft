local monitor = peripheral.find("monitor")

if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawProgressBar(monitor, usedItems, totalItems, totalSlots)
    local width, height = monitor.getSize()
    local barLength = width
    local filledLength = math.floor((usedItems / totalItems) * barLength)
    local emptyLength = barLength - filledLength

    local barYPos = math.floor(height / 2)
    monitor.setCursorPos(1, barYPos)
    monitor.setBackgroundColor(colors.green)
    monitor.write(string.rep(" ", filledLength))
    monitor.setBackgroundColor(colors.red)
    monitor.write(string.rep(" ", emptyLength))
    monitor.setBackgroundColor(colors.black)
end

local function countItems(inventory)
    local totalItems = 0
    for slot, item in pairs(inventory) do
        totalItems = totalItems + item.count
    end
    return totalItems
end

while true do
    local chest = peripheral.find("minecraft:chest")
    local barrel = peripheral.find("minecraft:barrel")

    local monitorWidth, monitorHeight = monitor.getSize()

    if monitorWidth < 36 then
        monitor.setTextScale(4)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor width is too small")
        return
    elseif monitorHeight < 13 then
        monitor.setTextScale(6)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor height is too small")
        return
    end

    if chest == nil and barrel == nil then
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("No chest or barrel found")
    else
        local inventory
        local totalSlots

        if chest then
            inventory = chest.list()
            totalSlots = chest.size()
        elseif barrel then
            inventory = barrel.list()
            totalSlots = barrel.size()
        end

        local totalItems = countItems(inventory)

        monitor.setCursorPos(1, 1)
        monitor.write("Total items: " .. totalItems)

        local usedItems = countItems(inventory)

        drawProgressBar(monitor, usedItems, totalItems, totalSlots)
    end

    sleep(5)
end