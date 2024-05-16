local monitor = peripheral.find("monitor")
if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawProgressBar(monitor, usedItems, totalSlots)
    local width, height = monitor.getSize()
    local barLength = width
    local filledLength = math.floor((usedItems / (totalSlots * 64)) * barLength)
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
    monitor.setCursorPos(1, 2)
    monitor.write(monitorWidth .. " en " .. monitorHeight)

    --if monitorWidth < 36 then
    --    monitor.setTextScale(2)
    --    monitor.clear()
    --    monitor.setCursorPos(1, 1)
    --    monitor.write("Monitor must be 6 bloxs wide")
    --    return
    --elseif monitorHeight < 13 then
    --    monitor.setTextScale(2)
    --    monitor.clear()
    --    monitor.setCursorPos(1, 1)
    --    monitor.write("Monitor must be 4 bloxs tall")
    --    return
    --end

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
        local usedItems = countItems(inventory)
        drawProgressBar(monitor, usedItems, totalSlots)
        
        monitor.setCursorPos(1, 1)
        monitor.setBackgroundColor(colors.black)
        monitor.clearLine()
        monitor.write("Total Items: " .. usedItems)
    end
    sleep(5)
end