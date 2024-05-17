local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")

if monitor == nil then
    print("No monitor found")
    return
end

monitor.setTextScale(1)
monitor.setBackgroundColor(colors.black)
monitor.clear()

if modem == nil then
    print("No modem found")
    return
end

print("Modem found")

modem.open(1)

local function drawVerticalProgressBar(monitor, usedItems, totalSlots)
    local width, height = monitor.getSize()
    local barHeight = height - 1
    local filledHeight = math.floor((usedItems / (totalSlots * 64)) * barHeight)
    local emptyHeight = barHeight - filledHeight
    local barXPos = math.floor(width / 2)

    for y = 1, filledHeight do
        monitor.setCursorPos(barXPos, height - y)
        monitor.setBackgroundColor(colors.green)
        monitor.write(" ")
    end

    for y = filledHeight + 1, barHeight do
        monitor.setCursorPos(barXPos, height - y)
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

local function findChestConnectedToModem(modem)
    local connectedPeripherals = modem.getNamesRemote()
    for _, peripheralName in ipairs(connectedPeripherals) do
        local chest = peripheral.wrap(peripheralName)
        if chest and chest.getName() == "minecraft:chest" then
            return chest
        end
    end
    return nil
end

while true do
    local chest = findChestConnectedToModem(modem)

    local monitorWidth, monitorHeight = monitor.getSize()

    if monitorWidth < 18 then
        monitor.setTextScale(0.5)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor must be at least 2 blocks wide")
        return
    elseif monitorHeight < 19 then
        monitor.setTextScale(0.5)
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor must be at least 3 blocks high")
        return
    end

    if chest == nil then
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("No chest found")
        return
    else
        local inventory = chest.list()
        local totalSlots = chest.size()
        local usedItems = countItems(inventory)
        drawVerticalProgressBar(monitor, usedItems, totalSlots)
        monitor.setTextScale(0.5)
        monitor.setCursorPos(1, 1)
        monitor.setBackgroundColor(colors.black)
        monitor.clearLine()
        monitor.write("Total items: " .. usedItems)
    end

    sleep(5)
end