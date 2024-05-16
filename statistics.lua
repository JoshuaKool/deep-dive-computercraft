local monitor = peripheral.find("monitor")
if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

local function drawVerticalProgressBar(monitor, usedItems, totalSlots)
    local width, height = monitor.getSize()
    local barHeight = height - 2
    local filledHeight = math.floor((usedItems / (totalSlots * 64)) * barHeight)
    local emptyHeight = barHeight - filledHeight
    local barXPos = math.floor(width / 2) 

    for y = 1, filledHeight do
        monitor.setCursorPos(barXPos, height - y - 1)
        monitor.setBackgroundColor(colors.green)
        monitor.write(" ")
    end

    for y = filledHeight + 1, barHeight do
        monitor.setCursorPos(barXPos, height - y - 1)
        monitor.setBackgroundColor(colors.red)
        monitor.write(" ")
    end

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

    if monitorWidth < 18 then
        monitor.setTextScale(2)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Must 2 bloxs wide")
        return
    elseif monitorHeight < 19 then
        monitor.setTextScale(2)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Must 3 bloxs high")
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
        local usedItems = countItems(inventory)
        drawVerticalProgressBar(monitor, usedItems, totalSlots)
        
        monitor.setCursorPos(1, 1)
        monitor.setBackgroundColor(colors.black)
        monitor.clearLine()
        monitor.write("Total Items: " .. usedItems)
    end

    sleep(5)
end